import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/onboarding_screen.dart';
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

const Color purple = Color(0xff2F0F4E);
const Color purpleAccent = Color(0xff3C1463);
const Color yellow = Color(0xffFFDD00);
const Color gradY = Color(0xff86697B);

const String f1 = "f1";
const String f2 = "f2";
