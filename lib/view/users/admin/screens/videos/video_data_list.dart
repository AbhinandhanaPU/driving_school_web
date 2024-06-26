import 'package:flutter/material.dart';
import 'package:new_project_driving/colors/colors.dart';

class VideoThumbnail extends StatelessWidget {
  // final Video video;

  const VideoThumbnail({
    super.key,
    // required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => VideoPlayerScreen(video: video,),
          //   ),
          // );
        },
        child: GridTile(
          footer: const SizedBox(
            height: 80,
            child: GridTileBar(
              backgroundColor: cBlue,
              title: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                    "tisjhdbgak hibglhfliuh hfuhda euifah faefh fhohfeoaih ;oihoaufhf uh auhfusf ashjkdfhjk bsvd tle"),
              ),
              subtitle: Text(
                  "sub uashfuha ahf uofoeuwah hafs hohsfo ieowih oihfeoih oifih ohoweh oiwhfoi oiwehf fh auhfuo aofhw title"),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.network(
              "webassets/images/achievements1.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  // final Video video;

  const VideoPlayerScreen({
    super.key,
    // required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("video.title"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Video URL: {video.videoUrl}'),
            // Use a webview or video player widget to play the video
          ],
        ),
      ),
    );
  }
}
