import 'package:flutter/material.dart';
import 'package:flutter_application_14/models/product_model.dart';
import 'package:flutter_application_14/pages/product_detail.dart';
import 'package:flutter_application_14/pages/test.dart';
import 'package:flutter_application_14/providers/cart_provider.dart';
import 'package:flutter_application_14/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;
  const ProductItem(this.productModel, {super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    FavouriteProvider favouriteProvider =
        Provider.of<FavouriteProvider>(context);

    bool isFavorite = favouriteProvider.items.contains(productModel);
    bool isCart = cartProvider.items.contains(productModel);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetail(
                  productModel: productModel,
                ),
              ),
            );
          },
          child: Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: productModel.color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 15),

        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Test(),
                ));
          },
          child: Text(
            productModel.name,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize:
                      Theme.of(context).textTheme.headlineMedium!.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.headlineMedium!.fontWeight,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
          ),
        ),

        const Spacer(),

        // Favorite Button
        IconButton(
          onPressed: () {
            if (isFavorite) {
              favouriteProvider.remove(productModel);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${productModel.name} removed from favorites'),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              favouriteProvider.add(productModel);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${productModel.name} added to favorites'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 25,
            color: Colors.red,
          ),
        ),

        const SizedBox(width: 15),

        // Cart Button
        IconButton(
          onPressed: () {
            if (isCart) {
              cartProvider.remove(productModel);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${productModel.name} removed from cart'),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              cartProvider.add(productModel);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${productModel.name} added to cart'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          icon: Icon(
            isCart ? Icons.shopping_cart : Icons.add_shopping_cart,
            size: 25,
            color: isCart ? Colors.red : Colors.grey,
          ),
        ),
      ],
    );
  }
}
