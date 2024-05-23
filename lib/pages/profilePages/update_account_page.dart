import 'package:app_apk/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                LineAwesomeIcons.angle_left,
                color: Colors.black,
              )),
          title: Text("Edit Profile",
              style: Theme.of(context).textTheme.headline6),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image:
                                AssetImage("./assets/images/googleSign.png")),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(1),
                        ),
                        child: const Icon(LineAwesomeIcons.alternate_pencil,
                            size: 20, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Form(
                    child: Column(
                  children: [
                    SizedBox(
                      child: TextFormField(
                          decoration: InputDecoration(
                              label: Text("Full Name"),
                              prefixIcon: Icon(Icons.person_outline_rounded),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black)))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            label: Text("Email"),
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.black)))),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            label: Text("Phone Number"),
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.black)))),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            label: Text("Password"),
                            prefixIcon: Icon(Icons.fingerprint),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.black)))),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text("Confirm Edits",
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder()))),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
