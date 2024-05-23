import 'dart:io';
import 'package:app_apk/utils/math.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class StoreVideoData {
  late String playerName, id, teamId;

  StoreVideoData(this.playerName, this.id, this.teamId);

  Future<String> uploadVideo(String videoUrl) async {
    Reference ref = _storage
        .ref()
        .child(getfireBaseUser() + '/' + playerName + '/${DateTime.now()}.mp4');
    await ref.putFile(File(videoUrl));
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> saveVideoData(String videoDownloadUrl, String name) async {
    await _fireStore
        .collection(getfireBaseUser())
        .doc(teamId)
        .collection("players")
        .doc(id)
        .collection("videos")
        .add({
          'url': videoDownloadUrl,
          'timeStamp': FieldValue.serverTimestamp(),
          'name': name
        });
  }

}
