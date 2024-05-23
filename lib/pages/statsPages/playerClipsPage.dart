// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:app_apk/utils/fireBaseUtil.dart';
import 'package:app_apk/utils/math.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

import '../../controllers/playerData.dart';

class playerclipsPage extends StatefulWidget {
  late String name, id, teamId;

  playerclipsPage(this.name, this.id, this.teamId, {super.key});

  @override
  State<playerclipsPage> createState() => _playerclipsPageState(name);
}

class _playerclipsPageState extends State<playerclipsPage> {
  late String name;

  String? _videoURL, _downloadURL;

  VideoPlayerController? _controller;
  TextEditingController myController = TextEditingController();

  late playerData player;

  _playerclipsPageState(this.name);

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
            onPressed: () {
              _deleteCacheDir();
              Navigator.pop(context);
            },
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              color: Colors.black,
            )),
        title:
            Text("Upload Clips", style: Theme.of(context).textTheme.headline6),
      ),
      body: Center(
          child: _videoURL != null
              ? _videoPreviewWidget(context)
              : Text("No Video Selected")),
      floatingActionButton: FloatingActionButton(
          onPressed: _pickVideo, child: Icon(Icons.video_library)),
    );
  }

  void _pickVideo() async {
    _videoURL = await pickVideo();
    if (_videoURL != null) {
      print("VIDEO");
    }
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.file(File(_videoURL!))
      ..initialize().then((_) {
        setState(() {
          _controller!.play();
        });
      });
  }

  Widget _videoPreviewWidget(context) {
    if (_controller != null) {
      return Column(
        children: [
          Container(
            width: 100,
            height: 100,
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
          ),
          ElevatedButton(
              onPressed: () => showDialogue(context), child: Text("Upload")),
        ],
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  Future<void> _deleteCacheDir() async {
    var tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  void _uploadVideo(String nameOfVideo) async {
    _downloadURL = await StoreVideoData(name, widget.id, widget.teamId)
        .uploadVideo(_videoURL!);
    await StoreVideoData(name, widget.id, widget.teamId)
        .saveVideoData(_downloadURL!, nameOfVideo);
    setState(() {
      _videoURL = null;
    });
  }

  void showDialogue(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: myController,
                          decoration: InputDecoration(
                            hintText: "Enter a name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _uploadVideo(myController.text);
                          myController.clear();
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Text("Submit"),
                      )
                    ],
                  )));
        });
  }
}
