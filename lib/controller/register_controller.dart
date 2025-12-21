import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog/component/constant/api_constant.dart';
import 'package:techblog/component/constant/storage_const.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/main.dart';
import 'package:techblog/services/dio_service.dart';
import 'package:techblog/view/main_screen/main_screen.dart';
import 'package:techblog/view/register/register_intro.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController =
      TextEditingController();
  var email = '';
  var userId = '';

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register',
    };
    var response = await DioService().postMethod(
      map,
      ApiUrlConstant.postRegister,
    );

    email = emailTextEditingController.text;
    userId = response.data['user_id'];
    debugPrint(response);
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeTextEditingController.text,
      'command': 'verify',
    };
    debugPrint(map.toString());
    var response = await DioService().postMethod(
      map,
      ApiUrlConstant.postRegister,
    );
    debugPrint(response.data.toString());
    var status = response.data['response'];

    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write(StorageKey.token, response.data['token']);
        box.write(StorageKey.userId, response.data['user_id']);

        debugPrint("read => ${box.read(StorageKey.token)}");
        debugPrint("read => ${box.read(StorageKey.userId)}");
        Get.offAll(MainScreen());
        break;
      case 'incorrect_code':
        Get.snackbar('خطا', 'کد فعالسازی غلط است');
        break;
      case 'expired':
        Get.snackbar('خطا', 'کد فعالسازی منقضی شده است');
        break;
    }

    if (response.data['response'] == 'verified') {
    } else {
      log("error");
    }
  }

  toggleLogin() {
    if (GetStorage().read(StorageKey.token) == null) {
      Get.to(RegisterIntro());
    } else {
      routeToWriteBottomSheet();
    }
  }

  routeToWriteBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height / 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(Assets.images.techbot.path, height: 40),
                  const SizedBox(width: 8),
                  const Text("دونسته هات رو با بقیه به اشتراک بذار ..."),
                ],
              ),
              const SizedBox(height: 8),
              const Text('''
فکر کن !!  اینجا بودنت به این معناست که یک گیک تکنولوژی هستی
دونسته هات رو با  جامعه‌ی گیک های فارسی زبان به اشتراک بذار..
''', style: TextStyle(fontSize: 13)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      // debugPrint("write article");
                      Get.toNamed(NamedRoute.manageArticle);
                    },
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.icons.writeArticleIcon.path,
                            height: 32,
                          ),
                          const SizedBox(width: 8),
                          const Text("مدیریت مقاله ها"),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint("write podcast");
                    },
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.icons.writePodcastIcon.path,
                            height: 32,
                          ),
                          const SizedBox(width: 8),
                          const Text("مدیریت پادکست ها"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
