import 'package:flutter/material.dart';

import 'l10n.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<L10N> {
  const MyLocalizationsDelegate._internal();

  static const LocalizationsDelegate<L10N> delegate = MyLocalizationsDelegate._internal();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<L10N> load(Locale locale) => L10N.load(locale);

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
