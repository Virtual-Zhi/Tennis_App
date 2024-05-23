// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'package:app_apk/pages/profilePages/SettingsPage.dart';
import 'package:app_apk/services/dataStoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../controllers/nav_bar_pageController.dart';
import '../../objects/widgets/header.dart';
import 'update_account_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  nav_bar_pageController controller = Get.put(nav_bar_pageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(Colors.white, "Profile"),
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
                const SizedBox(height: 10),
                Text("ProfileName",
                    style: Theme.of(context).textTheme.headline4),
                Text("someEmail@gmail.com",
                    style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: 20),
                SizedBox(
                    width: 200,
                    height: 30,
                    child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const UpdateProfileScreen()),
                        child: const Text("Edit Profile",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            side: BorderSide.none,
                            shape: ContinuousRectangleBorder()))),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),
                optionsWidget(
                  title: "Settings",
                  icon: LineAwesomeIcons.cog,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => settingsPage()));
                  },
                ),
                //optionsWidget(title: "Blank", icon: LineAwesomeIcons.accessible_icon, onPress: (){},),
                optionsWidget(
                  title: "User Management",
                  icon: LineAwesomeIcons.user_check,
                  onPress: () {},
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                optionsWidget(
                  title: "Information",
                  icon: LineAwesomeIcons.info,
                  onPress: () {},
                ),
                optionsWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.cog,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    _signOut();
                  },
                ),
                optionsWidget(
                  title: "Delete Acount",
                  icon: LineAwesomeIcons.trash,
                  textColor: Colors.red,
                  onPress: () {
                    _deleteAccount();
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _deleteAccount() async {
    final User user = FirebaseAuth.instance.currentUser!;
    user
        .delete()
        .then((value) => {
              print("User Deleted"),
              clearCollection(user.uid + "playerNotes"),
              _signOut(),
            })
        .catchError((onError) => {});
  }

  Future<void> clearCollection(String path) async {
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection(path);
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}

class optionsWidget extends StatelessWidget {
  const optionsWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blueAccent.withOpacity(0.1),
          ),
          child: Icon(icon, color: Colors.blueAccent)),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(LineAwesomeIcons.angle_right,
                  size: 18, color: Colors.grey),
            )
          : null,
    );
  }
}
