import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/screens/a/onboarding_screen.dart';
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

const Color deepPurple = Color(0xff270C41);
const Color purple = Color(0xff3B1361);
const Color gradY = Color(0xff816379);

const String f1 = "f1";
const String f2 = "f2";
