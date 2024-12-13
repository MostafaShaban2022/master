import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_14/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _items = [];
  List<ProductModel> get items => _items;
  int get itemCount => _items.length;

  CartProvider() {
    _loadCart();
  }

  void add(ProductModel item) {
    _items.add(item);
    _saveCart();
    notifyListeners();
  }

  void remove(ProductModel item) {
    _items.remove(item);
    _saveCart();
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }

  double getCartTotal() {
    return _items.fold(0, (total, item) {
      return total + (item.price * item.quantity.value);
    });
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartData = prefs.getString('cart');
    if (cartData != null) {
      final List<dynamic> decodedData = jsonDecode(cartData);
      _items.clear();
      _items.addAll(decodedData.map((item) => ProductModel(
            id: item['id'],
            name: item['name'],
            color: Color(item['color']),
            price: item['price'],
            initialQuantity: item['quantity'],
          )));
      notifyListeners();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      _items
          .map((item) => {
                'id': item.id,
                'name': item.name,
                'color': item.color.value,
                'price': item.price,
                'quantity': item.quantity.value,
              })
          .toList(),
    );
    await prefs.setString('cart', encodedData);
  }
}
