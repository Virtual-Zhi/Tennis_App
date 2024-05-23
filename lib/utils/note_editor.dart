// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:app_apk/utils/app_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NoteEditorScreen extends StatefulWidget {
  late String name, teamID, playerID;

  NoteEditorScreen(this.name, this.teamID, this.playerID, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<NoteEditorScreen> createState() => _NoteEditorScreenState(name);
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late String name;

  _NoteEditorScreenState(this.name);

  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Add a new Note", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 8),
            Text(date, style: AppStyle.dateTitle),
            SizedBox(height: 28),
            TextField(
                controller: _mainController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type Something",
                ),
                style: AppStyle.mainContent)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () {
          FirebaseFirestore.instance
              .collection(getfireBaseUser())
              .doc(widget.teamID)
              .collection("players")
              .doc(widget.playerID)
              .collection("playerNotes")
              .add({
            "note_title": _titleController.text,
            "creation_date": date,
            "note_content": _mainController.text,
            "color_id": color_id,
            "player_Name": name,
          }).then((value) => Navigator.pop(context));
        },
        child: Icon(Icons.save),
      ),
    );
  }

  String getfireBaseUser() {
    final User user = FirebaseAuth.instance.currentUser!;
    return user.uid;
  }
}
