import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:techblog/component/constant/api_constant.dart';
import 'package:techblog/models/article_info_model.dart';
import 'package:techblog/models/article_model.dart';
import 'package:techblog/models/tags_model.dart';
import 'package:techblog/services/dio_service.dart';
import 'package:techblog/view/articles/single.dart';

class SingleArticleController extends GetxController {
  RxBool loading = false.obs;
  RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
    null,
    null,
    null,
  ).obs;
  RxList<TagsModel> tagList = RxList();
  RxList<ArticleModel> relatedList = RxList();

  getArticleInfo(var id) async {
    articleInfoModel = ArticleInfoModel(null, null, null).obs;
    loading.value = true;
    var userId = '';
    debugPrint(
      '${ApiUrlConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId',
    );
    // ignore: todo
    //TODO user id is hard code

    var response = await DioService().getMethod(
      '${ApiUrlConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId',
    );

    if (response.statusCode == 200) {
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);
      loading.value = false;
    }

    tagList.clear();
    response.data['tags'].forEach((element) {
      tagList.add(TagsModel.fromJson(element));
    });

    relatedList.clear();
    response.data['related'].forEach((element) {
      relatedList.add(ArticleModel.fromJson(element));
    });
    Get.to(Single());
  }
}
