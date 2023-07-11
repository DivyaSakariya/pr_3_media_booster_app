import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pr_3_media_booster/controllers/video_controller.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoController>(
      builder: (context, provider, child) => Center(
        child: provider.videoPlayerController.value.isInitialized
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio:
                        provider.videoPlayerController.value.aspectRatio,
                    child: Chewie(
                      controller: provider.chewieController,
                    ),
                  ),
                  SizedBox(
                    height: 450,
                    child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          provider.changeCurrentIndex(currentIndex: index);
                        },
                        title: Text(provider.allVideos[index]['title']!),
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: provider.allVideos.length,
                    ),
                  )
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
