import 'package:flutter/material.dart';

class ProductModel {
  int id;
  String name;
  Color color;
  double price;
  ValueNotifier<int> quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.color,
    required this.price,
    int initialQuantity = 1,
  }) : quantity = ValueNotifier<int>(initialQuantity);
  void updateQuantity(int newQuantity) {
    quantity.value = newQuantity;
  }

  // Convert ProductModel to JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
      'price': price,
    };
  }

  // Create a ProductModel instance from a JSON-compatible map
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      color: Color(json['color']), // Convert integer back to Color
      price: json['price'],
    );
  }
}
