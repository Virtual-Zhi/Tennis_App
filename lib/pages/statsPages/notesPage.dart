import 'package:app_apk/objects/widgets/note_card.dart';
import 'package:app_apk/utils/note_editor.dart';
import 'package:app_apk/utils/note_reader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class notesPage extends StatefulWidget {
  late String name, teamID, playerID;

  notesPage(String name, this.teamID, this.playerID, {Key? key}) : super(key: key) {
    this.name = name;
  }

  @override
  State<notesPage> createState() => _notesPageState(name);
}

class _notesPageState extends State<notesPage> {
  late String name;

  _notesPageState(String name) {
    this.name = name;
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
        title:
            Text(name + " Notes", style: Theme.of(context).textTheme.headline6),
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(getfireBaseUser()).doc(widget.teamID).collection("players").doc(widget.playerID).collection("playerNotes")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        int count = 0;
                        for (QueryDocumentSnapshot note
                            in snapshot.data!.docs) {
                          if (note.get("player_Name") == name) {
                            count++;
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: count,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.docs[index]
                                        .get("player_Name") ==
                                    name) {
                                  QueryDocumentSnapshot note =
                                      snapshot.data!.docs[index];
                                  return noteCard(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NoteReaderScreen(
                                                    note, note.id, widget.teamID, widget.playerID)));
                                  }, note);
                                }
                              }),
                        );
                      }
                      return Text("there are no notes");
                    }),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteEditorScreen(name, widget.teamID, widget.playerID),
                ));
          },
          label: Text("Add Note"),
          icon: Icon(Icons.add)),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return SizedBox(
      width: 400,
      height: 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon:
              isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.email),
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _buildLineBreakWithText(String text) {
    return Row(
      children: [
        Expanded(
            child: new Container(
          margin: EdgeInsets.only(left: 10, right: 20),
          child: Divider(
            color: Colors.grey,
            height: 36,
          ),
        )),
        Text(text),
        Expanded(
            child: new Container(
          margin: EdgeInsets.only(left: 10, right: 20),
          child: Divider(
            color: Colors.grey,
            height: 36,
          ),
        )),
      ],
    );
  }

  String getfireBaseUser() {
    final User user = FirebaseAuth.instance.currentUser!;
    return user.uid;
  }
}
