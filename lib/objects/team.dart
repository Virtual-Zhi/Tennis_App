// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'package:app_apk/controllers/ListControllers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../pages/playerPage.dart';

class teamWidget extends StatelessWidget {
  late String nameOfWidget, id;

  late Function update, remove;

  final myController = TextEditingController();

  teamWidget(String name,
      {super.key, required this.update, required this.remove, required this.id}) {
    nameOfWidget = name;
  }

  teamWidget.fromteamWidget(String name, this.id) {
    nameOfWidget = name;
  }

  String getName() {
    return nameOfWidget;
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => playerPage(nameOfWidget, this)));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
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
                                remove(nameOfWidget);
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
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
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
