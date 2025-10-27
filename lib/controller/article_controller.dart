// controller/article_controller.dart

import 'package:get/get.dart';
import 'package:techblog/component/api_constant.dart';
import 'package:techblog/models/article_model.dart';
import 'package:techblog/services/dio_service.dart';

class ListArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getList();
  }

  getList() async {
    loading.value = true;

    var response = await DioService().getMethod(ApiConstant.getArticleList);

    if (response.statusCode == 200) {
      // اینجا درستش کن!
      for (var element in response.data) {
        articleList.add(ArticleModel.fromJson(element));
      }
    }

    loading.value = false;
  }
}