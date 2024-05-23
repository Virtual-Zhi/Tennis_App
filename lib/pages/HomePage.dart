// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:app_apk/controllers/ListControllers.dart';
import 'package:app_apk/pages/servicesPages/match.dart';
import 'package:app_apk/pages/servicesPages/tournmentPage.dart';
import 'package:app_apk/pages/servicesPages/videoGuides.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../objects/widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(Colors.white, "Home"),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              height: 90,
              width: MediaQuery.of(context).size.width < 650 ? 325 : 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      AutoSizeText("My Players"),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 55,
                    width: MediaQuery.of(context).size.width < 650 ? 325 : 400,
                    child: Row(
                      children: dataList().getAllPlayers()
                          .map<Widget>((player) => Text("hey"))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => matchPage()));
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  height: 180,
                  width: MediaQuery.of(context).size.width < 650 ? 325 : 400,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          AutoSizeText("Record a match"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 140,
                        width:
                            MediaQuery.of(context).size.width < 650 ? 325 : 400,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Transform.rotate(
                          angle: 90 * pi / 180,
                          child: Image.asset('assets/images/tennis-court.png',
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              height: 210,
              width: MediaQuery.of(context).size.width < 650 ? 325 : 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      AutoSizeText("Helpful Tips"),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 175,
                    width: MediaQuery.of(context).size.width < 650 ? 325 : 400,
                    child: Column(
                      children: [
                        SizedBox(height: 5,),
                        buildVideoOptions("Forehand Guides", 100),
                        SizedBox(height: 10,),
                        buildVideoOptions("Backhand Guides", 97),
                        SizedBox(height: 10,),
                        buildVideoOptions("Volley Guides", 125),
                        SizedBox(height: 10,),
                        buildVideoOptions("Serve Guides", 129.5),
                        SizedBox(height: 10,),
                        buildVideoOptions("Game Strategies", 102.5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 30,
              width: 300,
              child: ElevatedButton.icon(onPressed: (){
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TournamentPage()));
              }, icon: Icon(Icons.view_module_sharp), label: Text("Generate Tournament")),
            )

          ],
        ),
      ),
    );
  }

  Widget buildVideoOptions(String name, double gap) {
    return Center(
      child: Row(
        children: [
          SizedBox(width: 10,),
          AutoSizeText(name, style: GoogleFonts.exo2(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: gap),
          SizedBox(
            height: 25,
            width: 80,
            child: ElevatedButton(onPressed: (){
              Navigator.push(context,
                        MaterialPageRoute(builder: (context) => videoGuide(name)));
            }, child: AutoSizeText("Open"))
          ),
        ],
      
      ),
    );
  }
}
