import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoController extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  List<Map<String, String>> allVideos = [
    {
      'url': 'assets/video/mrBean.mp4',
      'title': 'Mr. Bean',
    },
    {
      'url': 'assets/video/mashaBear.mp4',
      'title': 'Masha And Bear',
    },
  ];

  VideoController() {
    initialVideo();
  }

  initialVideo({int index = 0}) {
    videoPlayerController = VideoPlayerController.asset(
      allVideos[index]['url']!,
    )..initialize().then((value) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: videoPlayerController.value.aspectRatio,
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

  play() async {
    await videoPlayerController.play();
    notifyListeners();
  }

  pause() async {
    await videoPlayerController.pause();
    notifyListeners();
  }
}
