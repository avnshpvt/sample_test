import 'package:flutter/material.dart';
import 'package:flutter_application_1/api.dart';
import 'package:flutter_application_1/model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final int storeId;

  ProductDetailsScreen({required this.productId, required this.storeId});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Future<ProductResponse?> _productResponse;

  @override
  void initState() {
    super.initState();
    _productResponse = ProductService().fetchProductDetails(
      productId: widget.productId,
      storeId: widget.storeId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<ProductResponse?>(
        future: _productResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No product details found.'));
          }

          final productResponse = snapshot.data!;
          final product = productResponse.data.product;
          final relatedProducts = productResponse.data.related;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network("https://5.imimg.com/data5/SELLER/Default/2023/11/357766144/GS/BQ/WG/201826002/yellow-fin-tuna-whole-1000x1000.webp",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBarSection(),
                        Expanded(
                          child: TabBarView(
                            children: [
                              ListView(
                                padding: const EdgeInsets.all(16.0),
                                children: [
                                  const SizedBox(height: 8),
                                  for (var cuttingType in product.cuttingTypes)
                                    ProductItem(
                                      name: cuttingType.type,
                                      weight: "Net: ${cuttingType.netWeight}",
                                      oldPrice: double.parse(cuttingType.originalPrice),
                                      newPrice: double.parse(cuttingType.offerPrice),
                                      cuttingImage: cuttingType.cuttingImage,
                                    ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Related Products",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  RelatedProductsSection(relatedProducts: relatedProducts),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Price:-",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500 ),),
                                    Text(
                                      product.price,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 15,),
                                    Text("Description:-",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500 ),),
                                    SizedBox(height: 8,),
                                    Text(
                                      product.description,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TabBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TabBar(
          indicatorColor: Colors.red,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "Customize"),
            Tab(text: "About"),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String weight;
  final double oldPrice;
  final double newPrice;
  final String cuttingImage;

  ProductItem({
    required this.name,
    required this.weight,
    required this.oldPrice,
    required this.newPrice,
    required this.cuttingImage, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Image.network(cuttingImage), 
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(weight),
            Row(
              children: [
                Text(
                  "₹${oldPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8),
                Text("₹${newPrice.toStringAsFixed(2)}", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text("ADD"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class RelatedProductsSection extends StatelessWidget {
  final List<RelatedProduct> relatedProducts;

  RelatedProductsSection({required this.relatedProducts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 213,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: relatedProducts.length,
        itemBuilder: (context, index) {
          final relatedProduct = relatedProducts[index];
          return RelatedProductItem(
            name: relatedProduct.productName,
            weight: "Net: ${relatedProduct.netWeight}",
            oldPrice: double.parse(relatedProduct.originalPrice),
            newPrice: double.parse(relatedProduct.offerPrice ?? '0'),
            productImage: relatedProduct.productImage,
          );
        },
      ),
    );
  }
}

class RelatedProductItem extends StatelessWidget {
  final String name;
  final String weight;
  final double oldPrice;
  final double newPrice;
  final String productImage;

  RelatedProductItem({
    required this.name,
    required this.weight,
    required this.oldPrice,
    required this.newPrice,
    required this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 190,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(productImage, height: 100, width: 100), 
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(weight, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Row(
                    children: [
                      Text(
                        "₹${oldPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text("₹${newPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 12, color: Colors.red)),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("ADD", style: TextStyle(fontSize: 10)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
