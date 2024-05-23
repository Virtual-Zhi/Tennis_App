// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


AppBar header(textColor, text)
{
   return AppBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(90))),
    toolbarHeight: 80,
    elevation: 10,
    title: Text(
      text,
       style: GoogleFonts.lilitaOne(
        color: textColor,
        fontSize: 50,
        fontWeight: FontWeight.w900,
        ),
    ),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 2.25,
          colors: [
            Color(0xffFCEE21),
            Color.fromRGBO(142, 255, 77, 0.737),
            Color(0xff009245),
          ],
        ),
      ),
    ),
  );
}