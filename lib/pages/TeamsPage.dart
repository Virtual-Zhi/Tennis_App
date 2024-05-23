// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'package:app_apk/controllers/playerData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ListControllers.dart';
import '../main.dart';
import '../objects/player.dart';
import '../objects/team.dart';
import '../objects/widgets/header.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final myController = TextEditingController();

  addDynamic(teamWidget x) {
    dataList().addDynamic(x);
    _callBack();
  }

  removeDynamic(String name) {
    for (teamWidget x in dataList().getListDynamic()) {
      if (x.getName() == name) {
        FirebaseFirestore.instance
            .collection(getfireBaseUser())
            .doc(x.id)
            .delete();
        dataList().removeDynamic(x);
        break;
      }
    }
    _callBack();
  }

  addPlayer(teamWidget team, String name, playerData player, String id) {
    dataList().addPlayer(team,
        playerWidget(name, player,id, team, update: _callBack, remove: removeDynamic));
    _callBack();
  }

  removePlayer(teamWidget team, String name) {
    for (playerWidget x in dataList().getPlayers(team)) {
      if (x.getName() == name) {
        dataList().removePlayer(team, x);
        break;
      }
    }
    _callBack();
  }

  void _callBack() {
    for (teamWidget team in dataList().getListDynamic()) {
      FirebaseFirestore.instance
          .collection(getfireBaseUser())
          .doc(team.id)
          .update({"team_Name": team.getName()});
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    for (teamWidget team in dataList().getListDynamic()) {
      teamWidget test = teamWidget(team.getName(),
          update: _callBack, remove: removeDynamic, id: team.id);
      addDynamic(test);

      for (playerWidget x in dataList().getPlayers(team)) {
        removePlayer(test, x.getName());
        addPlayer(test, x.getName(), x.getPlayerData(), x.getId());
      }
      dataList().removeDynamic(team);
    }

    return Scaffold(
      appBar: header(Colors.white, "Teams"),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: dataList().getListDynamic().length,
                itemBuilder: (_, index) => dataList().getListDynamic()[index],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModalBottomSheet(context),
        child: Icon(Icons.add, size: 30),
      ),
    );
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
                          String text = myController.text;
                          FirebaseFirestore.instance
                              .collection(getfireBaseUser())
                              .add({
                            "team_Name": text,
                          }).then((value) => addDynamic(teamWidget(
                                  text,
                                  update: _callBack,
                                  remove: removeDynamic,
                                  id: value.id)));
                          myController.clear();
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

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        // constraints: BoxConstraints(
        //   maxWidth: MediaQuery.of(context).size.width > 650 ? Get.width : 650,
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.4,
            maxChildSize: 1,
            minChildSize: 0.3,
            builder: (context, scrollController) => SizedBox(
                  width: context.width,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -15,
                          child: Container(
                            width: 150,
                            height: 7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: 350,
                              height: 60,
                              child: ElevatedButton.icon(
                                onPressed: () => showDialogue(context),
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                icon: Icon(Icons.folder),
                                label: Text(
                                  "Add a team",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
