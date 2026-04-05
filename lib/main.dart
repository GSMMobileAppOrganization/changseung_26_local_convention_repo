import 'package:daily_tarot_poc_app_14/app_controller.dart';
import 'package:daily_tarot_poc_app_14/screens/b/home_screen.dart';
import 'package:flutter/cupertino.dart';
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
const Color purple = Color(0xff3C1362);
const Color deepPurple = Color(0xff260C41);
const Color grad = Color(0xff886A7C);
const Color yellow = Color(0xffE1BF0A);
