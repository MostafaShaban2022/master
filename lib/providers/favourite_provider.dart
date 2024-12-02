import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_14/models/product_model.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<ProductModel> _items = [];
  List<ProductModel> get items => _items;
  int get itemCount => _items.length;

  FavouriteProvider() {
    _loadFavourites();
  }

  void add(ProductModel item) {
    _items.add(item);
    _saveFavourites();
    notifyListeners();
  }

  void remove(ProductModel item) {
    _items.remove(item);
    _saveFavourites();
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    _saveFavourites();
    notifyListeners();
  }

  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favData = prefs.getString('favourites');
    if (favData != null) {
      final List<dynamic> decodedData = jsonDecode(favData);
      _items.clear();
      _items.addAll(decodedData.map((item) => ProductModel(
            id: item['id'],
            name: item['name'],
            color: Color(item['color']),
            price: item['price'],
          )));
      notifyListeners();
    }
  }

  Future<void> _saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      _items
          .map((item) => {
                'id': item.id,
                'name': item.name,
                'color': item.color.value,
                'price': item.price,
              })
          .toList(),
    );
    await prefs.setString('favourites', encodedData);
  }
}
