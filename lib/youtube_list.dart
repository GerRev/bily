import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  var videoIds = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video List"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => YoutubePlayer(
          context: context,
          videoId: videoIds[index],
          autoPlay: false,
          showVideoProgressIndicator: true,
        ),
        separatorBuilder: (_, i) => SizedBox(
          height: 10.0,
        ),
        itemCount: videoIds.length,
      ),
    );
  }
}