// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_apk/pages/statsPages/addPlayerStats.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../controllers/playerData.dart';

class playerstatsPage extends StatefulWidget {
  late String name, id, teamId;

  late playerData player;

  playerstatsPage(String name, this.player, this.id, this.teamId, {Key? key})
      : super(key: key) {
    this.name = name;
  }

  @override
  State<playerstatsPage> createState() => _playerstatsPageState();
}

class _playerstatsPageState extends State<playerstatsPage> {
  late double UTR;

  _playerstatsPageState() {}

  double calculateUTR() {
    double total = 0;
    for (int i = 0; i < 5; i++) {
      total += (widget.player.getStatsList()[0][i] /
          (widget.player.getStatsList()[1][i] +
              widget.player.getStatsList()[0][i]));
    }
    if (widget.player.getStatsList()[1][5] +
            widget.player.getStatsList()[0][5] >
        0) {
      if (widget.player.getStatsList()[1][5] > 1) {
        total -= (widget.player.getStatsList()[0][5] /
                (widget.player.getStatsList()[1][5] +
                    widget.player.getStatsList()[0][5])) *
            (widget.player.getStatsList()[1][5] +
                        widget.player.getStatsList()[0][5] >=
                    5
                ? 5
                : widget.player.getStatsList()[1][5] +
                    widget.player.getStatsList()[0][5]);
      }
      total += (widget.player.getStatsList()[0][5] /
              (widget.player.getStatsList()[1][5] +
                  widget.player.getStatsList()[0][5])) *
          (widget.player.getStatsList()[1][5] +
                      widget.player.getStatsList()[0][5] >=
                  9
              ? 9
              : widget.player.getStatsList()[1][5] +
                    widget.player.getStatsList()[0][5]);
    }
    double UTRRating = total;
    return UTRRating;
  }

  _callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              color: Colors.black,
            )),
        title: Text(widget.name + " stats",
            style: Theme.of(context).textTheme.headline6),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 390,
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  border: Border.all(color: Colors.white70),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 5,
                      offset: Offset(0, 1.5),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    "Overall",
                    style: GoogleFonts.exo2(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          CircularPercentIndicator(
                            radius: 60,
                            lineWidth: 25,
                            percent: calculateUTR() / 14,
                            center: Text(
                              calculateUTR().toStringAsFixed(1),
                              style: GoogleFonts.exo2(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                            progressColor: Colors.green,
                            backgroundColor: Colors.deepPurpleAccent,
                          ),
                          AutoSizeText("Player Rating (UTR)",
                              style: GoogleFonts.explora(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 75,
                      ),
                      AutoSizeText("*Insert Picture*"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.5,
            ),
            Divider(),
            SizedBox(
              height: 2.5,
            ),
            buildProgress(
                "Forehand",
                widget.player.getStatsList()[0][0] + 0.0,
                widget.player.getStatsList()[1][0] +
                    widget.player.getStatsList()[0][0] +
                    0.0,
                1,
                false),
            SizedBox(
              height: 2.5,
            ),
            buildProgress(
                "Backhand",
                widget.player.getStatsList()[0][1] + 0.0,
                widget.player.getStatsList()[1][1] +
                    widget.player.getStatsList()[0][1] +
                    0.0,
                2,
                false),
            SizedBox(
              height: 2.5,
            ),
            buildProgress(
                "Volley",
                widget.player.getStatsList()[0][2] + 0.0,
                widget.player.getStatsList()[1][2] +
                    widget.player.getStatsList()[0][2] +
                    0.0,
                3,
                false),
            SizedBox(
              height: 2.5,
            ),
            buildProgress(
                "Overhead",
                widget.player.getStatsList()[0][3] + 0.0,
                widget.player.getStatsList()[1][3] +
                    widget.player.getStatsList()[0][3] +
                    0.0,
                4,
                false),
            SizedBox(
              height: 2.5,
            ),
            buildProgress(
                "Serve",
                widget.player.getStatsList()[0][4] + 0.0,
                widget.player.getStatsList()[1][4] +
                    widget.player.getStatsList()[0][4] +
                    0.0,
                5,
                false),
            SizedBox(
              height: 2.5,
            ),
            buildProgress(
                "WinLoss",
                widget.player.getStatsList()[0][5] + 0.0,
                widget.player.getStatsList()[1][5] +
                    widget.player.getStatsList()[0][5] +
                    0.0,
                6,
                true),
          ],
        ),
      ),
    );
  }

  Widget buildProgress(
      String name, double hit, double max, int statID, bool winLoss) {
    return SizedBox(
      width: 400,
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10.5,
              ),
              AutoSizeText(
                  name + ": " + (hit / max * 100).toStringAsFixed(2) + "%",
                  style: GoogleFonts.exo2(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: 2.5,
          ),
          Row(
            children: [
              LinearPercentIndicator(
                  width: 290, lineHeight: 15, percent: hit / max),
              winLoss == false
                  ? ColoredBox(
                      color: Colors.lightBlueAccent.shade100,
                      child: SizedBox(
                          width: 50,
                          height: 40,
                          child: IconButton(
                            icon: Icon(LineAwesomeIcons.plus),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addPlayerStats(
                                          name,
                                          widget.id,
                                          widget.teamId,
                                          widget.player,
                                          statID)));
                            },
                          )))
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
