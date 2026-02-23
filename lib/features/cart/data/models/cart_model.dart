import '../../domain/entities/cart_entity.dart';

class CartModel {
  final int id;
  final String title;
  final String image;
  final int quantity;
  final double price;

  CartModel({
    required this.id,
    required this.title,
    required this.image,
    required this.quantity,
    required this.price,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      title: json['title'],
      image: json['image'] ?? '',
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'quantity': quantity,
      'price': price,
    };
  }

  CartModel copyWith({
    int? id,
    String? title,
    String? image,
    int? quantity,
    double? price,
  }) {
    return CartModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      id: id,
      title: title,
      image: image,
      quantity: quantity,
      price: price,
    );
  }
}
