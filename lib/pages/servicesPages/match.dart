// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:app_apk/controllers/ListControllers.dart';
import 'package:app_apk/objects/player.dart';
import 'package:app_apk/pages/servicesPages/recordMatchScore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class matchPage extends StatefulWidget {
  const matchPage({super.key});

  @override
  State<matchPage> createState() => _matchPageState();
}

class _matchPageState extends State<matchPage> {
  final Queue = ListQueue<playerWidget>();
  var selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select Two Players",
            style: GoogleFonts.exo2(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        leading: IconButton(
            onPressed: () {
              if (!Queue.isEmpty) {
                Queue.first.isSelected = false;
                Queue.last.isSelected = false;
              }
              Navigator.of(context).pop();
            },
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: dataList().getAllPlayers().length,
                  itemBuilder: (BuildContext context, int index) {
                    return playerItem(dataList().getAllPlayers()[index]);
                  }),
            ),
            Queue.length >= 2
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                        ),
                        child: Text(
                          "Selected(${Queue.length})",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          Queue.first.isSelected = false;
                          Queue.last.isSelected = false;
                          dialog(context);
                          /*Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      recordMatch(Queue.first, Queue.last)));
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.landscapeLeft]);*/
                        },
                      ),
                    ))
                : Container(),
          ],
        ),
      )),
    );
  }

  void dialog(context) {
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
                Text("How many set will you be playing?"),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    setButton(1),
                    SizedBox(width: 10,),
                    setButton(3),
                    SizedBox(
                      width: 10,
                    ),
                    setButton(6)
                  ],
                )
              ],
            )),
          ));
        });
  }

  Widget setButton(int set) {
    return ElevatedButton(onPressed: () {
      Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      recordMatch(Queue.first, Queue.last, set)));
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.landscapeLeft]);
    }, child: Text(set.toString() + " Sets"));
  }

  Widget playerItem(playerWidget player) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.person_outline_outlined,
            color: Colors.white,
          ),
        ),
        title: Text(
          player.getName() + " (" + player.getTeam().getName() + ")",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: player.isSelected
            ? Icon(
                Icons.check_circle,
                color: Colors.blueAccent,
              )
            : Icon(
                Icons.check_circle_outline,
                color: Colors.grey,
              ),
        onTap: () {
          setState(() {
            if (selected >= 2) {
              Queue.removeFirst().isSelected = false;
              selected -= 1;
            }
            player.isSelected = !player.isSelected;
            if (player.isSelected == true) {
              Queue.add(player);
              selected += 1;
            } else if (player.isSelected == false) {
              Queue.remove(player);
              selected -= 1;
            }
          });
        });
  }
}
