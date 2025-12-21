import 'package:dio/dio.dart' as dio;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog/component/constant/api_constant.dart';
import 'package:techblog/component/constant/commands.dart';
import 'package:techblog/component/constant/storage_const.dart';
import 'package:techblog/controller/file_controller.dart';
import 'package:techblog/models/article_info_model.dart';
import 'package:techblog/models/article_model.dart';
import 'package:techblog/models/tags_model.dart';
import 'package:techblog/services/dio_service.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  RxList<TagsModel> tagList = RxList.empty();
  RxBool Loading = false.obs;
  TextEditingController titleTextEditingController = TextEditingController();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
    "اینجا عنوان مقاله قرار میگیره ، یه عنوان جذاب انتخاب کن",
    '''من متن و بدنه اصلی مقاله هستم ، اگه میخوای من رو ویرایش کنی و یه مقاله جذاب بنویسی ، نوشته آبی رنگ بالا که نوشته "ویرایش متن اصلی مقاله" رو با انگشتت لمس کن تا وارد ویرایشگر بشی''',
    "",
  ).obs;
  onInit() {
    super.onInit();
    getManagedArticle();
  }

  getManagedArticle() async {
    Loading.value = true;
    // var response = await DioService().getMethod(
    //   ApiConstant.publishedByMe + GetStorage().read(StorageKey.userId),
    // );
    var response = await DioService().getMethod(
      ApiUrlConstant.publishedByMe + "1",
    );

    if (response.statusCode == 200) {
      // اینجا درستش کن!
      for (var element in response.data) {
        articleList.add(ArticleModel.fromJson(element));
      }
      // articleList.clear();
      Loading.value = false;
    }
  }

  updateTitle() {
    articleInfoModel.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }

  storeArticle() async {
    var fileController = Get.find<FilePickerController>();
    Loading.value = true;
    Map<String, dynamic> map = {
      ApiArticleKeyConstant.title: articleInfoModel.value.title,
      ApiArticleKeyConstant.content: articleInfoModel.value.content,
      ApiArticleKeyConstant.catId: articleInfoModel.value.catId,
      ApiArticleKeyConstant.userId: GetStorage().read(StorageKey.userId),
      ApiArticleKeyConstant.image: await dio.MultipartFile.fromFile(
        fileController.file.value.path!,
      ),
      ApiArticleKeyConstant.command: Commands.store,
      ApiArticleKeyConstant.tagList: "[]",
    };
    var response = await DioService().postMethod(
      map,
      ApiUrlConstant.articlePost,
    );
    debugPrint(response.data.toString());
    Loading.value = false;
  }
}
