import 'package:app_apk/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_api/youtube_api.dart';

import '../../main.dart';
import 'ytVideoPlayer.dart';

class videoGuide extends StatefulWidget {
  late String pageGuideName;
  videoGuide(this.pageGuideName, {super.key});

  @override
  State<videoGuide> createState() => _videoGuideState(pageGuideName);
}

class _videoGuideState extends State<videoGuide> {
  late String pageGuideName;
  YoutubeAPI youtube = YoutubeAPI(API_KEY);
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    String query = "tennis " + pageGuideName;
    videoResult = await youtube.search(
      query,
      order: 'relevance',
      videoDuration: 'any',
    );
    videoResult = await youtube.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  _videoGuideState(this.pageGuideName);

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(pageGuideName,
              style: GoogleFonts.exo2(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
        body: ListView(
          children: videoResult.map<Widget>(listItem).toList(),
        ),
      ),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideoScreen(video.id!))),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.network(
                video.thumbnail.small.url ?? '',
                width: 120.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    video.title,
                    softWrap: true,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      video.channelTitle,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    video.url,
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
