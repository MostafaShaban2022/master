import 'package:flutter/material.dart';
import 'package:flutter_application_14/models/product_model.dart';
import 'package:flutter_application_14/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Center(
              child: Text(
                'Favourite Products',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize:
                          Theme.of(context).textTheme.headlineMedium!.fontSize,
                      fontWeight: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .fontWeight,
                      color: Theme.of(context).textTheme.headlineMedium!.color,
                    ),
              ),
            ),
          ),
          body: provider.items.isEmpty
              ? Center(
                  child: Text(
                    'No products.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .fontSize,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .fontWeight,
                          color:
                              Theme.of(context).textTheme.headlineMedium!.color,
                        ),
                  ),
                )
              : ListView.builder(
                  itemCount: provider.items.length,
                  itemBuilder: (context, index) {
                    ProductModel productModel = provider.items[index];
                    return ListTile(
                      leading: Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: productModel.color,
                          borderRadius:
                              BorderRadius.circular(8), // rounded corners
                        ),
                      ),
                      title: Text(
                        productModel.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .fontSize,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .fontWeight,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .color,
                            ),
                      ),
                      subtitle: Text(
                        '\$${productModel.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      onLongPress: () {
                        provider.remove(productModel);
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
