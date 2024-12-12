import 'package:flutter/material.dart';
import 'package:flutter_application_14/models/product_model.dart';

class ProductDetail extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetail({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            productModel.name,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: productModel.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productModel.name,
                  ),
                  Text(
                    '\$${productModel.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      size: 25,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
