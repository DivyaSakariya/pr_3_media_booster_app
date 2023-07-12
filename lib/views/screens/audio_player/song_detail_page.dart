import 'package:flutter/material.dart';
import 'package:pr_3_media_booster/controllers/audio_controller.dart';
import 'package:pr_3_media_booster/utils/audio_utils.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SongDetailPage extends StatefulWidget {
  const SongDetailPage({super.key});

  @override
  State<SongDetailPage> createState() => _SongDetailPageState();
}

class _SongDetailPageState extends State<SongDetailPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioController>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
              "${allAudiosList[provider.currentAudioIndex]['title']} Playing"),
          backgroundColor: Colors.transparent,
          actions: [
            Consumer<AudioController>(
              builder: (context, provider, child) => IconButton(
                onPressed: () async {
                  await Share.share(
                    "${allAudiosList[provider.currentAudioIndex]['audio']}\n${allAudiosList[provider.currentAudioIndex]['title']}\n${allAudiosList[provider.currentAudioIndex]['artist']}",
                  );
                },
                icon: const Icon(Icons.share),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Image.network(
              allAudiosList[provider.currentAudioIndex]['image'],
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.8),
              child: StreamBuilder(
                  stream: provider.assetsAudioPlayer.currentPosition,
                  builder: (context, AsyncSnapshot<Duration> snapshot) {
                    if (snapshot.hasData) {
                      double currentPosition =
                          snapshot.data!.inSeconds.toDouble();

                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Container(
                                height: 250,
                                width: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    image: NetworkImage(allAudiosList[
                                        provider.currentAudioIndex]['image']),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                allAudiosList[provider.currentAudioIndex]
                                    ['title'],
                                style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                allAudiosList[provider.currentAudioIndex]
                                    ['artist'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 12,
                                child: Slider(
                                  min: 0,
                                  max: provider.totalDuration.inSeconds
                                      .toDouble(),
                                  value: currentPosition,
                                  onChanged: (value) {
                                    provider.seek(sec: value.toInt());
                                  },
                                  thumbColor: provider.isPlaying
                                      ? Colors.transparent
                                      : Colors.green,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${snapshot.data!.inMinutes.toString().padLeft(2, '0')}:${(snapshot.data!.inSeconds % 60).toString().padLeft(2, '0')}"),
                                  Text(
                                      "${provider.totalDuration.inMinutes.toString().padLeft(2, '0')}:${(provider.totalDuration.inSeconds % 60).toString().padLeft(2, '0')}")
                                ],
                              ),
                              Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        provider.seekFB(sec: -10);
                                      },
                                      icon: const Icon(
                                        Icons.replay_10,
                                        size: 36,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        provider.changeAudioIndex(
                                            index:
                                                provider.currentAudioIndex - 1,
                                            audioStart: true);
                                        provider.skipPrevious();
                                      },
                                      icon: const Icon(
                                        Icons.skip_previous,
                                        size: 36,
                                      ),
                                    ),
                                    StreamBuilder(
                                        stream: provider
                                            .assetsAudioPlayer.isPlaying,
                                        builder: (context,
                                            AsyncSnapshot<bool> snapShot) {
                                          if (snapShot.hasData) {
                                            snapShot.data!
                                                ? animationController.forward()
                                                : animationController.reverse();
                                          }

                                          return IconButton(
                                            onPressed: () {
                                              if (snapShot.data!) {
                                                provider.pause();
                                                animationController.reverse();
                                              } else {
                                                provider.play();
                                                animationController.forward();
                                              }
                                            },
                                            icon: AnimatedIcon(
                                              icon: AnimatedIcons.play_pause,
                                              progress: animationController,
                                              size: 36,
                                            ),
                                          );
                                        }),
                                    IconButton(
                                      onPressed: () {
                                        provider.changeAudioIndex(
                                            index:
                                                provider.currentAudioIndex + 1,
                                            audioStart: true);
                                        provider.skipNext();
                                      },
                                      icon: const Icon(
                                        Icons.skip_next,
                                        size: 36,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        provider.seekFB(sec: 10);
                                      },
                                      icon: const Icon(
                                        Icons.forward_10,
                                        size: 36,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      );
    });
  }
}
