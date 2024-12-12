import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale('en', LocaleData.En),
  MapLocale('ar', LocaleData.Ar),
];

mixin LocaleData {
  static const Map<String, dynamic> En = {
    'title': 'localization',
    'body': 'Laptop',
  };

  static const Map<String, dynamic> Ar = {
    'title': 'ترجمة',
    'body': 'لاب توب',
  };
}
