import 'package:flutter/material.dart';
import 'package:flutter_application_14/models/product_model.dart';
import 'package:flutter_application_14/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, _) {
        bool isCartEmpty = provider.items.isEmpty;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            flexibleSpace: Center(
              child: Text(
                'Your Cart',
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
          body: Stack(children: [
            provider.items.isEmpty
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
                            color: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .color,
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                          '\$${productModel.price.toStringAsFixed(2)}', // Product price
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
            Positioned(
              bottom: 25,
              left: 105,
              child: Column(
                children: [
                  // Show total price only if the cart is not empty
                  if (!isCartEmpty)
                    Text(
                      'Total: \$${provider.getCartTotal().toStringAsFixed(2)}',
                    ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: 55,
                    width: 200,
                    child: TextButton(
                      onPressed: isCartEmpty ? null : () {},
                      style: TextButton.styleFrom(
                        backgroundColor: isCartEmpty ? Colors.grey : Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
