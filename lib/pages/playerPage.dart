import 'package:app_apk/controllers/playerData.dart';
import 'package:app_apk/main.dart';
import 'package:app_apk/objects/player.dart';
import 'package:app_apk/objects/team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controllers/ListControllers.dart';

class playerPage extends StatefulWidget {
  late String nameOfTeam;

  late teamWidget team;

  playerPage(String name, teamWidget x, {Key? key}) : super(key: key) {
    nameOfTeam = name;
    team = x;
  }

  @override
  State<playerPage> createState() => _playerPageState(nameOfTeam, team);
}

class _playerPageState extends State<playerPage> {
  late String nameOfTeam;

  late teamWidget team;

  TextEditingController myController = TextEditingController();
  TextEditingController FHController = TextEditingController();
  TextEditingController BHController = TextEditingController();
  TextEditingController OHController = TextEditingController();
  TextEditingController ServeController = TextEditingController();
  TextEditingController VController = TextEditingController();

  _playerPageState(String name, teamWidget x) {
    nameOfTeam = name;
    team = x;
  }

  void _callBack() {
    for (playerWidget player in dataList().getPlayers(team)) {
      FirebaseFirestore.instance
          .collection(getfireBaseUser())
          .doc(team.id)
          .collection("players")
          .doc(player.id)
          .update({"player_Name": player.getName()});
    }
    setState(() {});
  }

  addDynamic(String name, playerData player, String id) async {
    List<List<dynamic>> pStats = player.getStatsList();
    try {
      final collection = FirebaseFirestore.instance
          .collection(getfireBaseUser())
          .doc(team.id)
          .collection("players")
          .doc(id);
      collection.update({
        "playerData.Forehand.Hit": pStats[0][0],
        "playerData.Forehand.Miss": pStats[1][0],
        "playerData.Backhand.Hit": pStats[0][1],
        "playerData.Backhand.Miss": pStats[1][1],
        "playerData.Volley.Hit": pStats[0][2],
        "playerData.Volley.Miss": pStats[1][2],
        "playerData.Overhead.Hit": pStats[0][3],
        "playerData.Overhead.Miss": pStats[1][3],
        "playerData.Serve.Hit": pStats[0][4],
        "playerData.Serve.Miss": pStats[1][4],
        "playerData.WinLoss.Hit": pStats[0][5],
        "playerData.WinLoss.Miss": pStats[1][5],
      });
    } on FirebaseAuthException {
      rethrow;
    }

    dataList().addPlayer(
        team,
        playerWidget(name, player, id, team,
            update: _callBack, remove: removeFromDataBase));
    _callBack();
  }

  removeFromDataBase(String name, String id) {
    for (playerWidget x in dataList().getPlayers(team)) {
      if (x.getName() == name) {
        dataList().removePlayer(team, x);
        FirebaseFirestore.instance
            .collection(getfireBaseUser())
            .doc(team.id)
            .collection("players")
            .doc(id)
            .delete();
        break;
      }
      _callBack();
    }
  }

  removeDynamic(String name) {
    for (playerWidget x in dataList().getPlayers(team)) {
      if (x.getName() == name) {
        dataList().removePlayer(team, x);
        break;
      }
    }
    _callBack();
  }

  

  @override
  Widget build(BuildContext context) {
    for (playerWidget x in dataList().getPlayers(team)) {
      print(x.getName());
      removeDynamic(x.getName());
      addDynamic(x.getPlayerData().getName(), x.getPlayerData(), x.getId());
    }
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(nameOfTeam + "'s Players"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  itemCount: dataList().getPlayers(team).length,
                  itemBuilder: (_, index) => dataList().getPlayers(team)[index],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialogue(context),
          child: const Icon(Icons.add, size: 30),
        ),
      ),
    );
  }

  void showDialogue(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: SizedBox(
                  height: 420,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: myController,
                          decoration: const InputDecoration(
                            hintText: "Enter a name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 350,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: FHController,
                          decoration: const InputDecoration(
                            hintText: "Out of 10, how many forehands hit?",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 350,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: BHController,
                          decoration: const InputDecoration(
                            hintText: "Out of 10, how many backhands hit?",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 350,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: VController,
                          decoration: const InputDecoration(
                            hintText: "Out of 10, how many volleys hit?",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 350,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: OHController,
                          decoration: const InputDecoration(
                            hintText: "Out of 10, how many overheads hit?",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 350,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: ServeController,
                          decoration: const InputDecoration(
                            hintText: "Out of 10, how many serves hit?",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          String text = myController.text;
                          playerData p = playerData(text, 12, true);
                          p.getStatsList()[0][0] =
                              double.parse(FHController.text);
                          p.getStatsList()[1][0] =
                              10 - double.parse(FHController.text);
                          p.getStatsList()[0][1] =
                              double.parse(BHController.text);
                          p.getStatsList()[1][1] =
                              10 - double.parse(BHController.text);
                          p.getStatsList()[0][2] =
                              double.parse(VController.text);
                          p.getStatsList()[1][2] =
                              10 - double.parse(VController.text);
                          p.getStatsList()[0][3] =
                              double.parse(OHController.text);
                          p.getStatsList()[1][3] =
                              10 - double.parse(OHController.text);
                          p.getStatsList()[0][4] =
                              double.parse(ServeController.text);
                          p.getStatsList()[1][4] =
                              10 - double.parse(ServeController.text);
                          p.getStatsList()[0][5] = 0;
                          p.getStatsList()[1][5] = 0;
                          FirebaseFirestore.instance
                              .collection(getfireBaseUser())
                              .doc(team.id)
                              .collection("players")
                              .add({
                            "player_Name": text,
                          }).then((value) => addDynamic(text, p, value.id));
                          myController.clear();
                          FHController.clear();
                          BHController.clear();
                          VController.clear();
                          OHController.clear();
                          ServeController.clear();
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Text("Submit"),
                      )
                    ],
                  )));
        });
  }

  String getfireBaseUser() {
    final User user = FirebaseAuth.instance.currentUser!;
    return user.uid;
  }
}
