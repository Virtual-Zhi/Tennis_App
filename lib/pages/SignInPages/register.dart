// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class registerPage extends StatefulWidget {
  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            "Create an Account",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 60),
          _buildGreyText("Email Address"),
          _buildInputField(emailController),
          const SizedBox(height: 40),
          _buildGreyText("Password"),
          _buildInputField(passController, isPassword: true),
          const SizedBox(height: 40),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  if (emailController.text.isNotEmpty &&
                      passController.text.length >= 8) {
                    register();
                    FirebaseAuth.instance.signOut();
                     Navigator.of(context, rootNavigator: true).pop();
                  } else {
                    debugPrint("Email is empty and password is invalid");
                  }
                },
                child: Text("Create Account")),
          ),
        ],
      )),
    );
  }

  Future<void> register() async {
    final auth = FirebaseAuth.instance;
    //Throw exceptions with invalid emails and passwords
    auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passController.text);
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
      width: 350,
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
}
