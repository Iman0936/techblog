import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/view/main_screen.dart';
import 'package:techblog/component/my_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(
        // ignore: use_build_context_synchronously
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.logo.image(height: 64),
              SizedBox(height: 32),
              SpinKitFadingCube(color: SolidColors.primaryColor, size: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
