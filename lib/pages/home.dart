import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_application_14/models/product_model.dart';
import 'package:flutter_application_14/pages/cart.dart';
import 'package:flutter_application_14/pages/favourite.dart';
import 'package:flutter_application_14/pages/notifications.dart';
import 'package:flutter_application_14/providers/cart_provider.dart';
import 'package:flutter_application_14/providers/favourite_provider.dart';
import 'package:flutter_application_14/providers/ui_provider.dart';
import 'package:flutter_application_14/widgets/product_item.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    Widget header() {
      final notifier = Provider.of<UiProvider>(context);
      return Container(
        margin: const EdgeInsets.only(top: 25, right: 10, left: 10),
        child: Row(children: [
          const Expanded(
            child: ListTile(
              leading: Icon(
                Icons.dark_mode,
              ),
            ),
          ),
          Switch(
            value: notifier.isDark,
            activeColor: Colors.red,
            onChanged: (value) => notifier.changeTheme(),
          ),

          const Spacer(),

          // notifications
          badges.Badge(
            badgeContent: Text(
              '$value',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            position: badges.BadgePosition.topStart(start: 4, top: -2),
            showBadge: true,
            ignorePointer: false,
            badgeAnimation: const badges.BadgeAnimation.slide(
              toAnimate: true,
              animationDuration: Duration(seconds: 2),
            ),
            badgeStyle: const badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              badgeColor: Colors.red,
              padding: EdgeInsets.all(4),
              elevation: 0,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Notifications(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.grey,
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),

          // favourite
          Consumer<FavouriteProvider>(
            builder: (context, favouriteProvider, child) {
              return badges.Badge(
                badgeContent: Text(
                  '${favouriteProvider.itemCount}', // Get the item count directly from the provider
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                position: badges.BadgePosition.topStart(start: -1, top: -2),
                showBadge: favouriteProvider.itemCount >
                    0, // Show badge only if there are items
                ignorePointer: false,
                badgeAnimation: const badges.BadgeAnimation.slide(
                  toAnimate: true,
                  animationDuration: Duration(seconds: 2),
                ),
                badgeStyle: const badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.red,
                  padding: EdgeInsets.all(4),
                  elevation: 0,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Favourite(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
              );
            },
          ),

          const SizedBox(width: 10),

          // cart
          Consumer<CartProvider>(
            builder: (context, favouriteProvider, child) {
              return badges.Badge(
                badgeContent: Text(
                  '${favouriteProvider.itemCount}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                position: badges.BadgePosition.topStart(start: 1, top: -2),
                showBadge: favouriteProvider.itemCount > 0,
                ignorePointer: false,
                badgeAnimation: const badges.BadgeAnimation.slide(
                  toAnimate: true,
                  animationDuration: Duration(seconds: 2),
                ),
                badgeStyle: const badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.red,
                  padding: EdgeInsets.all(4),
                  elevation: 0,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Cart(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_bag,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
              );
            },
          ),
        ]),
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.only(top: 25, right: 30, left: 30),
        child: Column(
          children: [
            ProductItem(
              ProductModel(
                id: 1,
                name: 'Laptop',
                color: Colors.red,
                price: 80,
              ),
            ),
            ProductItem(
              ProductModel(
                id: 2,
                name: 'Mobile',
                color: Colors.green,
                price: 60,
              ),
            ),
            ProductItem(
              ProductModel(
                id: 3,
                name: 'Computer',
                color: Colors.yellow,
                price: 70,
              ),
            ),
            ProductItem(
              ProductModel(
                id: 4,
                name: 'Coffee Machine',
                color: Colors.orange,
                price: 10,
              ),
            ),
            ProductItem(
              ProductModel(
                id: 5,
                name: 'imac 3',
                color: Colors.brown,
                price: 100,
              ),
            ),
            ProductItem(
              ProductModel(
                id: 6,
                name: 'kettle',
                color: Colors.pink,
                price: 90,
              ),
            ),
            ProductItem(
              ProductModel(
                id: 5,
                name: 'macbook',
                color: Colors.purple,
                price: 40,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            content(),
          ],
        ),
      ),
    );
  }
}