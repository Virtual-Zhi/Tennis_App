import "package:app_apk/utils/app_style.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, this.id, this.teamID, this.playerID, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  String id, teamID, playerID;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: "Delete Note",
            onPressed: () {
              FirebaseFirestore.instance
                  .collection(getfireBaseUser())
                  .doc(widget.teamID).collection("players").doc(widget.playerID).collection("playerNotes").doc(widget.id)
                  .delete();

              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_title"],
              style: AppStyle.mainTitle,
            ),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.dateTitle,
            ),
            Text(
              widget.doc["note_content"],
              style: AppStyle.mainContent,
             
            ),
          ],
        ),
      ),
    );
  }


  String getfireBaseUser() {
    final User user = FirebaseAuth.instance.currentUser!;
    return user.uid;
  }
}
