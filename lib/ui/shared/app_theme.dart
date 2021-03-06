import 'package:flutter/material.dart';

class AppTheme {

  /// Simple theme generated with https://rxlabz.github.io/panache_web/#/
  static final lightTheme = ThemeData(
    primarySwatch: const MaterialColor(4287979687, {
      50: Color(0xfff4eff6),
      100: Color(0xffe9deed),
      200: Color(0xffd3bddb),
      300: Color(0xffbd9dc8),
      400: Color(0xffa77cb6),
      500: Color(0xff925ba4),
      600: Color(0xff744983),
      700: Color(0xff573762),
      800: Color(0xff3a2442),
      900: Color(0xff1d1221)
    }),
    brightness: Brightness.light,
    primaryColor: const Color(0xff9560a7),
    primaryColorBrightness: Brightness.light,
    primaryColorLight: const Color(0xffe9deed),
    primaryColorDark: const Color(0xff7e4b89),
    canvasColor: const Color(0xfff4eef9),
    scaffoldBackgroundColor: const Color(0xfff4edf8),
    bottomAppBarColor: const Color(0xfffffbff),
    cardColor: const Color(0xfffffbff),
    dividerColor: const Color(0xff9560a7),
    highlightColor: const Color(0xfff1a2f9),
    splashColor: const Color(0xfff4edf8),
    selectedRowColor: const Color(0xfffffcff),
    unselectedWidgetColor: const Color(0xff7e4c8a),
    disabledColor: const Color(0xffd7c8d5),
    toggleableActiveColor: const Color(0xff7d4c8a),
    secondaryHeaderColor: const Color(0xfff4eff6),
    backgroundColor: const Color(0xffd3bddb),
    dialogBackgroundColor: const Color(0xfffffcff),
    indicatorColor: const Color(0xff925ba4),
    hintColor: const Color(0xff9560a7),
    errorColor: const Color(0xffd32f2f),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      minWidth: 88,
      height: 36,
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xff000000),
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      alignedDropdown: true,
      buttonColor: Color(0xff945fa7),
      disabledColor: Color(0xffd7c9d5),
      highlightColor: Color(0x00000000),
      splashColor: Color(0xfffffcff),
      focusColor: Color(0x1f000000),
      hoverColor: Color(0x0a000000),
      colorScheme: ColorScheme(
        primary: Color(0xff9560a7),
        primaryVariant: Color(0xff573762),
        secondary: Color(0xff925ba4),
        secondaryVariant: Color(0xff573762),
        surface: Color(0xffffffff),
        background: Color(0xffd3bddb),
        error: Color(0xffd32f2f),
        onPrimary: Color(0xffffffff),
        onSecondary: Color(0xffffffff),
        onSurface: Color(0xff000000),
        onBackground: Color(0xffffffff),
        onError: Color(0xffffffff),
        brightness: Brightness.light,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: Color(0xff9560a7),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      helperStyle: TextStyle(
        color: Color(0xff9560a7),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      hintStyle: TextStyle(
        color: Color(0xffc779cc),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorStyle: TextStyle(
        color: Color(0xffb77d8f),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorMaxLines: null,
      isDense: false,
      contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
      isCollapsed: false,
      prefixStyle: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      suffixStyle: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      counterStyle: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      filled: true,
      fillColor: Color(0xfffffcff),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff000000),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xff9560a7),
      opacity: 1,
      size: 24,
    ),
    primaryIconTheme: const IconThemeData(
      color: Color(0xfff4eef9),
      opacity: 1,
      size: 24,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Color(0xfff3eef9),
      unselectedLabelColor: Color(0xffb7a7c5),
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xff000000),
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      ),
    ),
  );
}
