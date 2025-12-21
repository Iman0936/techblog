import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:convert';
import 'package:techblog/models/podcast_file_model.dart';

class SinglePodcastController extends GetxController {
  var id;
  SinglePodcastController({this.id});

  RxBool loading = false.obs;
  RxList<PodcastFileModel> podcastFileList = RxList();
  final player = AudioPlayer();

  RxBool playState = false.obs;
  RxInt currentIndex = (-1).obs; // -1 یعنی هیچی پخش نمی‌شه

  @override
  void onInit() {
    super.onInit();

    // آپدیت وضعیت پخش
    player.playingStream.listen((playing) {
      playState.value = playing;
    });

    // آپدیت ایندکس فعلی
    player.currentIndexStream.listen((index) {
      currentIndex.value = index ?? -1;
    });

    // لاگ‌های مفید برای دیباگ (در صورت مشکل نگهشون دار)
    player.processingStateStream.listen((state) {
      print("ProcessingState: $state");
    });


    getPodcastFiles();
  }

  getPodcastFiles() async {
    loading.value = true;
    podcastFileList.clear();

    // پاک کردن پلی‌لیست قبلی
    await player.stop();
    await player.clearAudioSources();

    try {
      String jsonString = await rootBundle.loadString('assets/json/podcast_files.json');
      Map<String, dynamic> jsonData = json.decode(jsonString);

      List<AudioSource> sources = [];

      for (var element in jsonData["files"]) {
        if (element["podcast_id"].toString() == id.toString()) {
          var podcastFile = PodcastFileModel.fromJson(element);
          podcastFileList.add(podcastFile);

          // مهم: برای فایل‌های asset باید از asset:/// استفاده کنی
          sources.add(
            AudioSource.uri(
              Uri.parse("asset:///${podcastFile.file!}"),
            ),
          );
        }
      }

      if (sources.isNotEmpty) {
        await player.setAudioSources(
          sources,
          initialIndex: 0,
          initialPosition: Duration.zero,
        );
        print("پلی‌لیست با ${sources.length} ترک لود شد.");
      } else {
        print("هیچ فایلی برای این پادکست پیدا نشد.");
      }
    } catch (e) {
      print("خطا در لود JSON یا assets: $e");
    }

    loading.value = false;
  }

  // پلی/پاز کردن ترک فعلی
  void togglePlayPause() async {
    if (podcastFileList.isEmpty || loading.value) {
      print("هنوز لود نشده یا فایلی وجود نداره!");
      return;
    }

    if (playState.value) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  // پخش یک قسمت خاص (مثلاً وقتی کاربر روی لیست کلیک کرد)
  void playIndex(int index) async {
    if (index < 0 || index >= podcastFileList.length) return;

    await player.seek(Duration.zero, index: index);
    await player.play();
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}