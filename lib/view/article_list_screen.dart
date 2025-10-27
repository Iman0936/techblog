import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/controller/article_controller.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key});

  final ListArticleController listArticleController = Get.put(
    ListArticleController(),
  );

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: appBar('مقالات جدید'),
        body: SizedBox(
          child: Obx(
            () => ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: listArticleController.articleList.length,
              itemBuilder: (context, index) {
                // کش کردن مقاله
                final article = listArticleController.articleList[index];
          
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // تصویر
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width / 3,
                        child: CachedNetworkImage(
                          imageUrl: article.image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => const loading(),
                          errorWidget: (context, url, error) => const Icon(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(article.author, style: textTheme.bodySmall),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
