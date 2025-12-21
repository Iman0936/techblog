import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:techblog/component/constant/my_colors.dart';
import 'package:techblog/component/dimens.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/controller/article/list_article_controller.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';
import 'package:techblog/controller/file_controller.dart';
import 'package:techblog/controller/home_screen_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/services/pick_file.dart';
import 'package:techblog/view/articles/article_content_editor.dart';
import 'package:techblog/view/articles/article_list_screen.dart';
import 'package:techblog/view/main_screen/home_screen.dart';

// ignore: must_be_immutable
class SingleManageArticle extends StatelessWidget {
  var manageArticleController = Get.find<ManageArticleController>();
  FilePickerController filePickerController = Get.put(FilePickerController());

  getTitle() {
    Get.defaultDialog(
      title: "عنوان مقاله",
      titleStyle: TextStyle(color: SolidColors.scafoldBg),
      content: TextField(
        controller: manageArticleController.titleTextEditingController,
        keyboardType: TextInputType.text,
        style: TextStyle(color: SolidColors.colorTitle),
        decoration: InputDecoration(hintText: "اینجا بنویس"),
      ),
      backgroundColor: SolidColors.primaryColor,
      radius: 8,
      confirm: ElevatedButton(
        onPressed: () {
          manageArticleController.updateTitle();
          Get.back();
        },
        child: Text("ثبت", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  SingleManageArticle({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height / 3,
                      child: filePickerController.file.value.name == 'nothing'
                          ? CachedNetworkImage(
                              imageUrl: manageArticleController
                                  .articleInfoModel
                                  .value
                                  .image!,
                              imageBuilder: ((context, imageProvider) =>
                                  Image(image: imageProvider)),
                              placeholder: (context, url) => Loading(),
                              errorWidget: (context, url, error) => Image.asset(
                                Assets.images.singlePlaceHolder.path,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.file(
                              File(filePickerController.file.value.path!),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                            colors: GradiantColors.singleAppbarGradiant,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),

                            const Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            pickFiles();
                          },
                          child: Container(
                            height: 30,
                            width: Get.width / 3,
                            decoration: BoxDecoration(
                              color: SolidColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "انتخاب تصویر",
                                  style: textTheme.displayMedium,
                                ),
                                Icon(Icons.add, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),

                GestureDetector(
                  onTap: () {
                    getTitle();
                  },
                  child: SeeMoreBlog(
                    bodyMargin: Dimens.halfBodyMargin,
                    textTheme: textTheme,
                    title: "ویرایش عنوان مقاله",
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(Dimens.halfBodyMargin),
                  child: Text(
                    manageArticleController.articleInfoModel.value.title!,
                    maxLines: 2,
                    style: textTheme.titleLarge,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => ArticleContentEditor()),
                  child: SeeMoreBlog(
                    bodyMargin: Dimens.halfBodyMargin,
                    textTheme: textTheme,
                    title: "ویرایش متن اصلی مقاله",
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: HtmlWidget(
                    manageArticleController.articleInfoModel.value.content!,
                    textStyle: textTheme.bodySmall,
                    enableCaching: true,
                    onLoadingBuilder: ((context, element, loadingProgress) =>
                        Loading()),
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    chooseCatBottomSheet(textTheme);
                  },
                  child: SeeMoreBlog(
                    bodyMargin: Dimens.halfBodyMargin,
                    textTheme: textTheme,
                    title: "انتخاب دسته بندی ",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimens.halfBodyMargin),
                  child: Text(
                    manageArticleController.articleInfoModel.value.catName ==
                            null
                        ? "هیچ دسته بندی انتخاب نشده"
                        : manageArticleController
                              .articleInfoModel
                              .value
                              .catName!,
                    maxLines: 2,
                    style: textTheme.titleLarge,
                  ),
                ),

                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: () async =>
                      await manageArticleController.storeArticle(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      manageArticleController.Loading.value
                          ? "صبر کنید ..."
                          : "ارسال مطلب",
                    ),
                  ),
                ),
                // tags(textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cats(textTheme) {
    var homeScreenController = Get.find<HomeScreenController>();
    return SizedBox(
      height: Get.height / 1.7,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: homeScreenController.tagsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              manageArticleController.articleInfoModel.update((val) {
                val?.catId = homeScreenController.tagsList[index].id!;
                val?.catName = homeScreenController.tagsList[index].title!;
              });
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  color: SolidColors.primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Center(
                    child: Text(
                      homeScreenController.tagsList[index].title!,
                      style: textTheme.displayMedium,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }

  chooseCatBottomSheet(TextTheme textTheme) {
    Get.bottomSheet(
      Container(
        height: Get.height / 1.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("انتخاب دسته بندی"),
              SizedBox(height: 8),
              cats(textTheme),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      persistent: true,
    );
  }
}
