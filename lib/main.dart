import 'package:flutter/material.dart';
import 'package:flutter_application_14/pages/home.dart';
import 'package:flutter_application_14/pages/log_in.dart';
import 'package:flutter_application_14/pages/log_up.dart';
import 'package:flutter_application_14/providers/cart_provider.dart';
import 'package:flutter_application_14/providers/favourite_provider.dart';
import 'package:flutter_application_14/providers/ui_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavouriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UiProvider()..init(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<UiProvider>();
    return MaterialApp(
      theme: notifier.lightTheme,
      darkTheme: notifier.darkTheme,
      themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const LogIn(),
    );
  }
}
