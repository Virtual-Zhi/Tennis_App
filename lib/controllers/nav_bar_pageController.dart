import 'package:app_apk/pages/HomePage.dart';
import 'package:app_apk/pages/TeamsPage.dart';
import 'package:get/get.dart';

import '../pages/profilePages/AccountPage.dart';


class nav_bar_pageController extends GetxController 
{
  RxInt index = 0.obs;

  var pages = [
    HomePage(),
    TeamsPage(),
    AccountPage(),
  ];
}