import 'package:flutter/material.dart';
import 'package:pr_3_media_booster/controllers/audio_controller.dart';
import 'package:pr_3_media_booster/utils/audio_utils.dart';
import 'package:provider/provider.dart';

class SongHomePage extends StatefulWidget {
  const SongHomePage({super.key});

  @override
  State<SongHomePage> createState() => _SongHomePageState();
}

class _SongHomePageState extends State<SongHomePage>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Song List",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 700,
                child: ListView.builder(
                  itemCount: allAudiosList.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: () {
                        Provider.of<AudioController>(context, listen: false)
                            .changeAudioIndex(index: index);
                        Navigator.of(context).pushNamed(
                          'song_detail_page',
                          arguments: index,
                        );
                      },
                      leading: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: NetworkImage(allAudiosList[index]['image']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: Text(
                        "${allAudiosList[index]['title']}",
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      subtitle: Text(
                        "${allAudiosList[index]['artist']}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      trailing: Consumer<AudioController>(
                          builder: (context, provider, _) {
                        return StreamBuilder(
                            stream: provider.assetsAudioPlayer.isPlaying,
                            builder: (context, AsyncSnapshot<bool> snapShot) {
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
                                ),
                              );
                            });
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
