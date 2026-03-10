import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await appController.init();
  appController.loadMoonCount();

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: font1, scaffoldBackgroundColor: purple),
      home: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: HomeScreen(),
      ),
    ),
  );
}

const String font1 = "Nanum";
const String font2 = "NanumNotoSansKR";

const Color purple = Color(0xff331054);
const Color purpleAccent = Color(0xff3C1463);
const Color yellow = Color(0xffFFDD00);
const Color gradY = Color(0xff7B5C78);
const Color textGrey = Color(0xff827092);
