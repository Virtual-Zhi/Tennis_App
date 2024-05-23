// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'package:app_apk/controllers/ListControllers.dart';
import 'package:app_apk/objects/team.dart';
import 'package:app_apk/pages/statsPages/notesPage.dart';
import 'package:app_apk/pages/statsPages/playerstatsPage.dart';
import 'package:app_apk/pages/statsPages/videoList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../controllers/playerData.dart';
import '../pages/playerPage.dart';
import '../pages/statsPages/playerClipsPage.dart';

class playerWidget extends StatelessWidget {
  late String nameOfWidget, id;

  late playerData player;

  late teamWidget team;

  late Function update, remove;

  bool isSelected = false;

  final myController = TextEditingController();

  playerWidget(String name, this.player, this.id, this.team,
      {super.key, required this.update, required this.remove}) {
    nameOfWidget = name;
  }

  playerWidget.fromplayerWidget(String name, this.id, this.player, this.team) {
    nameOfWidget = name;
  }

  teamWidget getTeam() {
    return team;
  }

  String getName() {
    return nameOfWidget;
  }

  playerData getPlayerData() {
    return player;
  }

  String getId() {
    return id;
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff56ab2f),
                  Color(0xffa8e063),
                ],
              ),
              border: Border.all(color: Colors.white70),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            margin: const EdgeInsets.only(bottom: 20, top: 20),
            height: 175,
            width: MediaQuery.of(context).size.width < 650 ? 325 : 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 35,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        child: PopupMenuButton(
                            onSelected: (value) {
                              if (value == "Delete") {
                                remove(nameOfWidget, id);
                              } else if (value == "Rename") {
                                showDialogue(context);
                              }
                            },
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: "Rename",
                                    child: Text("Rename"),
                                  ),
                                  PopupMenuItem(
                                    value: "Delete",
                                    child: Text("Delete"),
                                  )
                                ]),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    nameOfWidget,
                    style: GoogleFonts.exo2(
                        color: Colors.white,
                        fontSize: 100,
                        fontWeight: FontWeight.bold),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildText("FH: " +
                          ((player.getStatsList()[0][0] /
                                      (player.getStatsList()[1][0] +
                                          player.getStatsList()[0][0])) *
                                  100)
                              .toStringAsFixed(1) +
                          "%"),
                      SizedBox(width: 10),
                      _buildText("BH: " +
                          ((player.getStatsList()[0][1] /
                                      (player.getStatsList()[1][1] +
                                          player.getStatsList()[0][1])) *
                                  100)
                              .toStringAsFixed(1) +
                          "%"),
                      SizedBox(width: 10),
                      _buildText("Vol: " +
                          ((player.getStatsList()[0][2] /
                                      (player.getStatsList()[1][2] +
                                          player.getStatsList()[0][2])) *
                                  100)
                              .toStringAsFixed(1) +
                          "%"),
                      SizedBox(width: 10),
                      _buildText("OH: " +
                          ((player.getStatsList()[0][3] /
                                      (player.getStatsList()[1][3] +
                                          player.getStatsList()[0][3])) *
                                  100)
                              .toStringAsFixed(1) +
                          "%"),
                      SizedBox(width: 10),
                      _buildText("Srv: " +
                          ((player.getStatsList()[0][4] /
                                      (player.getStatsList()[1][4] +
                                          player.getStatsList()[0][4])) *
                                  100)
                              .toStringAsFixed(1) +
                          "%"),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scaleX: 0.9,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => playerstatsPage(
                                        nameOfWidget, player, id, team.id)));
                          },
                          icon: Icon(Icons.numbers_outlined),
                          label: Text("Stats")),
                    ),
                    SizedBox(width: 2),
                    Transform.scale(
                      scaleX: 0.9,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        videoList(nameOfWidget, id, team.id)));
                          },
                          icon: Icon(Icons.note),
                          label: Text("Clips")),
                    ),
                    SizedBox(width: 2),
                    Transform.scale(
                      scaleX: 0.9,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        notesPage(nameOfWidget, team.id, id)));
                          },
                          icon: Icon(Icons.note),
                          label: Text("Notes")),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: GoogleFonts.exo2(
          color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.bold),
      maxLines: 2,
      textAlign: TextAlign.center,
    );
  }

  String getfireBaseUser() {
    final User user = FirebaseAuth.instance.currentUser!;
    return user.uid;
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
                          nameOfWidget = myController.text;
                          myController.clear();
                          Navigator.of(context, rootNavigator: true).pop();
                          update();
                        },
                        child: const Text("Submit"),
                      )
                    ],
                  )));
        });
  }
}
