import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/screens/home_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await appController.init();
  appController.getMoonCount();

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: font1),
      home: HomeScreen(),
    ),
  );
}

const String font1 = "NanumFontSetup_TTF_MYUNGJO";
const String font2 = "NotoSansKR";

const Color purple = Color(0xff320F51);
const Color purpleAccent = Color(0xff3C1463);
const Color textGrey = Color(0xff736186);
const Color gradY = Color(0xff83657A);
const Color yellow = Color(0xffE2BF0B);
