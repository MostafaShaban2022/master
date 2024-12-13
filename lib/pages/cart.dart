import 'package:flutter/material.dart';
import 'package:flutter_application_14/models/product_model.dart';
import 'package:flutter_application_14/providers/cart_provider.dart';
import 'package:provider/provider.dart';

final ValueNotifier<int> number = ValueNotifier(0);

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isLoading = false;

  void _payNow() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment processed successfully!'),
        backgroundColor: Colors.red,
      ),
    );
  }

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
          body: Stack(
            children: [
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
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
                          // counter
                          subtitle: ValueListenableBuilder(
                            valueListenable: productModel.quantity,
                            builder: (context, value, _) {
                              return Text(
                                '\$${(productModel.price * value).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              );
                            },
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (productModel.quantity.value > 1) {
                                    productModel.quantity.value -= 1;
                                  } else {
                                    provider.remove(productModel);
                                  }
                                  provider.notifyListeners();
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: productModel.quantity,
                                builder: (context, value, _) {
                                  return Text(
                                    '$value',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  productModel.quantity.value += 1;
                                  provider.notifyListeners();
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          onLongPress: () {
                            provider.remove(productModel);
                          },
                        );
                      },
                    ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!isCartEmpty)
                        Consumer<CartProvider>(
                          builder: (context, provider, _) {
                            return Text.rich(
                              TextSpan(
                                text: 'Total:  ',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '\$${provider.getCartTotal().toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        height: 55,
                        width: 200,
                        child: TextButton(
                          onPressed: isCartEmpty || isLoading ? null : _payNow,
                          style: TextButton.styleFrom(
                            backgroundColor: isCartEmpty || isLoading
                                ? Colors.grey
                                : Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.red,
                                    strokeWidth: 4,
                                  )
                                : const Text(
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
              ),
            ],
          ),
        );
      },
    );
  }
}
