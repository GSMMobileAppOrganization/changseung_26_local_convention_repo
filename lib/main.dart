import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/b/home_screen.dart';
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

const Color deepPurple = Color(0xff270C42);
const Color purple = Color(0xff3C1362);
const Color grad = Color(0xff7D5E78);

const String f1 = "f1";
const String f2 = "f2";
