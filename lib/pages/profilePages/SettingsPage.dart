// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_apk/services/dataStoreService.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 70,
        title: Text("Account Settings",
            style: GoogleFonts.exo2(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              AutoSizeText("General", style: TextStyle(color: Colors.blue)),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Icon(Icons.language),
              SizedBox(
                width: 20,
              ),
              AutoSizeText("Language")
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
        ],
      ),
    );
  }

  void _changePassword(String password) async {
    //Create an instance of the current user.
    final User user = FirebaseAuth.instance.currentUser!;
    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
  
}
