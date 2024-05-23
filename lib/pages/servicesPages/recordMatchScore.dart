// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:app_apk/objects/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/math.dart';

class recordMatch extends StatefulWidget {
  playerWidget player1, player2;
  int sets;

  recordMatch(this.player1, this.player2, this.sets, {super.key});

  @override
  State<recordMatch> createState() => _recordMatchState();
}

class _recordMatchState extends State<recordMatch> {
  List gamePointsP1 = [0, 0, 0]; //0 == point, 1==game, 2==set
  List gamePointsP2 = [0, 0, 0];

  void addPoint(int player) {
    if (player == 0) {
      if (gamePointsP1[0] < 40) {
        gamePointsP1[0] += 15;
        if (gamePointsP1[0] >= 40) {
          gamePointsP1[0] = 40;
        }
      } else if (gamePointsP1[0] >= 40) {
        if (gamePointsP1[0] == 40 && gamePointsP1[0] <= gamePointsP2[0]) {
          gamePointsP1[0] += 5;
          if (gamePointsP2[0] > 40) {
            gamePointsP2[0] -= 5;
          }
        } else {
          addGame(0);
          gamePointsP1[0] = 0;
          gamePointsP2[0] = 0;
        }
      }
    } else {
      if (gamePointsP2[0] < 40) {
        gamePointsP2[0] += 15;
        if (gamePointsP2[0] >= 40) {
          gamePointsP2[0] = 40;
        }
      } else if (gamePointsP2[0] >= 40) {
        if (gamePointsP2[0] == 40 && gamePointsP2[0] <= gamePointsP1[0]) {
          gamePointsP2[0] += 5;
          if (gamePointsP1[0] > 40) {
            gamePointsP1[0] -= 5;
          }
        } else {
          addGame(1);
          gamePointsP1[0] = 0;
          gamePointsP2[0] = 0;
        }
      }
    }
    _callBack();
  }

  void addGame(int player) {
    if (player == 0) {
      gamePointsP1[1] += 1;
      if (gamePointsP1[1] >= 6 &&
          (gamePointsP1[1] - gamePointsP2[1]).abs() > 2) {
        addSet(0);
        gamePointsP1[1] = 0;
        gamePointsP2[1] = 0;
      }
    } else {
      gamePointsP2[1] += 1;
      if (gamePointsP2[1] >= 6 &&
          (gamePointsP1[1] - gamePointsP2[1]).abs() > 2) {
        addSet(1);
        gamePointsP1[1] = 0;
        gamePointsP2[1] = 0;
      }
    }
    _callBack();
  }

  void addSet(int player) {
    if (player == 0) {
      gamePointsP1[2] += 1;
    } else {
      gamePointsP2[2] += 1;
    }
    if (gamePointsP1[2] - gamePointsP2[2] > 1 &&
        gamePointsP1[2] >= widget.sets) {
      //Player One wins
      Navigator.pop(context);
      winnerDialog(context, widget.player1.getName());
      widget.player1.getPlayerData().getStatsList()[0][5] += 1;
      widget.player2.getPlayerData().getStatsList()[1][5] += 1;
      final collection = FirebaseFirestore.instance
          .collection(getfireBaseUser())
          .doc(widget.player1.getTeam().id)
          .collection("players")
          .doc(widget.player1.getId());
      collection.update({
        "playerData.WinLoss.Hit":
            widget.player1.getPlayerData().getStatsList()[0][5],
        "playerData.WinLoss.Miss":
            widget.player1.getPlayerData().getStatsList()[1][5],
      });
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else if (gamePointsP2[2] - gamePointsP1[2] > 1 &&
        gamePointsP2[2] >= widget.sets) {
      Navigator.pop(context);
      winnerDialog(context, widget.player2.getName());
      widget.player2.getPlayerData().getStatsList()[0][5] += 1;
      widget.player1.getPlayerData().getStatsList()[1][5] += 1;
      final collection = FirebaseFirestore.instance
          .collection(getfireBaseUser())
          .doc(widget.player2.getTeam().id)
          .collection("players")
          .doc(widget.player2.getId());
      collection.update({
        "playerData.WinLoss.Hit":
            widget.player2.getPlayerData().getStatsList()[0][5],
        "playerData.WinLoss.Miss":
            widget.player2.getPlayerData().getStatsList()[1][5],
      });
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      //Player Two Wins
    }
    _callBack();
  }

  void _callBack() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.player1.getName() + " VS " + widget.player2.getName()),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp]);
            },
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Points: " +
                        (gamePointsP1[0] > 40
                            ? "Add-in"
                            : gamePointsP1[0].toString())),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text("Games: " + gamePointsP1[1].toString()),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text("Sets: " + gamePointsP1[2].toString()),
                  ],
                ),
                SizedBox(
                  width: 650,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Points: " +
                        (gamePointsP2[0] > 40
                            ? "Add-in"
                            : gamePointsP2[0].toString())),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text("Games: " + gamePointsP2[1].toString()),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text("Sets: " + gamePointsP2[2].toString()),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              raiseButtion("Double Fault " + widget.player1.getName(), () {
                addPoint(1);
              }),
              raiseButtion("Double Fault " + widget.player2.getName(), () {
                addPoint(0);
              }),
            ],
          ),
          Row(
            children: [
              raiseButtion("Point " + widget.player1.getName(), () {
                addPoint(0);
              }),
              raiseButtion("Point " + widget.player2.getName(), () {
                addPoint(1);
              }),
            ],
          ),
          Row(
            children: [
              raiseButtion("Game + 1 " + widget.player1.getName(), () {
                addGame(0);
              }),
              raiseButtion("Game + 1 " + widget.player2.getName(), () {
                addGame(1);
              }),
            ],
          ),
          Row(
            children: [
              raiseButtion("Set + 1 " + widget.player1.getName(), () {
                addSet(0);
              }),
              raiseButtion("Set + 1 " + widget.player2.getName(), () {
                addSet(1);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget raiseButtion(String text, onPress) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 7.3,
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )),
      ),
    );
  }

  void winnerDialog(context, String name) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: SizedBox(
            height: 100,
            child: Center(
                child: Column(
              children: [
                SizedBox(height: 20),
                Text(name + " won the match!"),
                SizedBox(
                  height: 5,
                ),
              ],
            )),
          ));
        });
  }
}
