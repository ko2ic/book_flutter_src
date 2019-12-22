import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static const MaterialColor _primary = Colors.indigo;
  static const MaterialAccentColor _accent = Colors.amberAccent;

  ThemeData data() => ThemeData(
        brightness: Brightness.light,

        /// 単独の場合 -> TextFieldの選択した時の枠線やアイコンの色(InputDecorationの色)、CircleAvatarの色、BottomNavigationのselected(Brightness.lightの場合)、dialogのButtonの色、
        primarySwatch: _primary,
//    primaryColor: primary,
//    primaryColorBrightness: Brightness.dark,
//    primaryColorLight: lightPrimary,
//    primaryColorDark: darkPrimary,
        /// 単独の場合 -> floating buttonの色, checkbox/radioのselected(Brightness.lightの場合), indicatorの矢印の色、dialogのButtonの文字色、BottomNavigationのselected(Brightness.darkの場合)
        accentColor: _accent,
//    accentColorBrightness: Brightness.dark,
//    Color canvasColor,
//    Color scaffoldBackgroundColor,
//    Color bottomAppBarColor,
//    Color cardColor,
//    Color dividerColor,
//    Color highlightColor,
//    Color splashColor,
//    InteractiveInkFeatureFactory splashFactory,
//    Color selectedRowColor,
//    Color unselectedWidgetColor,
//    Color disabledColor,
//    Color buttonColor,
        /// Dialog以外のボタンに影響を与える。インスタンスしただけの場合は、ボタンの色がprimary colorになる
        buttonTheme: const ButtonThemeData(
          /// Dialog以外のボタンの文字色に影響を与える。RaisedButtonの場合にprimaryを指定するとBrightnessの色になる
          textTheme: ButtonTextTheme.primary,
//    this.minWidth = 88.0,
//    this.height = 36.0,
//    EdgeInsetsGeometry padding,
          shape: RoundedRectangleBorder(
            /// Dialog以外のボタンの角に影響を与えることができる
            borderRadius: BorderRadius.all(Radius.circular(24)),

            /// Dialog以外＋OutlineButton以外ののボタンの枠線の色に影響を与える。FlatButtonに枠線が付いてしまう。
            //side: BorderSide(color: Colors.red),
          ),
//    this.layoutBehavior = ButtonBarLayoutBehavior.padded,
//    this.alignedDropdown = false,
          /// RaisedButtonの色にだけ影響を与える
          //buttonColor: accent,
//    Color disabledColor,
//    highlightColor: accentHighlight,
//    splashColor: accentSplash,
//    colorScheme: ColorScheme.light().copyWith(
//      primary: primary,
//      Color primaryVariant,
          /// OutlineButtonの中の文字色に影響
//      secondary: accent,
//      Color secondaryVariant,
//      Color surface,
//      Color background,
//      Color error,
//      Color onPrimary,
//      Color onSecondary,
//      Color onSurface,
//      Color onBackground,
//      Color onError,
//      Brightness brightness,
//    ),
//    MaterialTapTargetSize materialTapTargetSize,
        ),
//    Color secondaryHeaderColor,
//    Color textSelectionColor,
//    Color cursorColor,
//    Color textSelectionHandleColor,
//    Color backgroundColor,
//    Color dialogBackgroundColor,
//    Color indicatorColor,
//    hintColor: accent,
//    Color errorColor,
//    Color toggleableActiveColor,
//    String fontFamily,
//    textTheme: const TextTheme().copyWith(
//      button: const TextStyle(
//        color: Colors.white,
//      ),
//    ),

        primaryTextTheme: const TextTheme().copyWith(
          /// appBarのタイトルの色が変わる
          title: const TextStyle().copyWith(
            color: Colors.teal,
          ),
        ),
//    accentTextTheme: commonTextTheme,
        inputDecorationTheme: InputDecorationTheme(
          /// InputDecorationの枠線の色が変わる（これがなければ、lightやdartの枠線の色）。利用しているwidgetでUnderlineInputBorderを使っていても、ここで設定してものに変更される
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),

          /// フォーカスされた時のInputDecorationの枠線の色が変わる（これがなければ、primary color）TODO フォーカスされた時のアイコンの色を変える方法が不明
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
          ),

          /// filed:trueの場所の色を設定できる。
          fillColor: Colors.orange.shade50,
          labelStyle: const TextStyle(
            /// InputDecorationのlabelTextの色が変わる（これがなければprimary color）
            color: Colors.orange,
          ),
        ),

        /// 普通のiconのテーマを変えられる（これをしないとlightやdarkの色が使われる）
        iconTheme: const IconThemeData.fallback().copyWith(
          color: _accent,
        ),
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          /// AppBarなどで利用しているアイコン
          color: Colors.greenAccent,
        ),
        accentIconTheme: const IconThemeData.fallback().copyWith(
          /// FloatingActionButtonのアイコン色
          color: Colors.red,
        ),
//    SliderThemeData sliderTheme,
//    TabBarTheme tabBarTheme,
//    CardTheme cardTheme,
//    ChipThemeData chipTheme,
//    TargetPlatform platform,
//    MaterialTapTargetSize materialTapTargetSize,
//    PageTransitionsTheme pageTransitionsTheme,
//    AppBarTheme appBarTheme,
//    BottomAppBarTheme bottomAppBarTheme,
        colorScheme: ColorScheme.fromSwatch(
          /// これを書くとdialogのボタンの色が変わる。
          /// RaisedButtonのtextStyleの色を変えないとdialogの中のRaisedButtonの文字色もこの色になってしますので注意。
          /// ButtonTheme.barでインスタンスされているため
          /// 使うところで、RaisedButton(textTheme: Theme.of(context).buttonTheme.textTheme,
          primarySwatch: _primary,
        ).copyWith(
//      Color primaryVariant,
//      secondary: primary,
//      Color secondaryVariant,
//      Color surface,
//      Color background,
//      Color error,
//      Color onPrimary,
//      Color onSecondary,
          /// OutlineButtonの枠線の色。注意すべきは、この色に.withOpacity(0.12)をした色になる。disableボタンもprimaryに合わせた色になってくれる
          onSurface: _primary,
//      Color onBackground,
//      Color onError,
//      brightness: Brightness.light,
        ),
        dialogTheme: DialogTheme(

            /// dialogのタイトルを変える
            titleTextStyle: TextStyle(
          color: Colors.deepOrange,
        )),
//    Typography typography,
//    CupertinoThemeData cupertinoOverrideTheme,
        snackBarTheme: SnackBarThemeData(
          actionTextColor: Colors.white,
        ),
//    BottomSheetThemeData bottomSheetTheme,
//    PopupMenuThemeData popupMenuTheme,
//    MaterialBannerThemeData bannerTheme,
//    DividerThemeData dividerTheme,
      );
}

class MyDarkTheme {
  static const MaterialColor _primary = Colors.indigo;
  static const MaterialAccentColor _accent = Colors.amberAccent;

  ThemeData data() => ThemeData(
        brightness: Brightness.dark,
      );
}
