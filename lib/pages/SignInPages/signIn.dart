// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'package:app_apk/pages/SignInPages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Login",
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
                    login();
                  } else {
                    debugPrint("Email is empty and password is invalid");
                  }
                },
                child: Text("Login")),
          ),
          SizedBox(
            width: 300,
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => registerPage()));
              },
              child: Text('Sign up'),
            ),
          ),
          _buildLineBreakWithText("or"),
          SizedBox(
            width: 300,
            height: 50,
            child: SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {
                signInWithGoogle();
              },
            ),
          ),
         
        ],
      )),
    );
  }

  Future<void> login() async {
    final auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
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

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
