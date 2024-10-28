import 'dart:convert';
import 'package:flutter_application_1/model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = "https://ourworks.co.in/sigofish-backend/public/customer";
  final String token = '208|PSdgfNi58S1qupatJAGm8xzZYcY5zqjvVypQ6BKx'; 

  Future<ProductResponse?> fetchProductDetails({required int productId, required int storeId}) async {
    final url = Uri.parse('$baseUrl/products/details?product_id=$productId&store_id=$storeId');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token', 
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ProductResponse.fromJson(data);
      } else {
        print('Failed to load product details: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching product details: $error');
    }
    return null;
  }
}
