import 'package:flutter/material.dart';
import 'package:pr_3_media_booster/controllers/audio_controller.dart';
import 'package:pr_3_media_booster/controllers/video_controller.dart';
import 'package:pr_3_media_booster/views/screens/audio_player/song_detail_page.dart';
import 'package:pr_3_media_booster/views/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AudioController(),
        ),
        ChangeNotifierProvider(
          create: (context) => VideoController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => const HomePage(),
        'song_detail_page': (context) => const SongDetailPage(),
      },
    );
  }
}
