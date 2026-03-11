import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/screens/a/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await appController.init();

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: f1),
      home: OnboardingScreen(),
    ),
  );
}

const Color purple = Color(0xff270C42);
const Color purpleAccent = Color(0xff3C1463);
const Color gradY = Color(0xff7D5E78);

const String f1 = "f1";
const String f2 = "f2";
