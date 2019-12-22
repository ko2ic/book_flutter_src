import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class L10N {
  const L10N._internal();

  static L10N of(BuildContext context) {
    return Localizations.of<L10N>(context, L10N);
  }

  static Future<L10N> load(Locale locale) async {
    final name = locale.countryCode == null || locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    await initializeMessages(localeName);

    Intl.defaultLocale = localeName;
    return const L10N._internal();
  }

  // 以下に多言語対応したいキーと英語の文言を記述していく

  String get pageTitleMyApp => Intl.message(
        'Flutter Demo',
        name: 'pageTitleMyApp',
        desc: 'MyAppのappbarのtitle文言', // オプション
      );
}
