class ProductResponse {
  final bool status;
  final ProductData data;
  final String message;

  ProductResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      status: json['status'],
      data: ProductData.fromJson(json['data']),
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class ProductData {
  final Product product;
  final List<RelatedProduct> related;

  ProductData({
    required this.product,
    required this.related,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      product: Product.fromJson(json['product']),
      related: (json['related'] as List)
          .map((item) => RelatedProduct.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'related': related.map((item) => item.toJson()).toList(),
    };
  }
}

class Product {
  final int id;
  final String name;
  final String price;
  final String image;
  final String description;
  final String storageInstructions;
  final String? serves;
  final int categoryId;
  final String stock;
  final List<CuttingType> cuttingTypes;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.storageInstructions,
    this.serves,
    required this.categoryId,
    required this.stock,
    required this.cuttingTypes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      description: json['description'],
      storageInstructions: json['storage_instructions'],
      serves: json['serves'],
      categoryId: json['category_id'],
      stock: json['stock'],
      cuttingTypes: (json['cutting_types'] as List)
          .map((item) => CuttingType.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'storage_instructions': storageInstructions,
      'serves': serves,
      'category_id': categoryId,
      'stock': stock,
      'cutting_types': cuttingTypes.map((item) => item.toJson()).toList(),
    };
  }
}

class CuttingType {
  final int id;
  final int productId;
  final int cuttingTypeId;
  final String type;
  final String cuttingImage;
  final String netWeight;
  final String grossWeight;
  final String originalPrice;
  final String offerPrice;
  final String offerPercentage;

  CuttingType({
    required this.id,
    required this.productId,
    required this.cuttingTypeId,
    required this.type,
    required this.cuttingImage,
    required this.netWeight,
    required this.grossWeight,
    required this.originalPrice,
    required this.offerPrice,
    required this.offerPercentage,
  });

  factory CuttingType.fromJson(Map<String, dynamic> json) {
    return CuttingType(
      id: json['id'],
      productId: json['product_id'],
      cuttingTypeId: json['cutting_type_id'],
      type: json['type'],
      cuttingImage: json['cutting_image'],
      netWeight: json['net_weight'],
      grossWeight: json['gross_weight'],
      originalPrice: json['original_price'],
      offerPrice: json['offer_price'],
      offerPercentage: json['offer_percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'cutting_type_id': cuttingTypeId,
      'type': type,
      'cutting_image': cuttingImage,
      'net_weight': netWeight,
      'gross_weight': grossWeight,
      'original_price': originalPrice,
      'offer_price': offerPrice,
      'offer_percentage': offerPercentage,
    };
  }
}

class RelatedProduct {
  final int id;
  final String productName;
  final String productImage;
  final int cuttingTypeId;
  final String type;
  final String cuttingImage;
  final String netWeight;
  final String grossWeight;
  final String originalPrice;
  final String? offerPrice;
  final String? offerPercentage;
  final String stock;
  final int categoryId;

  RelatedProduct({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.cuttingTypeId,
    required this.type,
    required this.cuttingImage,
    required this.netWeight,
    required this.grossWeight,
    required this.originalPrice,
    this.offerPrice,
    this.offerPercentage,
    required this.stock,
    required this.categoryId,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      id: json['id'],
      productName: json['product_name'],
      productImage: json['product_image'],
      cuttingTypeId: json['cutting_type_id'],
      type: json['type'],
      cuttingImage: json['cutting_image'],
      netWeight: json['net_weight'],
      grossWeight: json['gross_weight'],
      originalPrice: json['original_price'],
      offerPrice: json['offer_price'],
      offerPercentage: json['offer_percentage'],
      stock: json['stock'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'product_image': productImage,
      'cutting_type_id': cuttingTypeId,
      'type': type,
      'cutting_image': cuttingImage,
      'net_weight': netWeight,
      'gross_weight': grossWeight,
      'original_price': originalPrice,
      'offer_price': offerPrice,
      'offer_percentage': offerPercentage,
      'stock': stock,
      'category_id': categoryId,
    };
  }
}
