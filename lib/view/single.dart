import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:techblog/component/my_colors.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/controller/list_article_controller.dart';
import 'package:techblog/controller/single_article_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/view/article_list_screen.dart';

// ignore: must_be_immutable
class Single extends StatelessWidget {
  SingleArticleController singleArticleController = Get.put(
    SingleArticleController(),
  );

  Single({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => singleArticleController.articleInfoModel.value.title == null
                ? SizedBox(height: Get.height, child: Loading())
                : Column(
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: singleArticleController
                                .articleInfoModel
                                .value
                                .image!,
                            imageBuilder: ((context, imageProvider) =>
                                Image(image: imageProvider)),
                            placeholder: (context, url) => Loading(),
                            errorWidget: (context, url, error) => Image.asset(
                              Assets.images.singlePlaceHolder.path,
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
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),

                                  const Expanded(child: SizedBox()),
                                  Icon(
                                    Icons.bookmark_border_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),

                                  SizedBox(width: 20),
                                  Icon(
                                    Icons.share,
                                    size: 24,
                                    color: Colors.white,
                                  ),

                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          singleArticleController.articleInfoModel.value.title!,
                          maxLines: 2,
                          style: textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image(
                              image: Image.asset(
                                Assets.images.avatar.path,
                              ).image,
                              height: 50,
                            ),
                            SizedBox(width: 16),
                            Text(
                              singleArticleController
                                      .articleInfoModel
                                      .value
                                      .author ??
                                  'نامشخص',
                              style: textTheme.headlineMedium,
                            ),
                            SizedBox(width: 16),
                            Text(
                              singleArticleController
                                  .articleInfoModel
                                  .value
                                  .createdAt!,
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: HtmlWidget(
                          singleArticleController
                              .articleInfoModel
                              .value
                              .content!,
                          textStyle: textTheme.bodySmall,
                          enableCaching: true,
                          onLoadingBuilder:
                              ((context, element, loadingProgress) =>
                                  Loading()),
                        ),
                      ),
                      const SizedBox(height: 25),
                      tags(textTheme),
                      const SizedBox(height: 25),
                      similar(textTheme),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget tags(textTheme) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: singleArticleController.tagList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              var tagId = singleArticleController.tagList[index].id!;
              await Get.find<ListArticleController>().getArticleListWithTagsId(
                tagId,
              );
              String tagName = singleArticleController.tagList[index].title!;
              Get.to(ArticleListScreen(title: tagName));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  color: Colors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Text(
                    singleArticleController.tagList[index].title!,
                    style: textTheme.displayMedium,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget similar(textTheme) {
    return SizedBox(
      height: Get.height / 3.5,
      child: ListView.builder(
        itemCount: singleArticleController.relatedList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          //blog item
          return GestureDetector(
            onTap: (() {
              singleArticleController.getArticleInfo(
                singleArticleController.relatedList[index].id,
              );
            }),
            child: Padding(
              padding: EdgeInsets.only(right: index == 0 ? Get.width / 15 : 15),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: Get.height / 5.3,
                      width: Get.width / 2.4,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: singleArticleController
                                .relatedList[index]
                                .image,
                            imageBuilder: ((context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  foregroundDecoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: GradiantColors.blogPost,
                                    ),
                                  ),
                                )),
                            placeholder: ((context, url) => Loading()),
                            errorWidget: ((context, url, error) => Icon(
                              Icons.image_not_supported_outlined,
                              size: 64.0,
                              color: SolidColors.greyColor,
                            )),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  singleArticleController
                                      .relatedList[index]
                                      .author,
                                  style: textTheme.titleMedium,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      singleArticleController
                                          .relatedList[index]
                                          .view,
                                      style: textTheme.titleMedium,
                                    ),
                                    SizedBox(width: 8.0),
                                    Icon(
                                      Icons.remove_red_eye_sharp,
                                      color: SolidColors.lightIcon,
                                      size: 16.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 2.4,
                    child: Text(
                      singleArticleController.relatedList[index].title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
