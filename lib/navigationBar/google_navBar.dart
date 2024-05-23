// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'package:app_apk/controllers/nav_bar_pageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class google_navBar extends StatefulWidget {
  const google_navBar({super.key});

  @override
  State<google_navBar> createState() => _google_navBarState();
}

class _google_navBarState extends State<google_navBar> {
  @override
  Widget build(BuildContext context) {
    nav_bar_pageController controller = Get.put(nav_bar_pageController());
    controller.index.value = 0;
    PageController _pageController = PageController(initialPage: 0);
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            controller.index.value = newIndex;
          });
        },
        children: controller.pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 227, 237, 241),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.25)),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          child: GNav(
              gap: 7,
              color: Colors.black,
              activeColor: Colors.black,
              rippleColor: Colors.lightBlue.shade200,
              tabBackgroundColor: Colors.lightBlue.shade100,
              tabBorder: Border.all(color: Colors.transparent),
              tabBorderRadius: 10,
              tabShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8)
              ],
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
              onTabChange: (value) {
                _pageController.animateToPage(value,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(icon: Icons.folder, text: "Team"),
                GButton(icon: Icons.account_circle, text: "Account"),
              ]),
        ),
      ),
    );
  }
}
