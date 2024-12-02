import 'dart:ui';

class ProductModel {
  int id;
  String name;
  Color color;
  double price;

  ProductModel({
    required this.id,
    required this.name,
    required this.color,
    required this.price,
  });

  // Convert ProductModel to JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value, // Save color as an integer value
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
