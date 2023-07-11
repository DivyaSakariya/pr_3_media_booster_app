import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:pr_3_media_booster/utils/audio_utils.dart';

class AudioController extends ChangeNotifier {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  Duration totalDuration = Duration.zero;
  int currentAudioIndex = 0;

  initialAudio({int index = 0}) {
    assetsAudioPlayer
        .open(
      Audio(
        allAudiosList[index]['audio'],
        metas: Metas(
          title: allAudiosList[index]['title'],
          artist: allAudiosList[index]['artist'],
          image: MetasImage(
            path: allAudiosList[index]['image'],
            type: ImageType.network,
          ),
        ),
      ),
      autoStart: false,
      showNotification: true,
    )
        .then((value) {
      totalDuration = assetsAudioPlayer.current.value!.audio.duration;
    });
  }

  changeAudioIndex({required int index}) {
    assetsAudioPlayer.pause();
    initialAudio(index: index);
    currentAudioIndex = index;
    notifyListeners();
  }

  Future<void> play() async {
    await assetsAudioPlayer.play();
    notifyListeners();
  }

  Future<void> pause() async {
    await assetsAudioPlayer.pause();
    notifyListeners();
  }

  Future<void> seek({required int sec}) async {
    await assetsAudioPlayer.seek(Duration(seconds: sec));
  }

  Future<void> seekFB({required int sec}) async {
    await assetsAudioPlayer.seekBy(Duration(seconds: sec));
  }

  Future<void> skipPrevious() async {
    if (currentAudioIndex > 0) {
      await assetsAudioPlayer.previous();
    }
    notifyListeners();
  }

  Future<void> skipNext() async {
    if (currentAudioIndex < allAudiosList.length) {
      await assetsAudioPlayer.next();
    }
    notifyListeners();
  }

  get isPlaying {
    return assetsAudioPlayer.isPlaying.value;
  }

  get currentPosition {
    return assetsAudioPlayer.currentPosition;
  }
}
