import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:techblog/component/constant/my_colors.dart';
import 'package:techblog/component/decorations.dart';
import 'package:techblog/component/dimens.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/controller/podcast/single_podcast_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/models/podcast_model.dart';

// ignore: must_be_immutable
class SinglePodcast extends StatelessWidget {
  late SinglePodcastController controller;
  late PodcastModel podcastModel;
  SinglePodcast() {
    podcastModel = Get.arguments;
    controller = Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    print(controller.id);
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: Get.height / 3,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: podcastModel.poster!,
                            imageBuilder: ((context, imageProvider) =>
                                Image(image: imageProvider, fit: BoxFit.fill)),
                            placeholder: (context, url) => Loading(),
                            errorWidget: (context, url, error) => Image.asset(
                              Assets.images.singlePlaceHolder.path,
                            ),
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
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          podcastModel.title!,
                          maxLines: 2,
                          style: textTheme.titleLarge,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image(
                            image: Image.asset(Assets.images.avatar.path).image,
                            height: 50,
                          ),
                          SizedBox(width: 16),
                          Text(
                            podcastModel.publisher!,
                            style: textTheme.headlineMedium,
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.podcastFileList.length,
                          // itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ImageIcon(
                                        Image.asset(
                                          Assets.icons.bluemicrophon.path,
                                        ).image,
                                        color: SolidColors.seeMore,
                                      ),
                                      SizedBox(width: 8),
                                      SizedBox(
                                        width: Get.width / 1.5,
                                        child: Text(
                                          controller
                                              .podcastFileList[index]
                                              .title!,
                                          // "عنوان پادکست",
                                          style: textTheme.headlineMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    controller.podcastFileList[index].length!,
                                  ),
                                  // Text("22:00"),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 8,
              right: Dimens.bodyMargin,
              left: Dimens.bodyMargin,
              child: Container(
                height: Get.height / 7,
                decoration: MyDecorations.mainGradiant,

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LinearPercentIndicator(
                        percent: 1.0,
                        backgroundColor: Colors.white,
                        progressColor: Colors.orange,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.skip_next, color: Colors.white),
                          GestureDetector(
                            onTap: () {
                              controller.togglePlayPause(); // همین یک خط کافیه!
                            },
                            child: Obx(
                              () => Icon(
                                controller.playState.value
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                color: Colors.white,
                                size: 48,
                              ),
                            ),
                          ),
                          Icon(Icons.skip_previous, color: Colors.white),
                          SizedBox(),
                          Icon(Icons.repeat, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
