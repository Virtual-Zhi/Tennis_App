import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../objects/team.dart';
import '../../controllers/ListControllers.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
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
        title:
            Text("Create a Tournament", style: Theme.of(context).textTheme.headline6),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: dataList().getListDynamic().length,
                itemBuilder: (_, index) => teamBlock(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget teamBlock(int index)
  {
    teamWidget team = dataList().getListDynamic()[index];
    return InkWell(
      onTap: () {}, //Select Team
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
            height: 150,
            width: MediaQuery.of(context).size.width < 650 ? 325 : 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AutoSizeText(
                    team.getName(),
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
}