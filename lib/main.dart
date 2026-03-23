import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/b/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await appController.init();

  appController.loadMoon();

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: f1),
      home: OnboardingScreen(),
    ),
  );
}

const Color deepPurple = Color(0xff270C42);
const Color purple = Color(0xff3A1260);
const Color purpleAccent = Color(0xff3C1463);
const Color grad = Color(0xff83657A);
const Color yellow = Color(0xffF8D602);

const String f1 = "f1";
const String f2 = "f2";
