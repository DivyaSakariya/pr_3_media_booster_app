import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../utils/video_list.dart';

class VideoController extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  late VideoPlayerController videoPlayerController1;
  late VideoPlayerController videoPlayerController2;
  late ChewieController chewieController;
  late ChewieController chewieController1;
  late ChewieController chewieController2;

  VideoController() {
    initialVideo();
  }

  initialVideo({int index = 0}) {
    videoPlayerController = VideoPlayerController.asset(
      allVideos[index]['video']!,
    )..initialize().then((value) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: videoPlayerController.value.aspectRatio,
          autoPlay: true,
        );
        notifyListeners();
      });
    videoPlayerController1 = VideoPlayerController.asset(
      allVideos[0]['video']!,
    )..initialize().then((value) {
        chewieController1 = ChewieController(
          videoPlayerController: videoPlayerController1,
          aspectRatio: videoPlayerController1.value.aspectRatio,
          autoPlay: true,
        );
        notifyListeners();
      });
    videoPlayerController2 = VideoPlayerController.asset(
      allVideos[1]['video']!,
    )..initialize().then((value) {
        chewieController2 = ChewieController(
          videoPlayerController: videoPlayerController2,
          aspectRatio: videoPlayerController2.value.aspectRatio,
          autoPlay: true,
        );
        notifyListeners();
      });
  }

  changeCurrentIndex({required int currentIndex}) {
    videoPlayerController.pause();
    chewieController.pause();
    initialVideo(index: currentIndex);
  }
}
