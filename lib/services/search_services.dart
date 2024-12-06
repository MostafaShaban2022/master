import 'package:flutter/material.dart';
import 'package:flutter_application_14/models/product_model.dart';

class SearchServices extends SearchDelegate<String> {
  final List<ProductModel> products;

  SearchServices(this.products);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('\$${product.price}'),
          leading: Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: product.color),
          ),
          onTap: () {
            close(context, product.name);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          title: Text(product.name),
          leading: Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: product.color),
          ),
          onTap: () {
            query = product.name;
            showResults(context);
          },
        );
      },
    );
  }
}
