import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';
import 'package:techblog/controller/article/single_article_controller.dart';
import 'package:techblog/controller/register_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/component/constant/my_string.dart';
import 'package:techblog/main.dart';

// ignore: must_be_immutable
class ManageArticle extends StatelessWidget {
  ManageArticle({super.key});

  var articleManageController = Get.find<ManageArticleController>();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: appBar("مدیریت مقاله ها"),
        body: Obx(
          () => articleManageController.Loading.value
              ? Loading()
              : articleManageController.articleList.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  // padding: const EdgeInsets.all(8),
                  itemCount: articleManageController.articleList.length,
                  itemBuilder: (context, index) {
                    // کش کردن مقاله
                    final article = articleManageController.articleList[index];

                    return GestureDetector(
                      onTap: () async {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // تصویر
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 3,
                              child: CachedNetworkImage(
                                imageUrl: article.image,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                placeholder: (context, url) => const Loading(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // متن‌ها
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    article.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleMedium!.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      article.author,
                                      style: textTheme.bodySmall,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      '${article.view} بازدید',
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : articleEmptyState(textTheme),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(Get.width/3, 56))
                ),
                onPressed: () {
                  Get.toNamed(NamedRoute.singleManageArticle);
                },
                  
                child: Text(
                  "بریم برای نوشتن یه مقاله باحال",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
      ),
    );
  }

  Widget articleEmptyState(TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.images.techbotEmpty.path, height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: MyString.articleEmpty,
                style: textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
