import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pr_3_media_booster/controllers/audio_controller.dart';
import 'package:pr_3_media_booster/controllers/carousel_slider_controller.dart';
import 'package:pr_3_media_booster/utils/audio_utils.dart';
import 'package:provider/provider.dart';

class SongHomePage extends StatelessWidget {
  const SongHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Column(
            children: [
              Consumer<CarouselSliderController>(
                builder: (context, cProvider, child) => Column(
                  children: [
                    CarouselSlider(
                      items: List.generate(
                        6,
                        (index) => GestureDetector(
                          onTap: () {
                            Provider.of<AudioController>(context, listen: false)
                                .changeAudioIndex(
                                    index: index, audioStart: true);
                            Navigator.of(context).pushNamed('song_detail_page');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              image: DecorationImage(
                                image:
                                    NetworkImage(allAudiosList[index]['image']),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.easeOut,
                        onPageChanged: (index, reason) {
                          cProvider.onPageChange(index: index);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                        (index) => Container(
                          margin: const EdgeInsets.all(2),
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cProvider.currentIndex == index
                                ? Colors.green
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Song List",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: allAudiosList.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          onTap: () {
                            Provider.of<AudioController>(context, listen: false)
                                .changeAudioIndex(
                                    index: index, audioStart: true);
                            Navigator.of(context).pushNamed('song_detail_page');
                          },
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image:
                                    NetworkImage(allAudiosList[index]['image']),
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
                                return IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.play_arrow),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
