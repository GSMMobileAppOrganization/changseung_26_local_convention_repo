import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/b/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await appController.init();

  appController.loadMoon();

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: f1),
      home: HomeScreen(),
    ),
  );
}

const String f1 = "f1";
const String f2 = "f2";
const Color purple = Color(0xff3B1362);
const Color deepPurple = Color(0xff270D42);
const Color purpleAccent = Color(0xff3C1463);
const Color grad = Color(0xff85677B);
const Color yellow = Color(0xffFCDA00);
