import 'package:flutter/material.dart';
import 'package:flutter_application_14/localization/locales.dart';
import 'package:flutter_application_14/pages/home.dart';
import 'package:flutter_application_14/providers/cart_provider.dart';
import 'package:flutter_application_14/providers/favourite_provider.dart';
import 'package:flutter_application_14/providers/ui_provider.dart';
import 'package:flutter_localization/flutter_localization.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  @override
  void initState() {
    configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<UiProvider>();
    return MaterialApp(
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      theme: notifier.lightTheme,
      darkTheme: notifier.darkTheme,
      themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }

  void configureLocalization() {
    localization.init(
      mapLocales: LOCALES,
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }
}
