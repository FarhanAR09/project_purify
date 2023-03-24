import 'package:flutter/material.dart';

import 'package:project_purify/providers/child_profile.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget{
  const VideoScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return VideoScreenState();
  }
}

class VideoScreenState extends State<VideoScreen>{

  YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: 'g3jCAyPai2Y',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            YoutubePlayer(
              controller: controller,
            ),
            ElevatedButton(
              child: const Text(
                  "back"
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}