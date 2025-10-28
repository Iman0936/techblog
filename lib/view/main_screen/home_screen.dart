import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:techblog/controller/home_screen_controller.dart';
import 'package:techblog/controller/list_article_controller.dart';
import 'package:techblog/controller/single_article_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/models/fake_data.dart';
import 'package:techblog/component/my_colors.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/component/my_string.dart';
import 'package:techblog/view/article_list_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  SingleArticleController singleArticleController = Get.put(
    SingleArticleController(),
  );
  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: homeScreenController.loading.value == false
              ? Column(
                  children: [
                    poster(),
                    const SizedBox(height: 16),

                    tags(),
                    const SizedBox(height: 32),

                    GestureDetector(
                      onTap: () => Get.to(ArticleListScreen(title: 'مقالات جدید')),
                      child: SeeMoreBlog(bodyMargin: bodyMargin, textTheme: textTheme)),

                    topVisited(),

                    const SizedBox(height: 32),

                    SeeHottestPodcast(
                      bodyMargin: bodyMargin,
                      textTheme: textTheme,
                    ),

                    //podcast list
                    topPodcasts(),
                    const SizedBox(height: 60),
                  ],
                )
              : const Center(child: loading()),
        ),
      ),
    );
  }

  Widget topVisited() {
    return SizedBox(
      height: size.height / 3.5,
      child: Obx(
        () => ListView.builder(
          itemCount: homeScreenController.topVisitedList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //blog item
            return GestureDetector(
              onTap: () {
                singleArticleController.getArticleInfo(
                  homeScreenController.topVisitedList[index].id,
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: size.height / 5.3,
                        width: size.width / 2.4,
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: homeScreenController
                                  .topVisitedList[index]
                                  .image!,
                              imageBuilder: ((context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                              placeholder: (context, url) => loading(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    homeScreenController
                                        .topVisitedList[index]
                                        .author!,
                                    style: textTheme.titleMedium,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        homeScreenController
                                            .topVisitedList[index]
                                            .view!,
                                        style: textTheme.titleMedium,
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.remove_red_eye_sharp,
                                        color: Colors.white,
                                        size: 16,
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
                      width: size.width / 2.4,
                      child: Text(
                        homeScreenController.topVisitedList[index].title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget topPodcasts() {
    return SizedBox(
      height: size.height / 3.5,
      child: Obx(
        () => ListView.builder(
          itemCount: homeScreenController.topPodcasts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //blog item
            return Padding(
              padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: size.height / 5.3,
                      width: size.width / 2.4,
                      child: CachedNetworkImage(
                        imageUrl:
                            homeScreenController.topPodcasts[index].poster!,
                        imageBuilder: ((context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                        placeholder: (context, url) => loading(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 2.4,
                    child: Text(
                      homeScreenController.topPodcasts[index].title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget poster() {
    return Stack(
      children: [
        Container(
          width: size.width / 1.25,
          height: size.height / 4.2,
          foregroundDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
              colors: GradiantColors.homePosterCoverGradiant,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: homeScreenController.poster.value.image!,
            imageBuilder: ((context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            )),
            placeholder: (context, url) =>
                SpinKitFadingCube(color: SolidColors.primaryColor, size: 32),
            errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_outlined,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                homeScreenController.poster.value.title!,
                style: textTheme.displayLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tags() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tagList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 8, index == 0 ? bodyMargin : 15, 8),
            child: MainTags(textTheme: textTheme, index: index),
          );
        },
      ),
    );
  }
}

class SeeHottestPodcast extends StatelessWidget {
  const SeeHottestPodcast({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: 8),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.bluemicrophon.provider(),
            color: SolidColors.seeMore,
          ),
          SizedBox(width: 8),
          Text(MyString.viewHotestPodcasts, style: textTheme.displaySmall),
        ],
      ),
    );
  }
}

class SeeMoreBlog extends StatelessWidget {
  const SeeMoreBlog({
    super.key,
    required this.bodyMargin,
    required this.textTheme,
  });

  final double bodyMargin;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: 8),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.bluepen.provider(),
            color: SolidColors.seeMore,
          ),
          SizedBox(width: 8),
          Text(MyString.viewHotestBlog, style: textTheme.displaySmall),
        ],
      ),
    );
  }
}
