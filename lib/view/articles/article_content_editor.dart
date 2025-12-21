import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';
import 'package:techblog/view/articles/manage_article.dart';

class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({super.key});

  final HtmlEditorController controller = HtmlEditorController();
  var manageArtileController = Get.put(ManageArticleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.clearFocus(),
      child: Scaffold(
        appBar: appBar("نوشتن/ویرایش مقاله"),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HtmlEditor(controller: controller,
              htmlEditorOptions: HtmlEditorOptions(
                hint: "میتونی مقالتو اینجا بنویسی...",
                shouldEnsureVisible: true,
                initialText: manageArtileController.articleInfoModel.value.content!
              ),
              callbacks: Callbacks(
                onChangeContent: (p0) {
                  manageArtileController.articleInfoModel.update((val) {
                    val?.content=p0;
                  },);
                  log(manageArtileController.articleInfoModel.value.content.toString());
                },
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
