import 'package:ace_player/page/home.page.dart';
import 'package:ace_player/page/splash.page.dart';
import 'package:ace_player/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppConfigs {
  static final AppConfigs _singleton = AppConfigs._internal();
  factory AppConfigs() {
    return _singleton;
  }
  AppConfigs._internal();

  // General variables
  static const String appTitle = 'AcePlayer';
  static const String baseApiUrl = 'xxx';
  static const String baseUrl = 'xxxx';
  static const String version = '1.0.0';
  static const String privacyLink = 'http://asbrothers.ca/privacy';
  static const String termsLink = 'http://asbrothers.ca/terms';
  static const String buyMeCoffeLink =
      'https://www.buymeacoffee.com/asbrothers';

  // App routes and pages
  static List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => SplashPage()),
    GetPage(name: AppRoutes.main, page: () => HomePage()),
  ];

  // Main Theme & data
  static ThemeData appThemeData = ThemeData(
      primarySwatch: Colors.deepPurple,
      buttonTheme: const ButtonThemeData(
          colorScheme: ColorScheme.light(onPrimary: Colors.white)),
      fontFamily: 'Nunito',
      textTheme: _appTextTheme,
      inputDecorationTheme: InputDecorationTheme(
        border: _outlineInputBorder,
        isDense: true,
        filled: true,
        enabledBorder: _outlineInputBorder,
        errorBorder: _outlineInputBorder,
        disabledBorder: _outlineInputBorder,
        // focusedBorder: _outlineInputBorder,
        // focusedErrorBorder: _outlineInputBorder,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: AppColors.scaffoldBackground),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.scaffoldBackground,
      ),
      appBarTheme: AppBarTheme(backgroundColor: AppColors.scaffoldBackground));

  static ThemeData appThemeDarkData = ThemeData(
      primarySwatch: Colors.lightBlue,
      fontFamily: 'Nunito',
      textTheme: _appTextTheme,
      inputDecorationTheme: InputDecorationTheme(
        border: _outlineInputBorder,
        isDense: true,
        filled: true,
        enabledBorder: _outlineInputBorder,
        errorBorder: _outlineInputBorder,
        disabledBorder: _outlineInputBorder,
        // focusedBorder: _outlineInputBorder,
        // focusedErrorBorder: _outlineInputBorder,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldDarkBackground,
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.scaffoldDarkBackground),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.scaffoldDarkBackground,
      ),
      appBarTheme:
          AppBarTheme(backgroundColor: AppColors.scaffoldDarkBackground));

  static const TextTheme _appTextTheme = TextTheme();
  static final InputBorder _outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(
          width: 1, color: const Color(0xff000000).withOpacity(0.25)));

  // Storage Keys
  static String storageKeyMusics = 'STORAGE_KEY_MUSICS';
  static String storageKeyPlayLists = 'STORAGE_KEY_PLAYLISTS';
  static String storageKeyDarkMod = 'STORAGE_KEY_DARK_MOD';
}

class AppColors {
  AppColors._();

  static Color mainBlue = const Color(0xff1877F2);
  static Color mainGreen = const Color(0xff14AC59);
  static Color mainRed = const Color(0xffD80027);
  static Color lightGrey = const Color(0xffF3F3F3);
  static Color grey = const Color(0xffcccccc);
  static Color medGrey = const Color.fromARGB(255, 223, 223, 223);
  static Color darkGrey = const Color(0xff606060);
  static Color textBlackColor = const Color(0xff040921);
  static Color scaffoldBackground = const Color(0xffFAFAFA);
  static Color scaffoldDarkBackground = const Color.fromARGB(255, 46, 46, 46);

  static LinearGradient blueGreenLightGradient = LinearGradient(colors: [
    AppColors.mainBlue.withOpacity(0.08),
    AppColors.mainGreen.withOpacity(0.08)
  ]);

  static LinearGradient blueGreenGradient =
      LinearGradient(colors: [AppColors.mainBlue, AppColors.mainGreen]);

  static BoxShadow lightShadow1 = BoxShadow(
      color: Colors.grey.withOpacity(0.1),
      spreadRadius: 3,
      blurRadius: 5,
      offset: const Offset(0, 2));
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle headline1 = TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w800,
      color: AppColors.textBlackColor);

  static TextStyle headline2 = TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w800,
      color: AppColors.textBlackColor);

  static TextStyle headline3 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: AppColors.textBlackColor);

  static TextStyle headline4 = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w800,
      color: AppColors.textBlackColor);

  static TextStyle caption1 = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: AppColors.textBlackColor);

  static TextStyle caption2 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textBlackColor);

  static TextStyle caption3 = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColors.textBlackColor);

  static TextStyle normal = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppColors.textBlackColor);

  static TextStyle bold = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColors.textBlackColor);

  static TextStyle button = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: AppColors.textBlackColor);
}
