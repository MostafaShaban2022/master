import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  late SharedPreferences storage;

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    primaryColorDark: Colors.white,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black26,
    primaryColor: Colors.black12,
    primaryColorDark: Colors.black12,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );

  changeTheme() {
    _isDark = !_isDark;
    storage.setBool('isDark', _isDark);
    notifyListeners();
  }

  init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark') ?? false;
    notifyListeners();
  }
}
