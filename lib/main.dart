import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/b/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await appController.init();
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: f1),
      home: HomeScreen(),
    ),
  );
}

const String f2 = "f2";
const String f1 = "f1";
const Color purple = Color(0xff3C1362);
const Color deepPurple = Color(0xff270C42);
const Color accentPurple = Color(0xff3C1463);
const Color grad = Color(0xff7B5E75);
const Color yellow = Color(0xffF8D602);
