import 'package:app_apk/controllers/playerData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/math.dart';

class addPlayerStats extends StatefulWidget {
  late String name, id, teamId;
  late int statId;

  late playerData player;

  addPlayerStats(
      String name, this.id, this.teamId, this.player, this.statId,
      {Key? key})
      : super(key: key) {
    this.name = name;
  }

  @override
  State<addPlayerStats> createState() => _addPlayerStatsState();
}

class _addPlayerStatsState extends State<addPlayerStats> {
  int hit = 0;
  int miss = 0;

  void _callBack() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.name + " Session"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                widget.player.getStatsList()[0][widget.statId - 1] += hit;
                widget.player.getStatsList()[1][widget.statId - 1] += miss;
                final collection = FirebaseFirestore.instance
                    .collection(getfireBaseUser())
                    .doc(widget.teamId)
                    .collection("players")
                    .doc(widget.id);
                collection.update({
                  "playerData." + widget.name + ".Hit":
                      widget.player.getStatsList()[0][widget.statId - 1],
                  "playerData." + widget.name + ".Miss":
                      widget.player.getStatsList()[1][widget.statId - 1]
                });
                _callBack();
                Navigator.pop(context, true);
              }),
        ),
        body: Center(
            child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Text("Total: " + (hit + miss).toString()),
                  SizedBox(
                    width: 25,
                  ),
                  Text("Hit: " + hit.toString()),
                  SizedBox(
                    width: 25,
                  ),
                  Text("Miss: " + miss.toString()),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: ElevatedButton.icon(
                  onPressed: () {
                    hit += 1;
                    _callBack();
                  },
                  icon: Icon(Icons.add),
                  label: Text("Hit"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: ElevatedButton.icon(
                  onPressed: () {
                    miss += 1;
                    _callBack();
                  },
                  icon: Icon(Icons.add),
                  label: Text("Miss"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                )),
          ],
        )));
  }
}
