import 'package:get/get.dart';
import 'package:techblog/controller/article/list_article_controller.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';
import 'package:techblog/controller/register_controller.dart';
import 'package:techblog/controller/article/single_article_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.put(ListArticleController());

    Get.lazyPut(() => SingleArticleController());
  }
}

class ArticleManagerBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    // Get.put(ManageArticleController());
    Get.lazyPut(() => ManageArticleController());
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.put(RegisterController());
  }
}
