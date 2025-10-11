import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:techblog/component/my_colors.dart';
import 'package:techblog/view/main_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa', ''), // English
      ],
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 2)
          ),
          filled: true,
          fillColor: Colors.white
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
      ),
      // home: SplashScreen(),
      home: MainScreen(),
    );
  }
}
