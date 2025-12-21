import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:techblog/binding.dart';
import 'package:techblog/component/constant/my_colors.dart';
import 'package:techblog/my_http_overrides.dart';
import 'package:techblog/view/articles/manage_article.dart';
import 'package:techblog/view/articles/single_manage_article.dart';
import 'package:techblog/view/main_screen/main_screen.dart';
import 'package:techblog/view/articles/single.dart';
import 'package:techblog/view/podcast/single_podcast.dart';
import 'package:techblog/view/splash_screen.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa'),
      theme: lightTheme(textTheme),
      getPages: [
        GetPage(
          name: NamedRoute.routeMainScreen,
          page: () => MainScreen(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: NamedRoute.routeSingleArticle,
          page: () => Single(),
          binding: ArticleBinding(),
        ),
        GetPage(
          name: NamedRoute.manageArticle,
          page: () => ManageArticle(),
          binding: ArticleManagerBinding(),
        ),
        GetPage(
          name: NamedRoute.singleManageArticle,
          page: () => SingleManageArticle(),
          binding: ArticleManagerBinding(),
        ),
        GetPage(
          name: NamedRoute.singlePodcast,
          page: () => SinglePodcast(),
        ),
      ],
      home: SplashScreen(),

    );
  }

  ThemeData lightTheme(TextTheme textTheme) {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return textTheme.displayLarge;
            }
            return textTheme.titleMedium;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return SolidColors.seeMore;
            }
            return SolidColors.primaryColor;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          ),
        ),
      ),
      fontFamily: 'dana',
      brightness: Brightness.light,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'dana',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: SolidColors.posterTitle,
        ),
        titleMedium: TextStyle(
          fontFamily: 'dana',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: SolidColors.posterSubTitle,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'dana',
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
        displayMedium: TextStyle(
          fontFamily: 'dana',
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
        displaySmall: TextStyle(
          fontFamily: 'dana',
          fontSize: 14,
          color: SolidColors.seeMore,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'dana',
          fontSize: 14,
          color: Color.fromARGB(255, 70, 70, 70),
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'dana',
          fontSize: 14,
          color: SolidColors.hintText,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class NamedRoute{
  NamedRoute._();
  static String routeMainScreen = "/MainScreen";
  static String routeSingleArticle = "/SingleArticle";
  static String manageArticle = "/ManageArticle";
  static String singleManageArticle = "/SingleManageArticle";
  static String singlePodcast = "/singlePodcast";
}
