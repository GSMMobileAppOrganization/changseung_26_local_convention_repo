import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/a/splash_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/b/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  appController.init();

  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(fontFamily: f1),
    ),
  );
}

const String f1 = "f1";
const String f2 = "f2";
const Color purple = Color(0xff3C1362);
const Color deepPurple = Color(0xff270C42);
const Color accentPurple = Color(0xff3C1463);
const Color grad = Color(0xff816379);
const Color yellow = Color(0xffFFDD00);
