import '../models/product_model.dart';
import 'services/api_service.dart';

class ProductService {
  static Future<List<Product>> getProducts() async {
    final response = await ApiService.get('/products');
    
    if (response['success'] == true) {
      final List<dynamic> data = response['data'];
      return data.map((json) => Product.fromJson(json)).toList();
    }
    
    throw Exception(response['message'] ?? 'Failed to load products');
  }
  
  static Future<Product> getProduct(int id) async {
    final response = await ApiService.get('/products/$id');
    
    if (response['success'] == true) {
      return Product.fromJson(response['data']);
    }
    
    throw Exception(response['message'] ?? 'Failed to load product');
  }
  
  static Future<Product> createProduct(Product product) async {
    final response = await ApiService.post('/products', product.toJson());
    
    if (response['success'] == true) {
      return Product.fromJson(response['data']);
    }
    
    throw Exception(response['message'] ?? 'Failed to create product');
  }
  
  static Future<Product> updateProduct(int id, Product product) async {
    final response = await ApiService.put('/products/$id', product.toJson());
    
    if (response['success'] == true) {
      return Product.fromJson(response['data']);
    }
    
    throw Exception(response['message'] ?? 'Failed to update product');
  }
  
  static Future<void> deleteProduct(int id) async {
    final response = await ApiService.delete('/products/$id');
    
    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to delete product');
    }
  }
}
