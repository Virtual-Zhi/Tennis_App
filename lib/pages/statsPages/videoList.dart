import 'package:app_apk/pages/statsPages/playVideo.dart';
import 'package:app_apk/pages/statsPages/playerClipsPage.dart';
import 'package:app_apk/utils/math.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';

class videoList extends StatefulWidget {
  late String name, id, teamId;

  videoList(String name, this.id, this.teamId, {Key? key}) : super(key: key) {
    this.name = name;
  }

  @override
  State<videoList> createState() => _videoListState();
}

class _videoListState extends State<videoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name+"'s Clip List"),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              playerclipsPage(widget.name, widget.id, widget.teamId)));
                },
                icon: Icon(Icons.history))
          ],
          leading: IconButton(
              onPressed: () {
                _deleteCacheDir();
                Navigator.pop(context);
              },
              icon: const Icon(
                LineAwesomeIcons.angle_left,
                color: Colors.black,
              )),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(getfireBaseUser())
                      .doc(widget.teamId)
                      .collection("players")
                      .doc(widget.id)
                      .collection("videos")
                      .snapshots(),
                  builder: ((context, snapshot) {
                    List<Row> videoWidgets = [];
                    if (!snapshot.hasData) {
                      const CircularProgressIndicator();
                    } else {
                      final videos = snapshot.data?.docs.toList();
                      for (var video in videos!) {
                        final videoWidget = Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return playVideo(videoURL: video['url'], videoName: video['name'].toString(),);
                                }));
                              },
                              icon: const Icon(Icons.play_arrow_rounded),
                            ),
                            Text(video['name'].toString()),
                          ],
                        );
                        //print("reached erors");

                        videoWidgets.add(videoWidget);
                      }
                    }
                    return Expanded(
                        child: ListView(
                      children: videoWidgets,
                    ));
                  })),
            ],
          ),
        )));
  }
  Future<void> _deleteCacheDir() async {
    var tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }
}
