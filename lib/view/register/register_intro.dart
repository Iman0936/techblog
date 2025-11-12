import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techblog/controller/register_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/component/my_string.dart';
import 'package:validators/validators.dart';

// ignore: must_be_immutable
class RegisterIntro extends StatelessWidget {
  RegisterIntro({super.key});

  RegisterController registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.images.techbot.path, height: 100),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: MyString.welcom,
                    style: textTheme.headlineMedium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ElevatedButton(
                  onPressed: () {
                    _showEmailBottomSheet(context, size, textTheme);
                  },

                  child: Text(
                    "بزن بریم",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showEmailBottomSheet(
    BuildContext context,
    Size size,
    TextTheme textTheme,
  ) {
    // RegExp isEmail=RegExp('^[a-z-0-9]+@');

    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: size.height / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    MyString.insertYourEmail,
                    style: textTheme.headlineMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextField(
                      controller: registerController.emailTextEditingController,
                      onChanged: (value) {
                        // ignore: avoid_print
                        print("$value is Email: ${isEmail(value)}");
                      },
                      style: textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "techblog@gmail.com",
                        hintStyle: textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      registerController.register();
                      Navigator.pop(context);
                      _activateCodeBottomSheet(context, size, textTheme);
                    },
                    child: Text("ادامه", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _activateCodeBottomSheet(
    BuildContext context,
    Size size,
    TextTheme textTheme,
  ) {
    // RegExp isEmail=RegExp('^[a-z-0-9]+@');

    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: size.height / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    MyString.activateCode,
                    style: textTheme.headlineMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextField(
                      controller: registerController.activeCodeTextEditingController,

                      onChanged: (value) {
                        // ignore: avoid_print
                        print("$value is Email: ${isEmail(value)}");
                      },
                      style: textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "******",
                        hintStyle: textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      registerController.verify();
                    },
                    child: Text(
                      "ادامه",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
