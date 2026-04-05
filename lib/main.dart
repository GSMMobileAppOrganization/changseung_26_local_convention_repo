import 'package:daily_tarot_poc_app_15/app_controller.dart';
import 'package:daily_tarot_poc_app_15/screens/b/home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await appController.init();

  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(fontFamily: f1),
    ),
  );
}

const String f1 = "f1";
const String f2 = "f2";
const Color purple = Color(0xff3C1363);
const Color deepPurple = Color(0xff270C41);
const Color grad = Color(0xff7B5C77);
const Color yellow = Color(0xffE1BF0B);
