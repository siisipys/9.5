import 'user_model.dart';

class Product {
  final int? id;
  final int userId;
  final String name;
  final String? description;
  final double price;
  final int stock;
  final String? image;
  final User? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.price,
    required this.stock,
    this.image,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      stock: json['stock'] ?? 0,
      image: json['image'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'image': image,
    };
  }

  Product copyWith({
    int? id,
    int? userId,
    String? name,
    String? description,
    double? price,
    int? stock,
    String? image,
    User? user,
  }) {
    return Product(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      image: image ?? this.image,
      user: user ?? this.user,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
