import 'dart:convert';
import 'dart:math';

import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final appController = AppController();

class AppController {
  String? name;
  int? age;
  bool? isMale;
  DateTime? birthDate;
  TimeOfDay? birthTime;

  int moon = 0;
  late final SharedPreferences prefs;

  late final List<CardModel> soulCardList;
  late final List<CardModel> fruitCardList;
  late final List<CardModel> loveCardList;

  final String moonKey = "sd";

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    await loadCardList();
  }

  String cardFormat(CardModel card) => "${card.number}. ${card.name}";

  CardModel getRandomCard(List<CardModel> list) {
    final n = Random().nextInt(9) + 1;
    return list.where((e) => e.number == n).first;
  }

  CardModel getSoulCard() {
    int sum = birthDate!.year + birthDate!.month + birthDate!.day;

    int total = 0;
    while (sum > 0 || total > 10) {
      total += sum % 10;
      sum ~/= 10;
      if (sum <= 0) {
        if (total < 10) {
          break;
        } else {
          sum = total;
          total = 0;
        }
      }
    }

    return soulCardList.where((e) => e.number == total).first;
  }

  Future<void> loadCardList() async {
    final res1 = await rootBundle.loadString(
      "assets/data/soul_cards_data.json",
    );
    final res2 = await rootBundle.loadString(
      "assets/data/fruit_tarot_cards_data.json",
    );
    final res3 = await rootBundle.loadString(
      "assets/data/loves_tarot_cards_data.json",
    );

    final List date1 = jsonDecode(res1);
    final List date2 = jsonDecode(res2);
    final List date3 = jsonDecode(res3);

    soulCardList = date1.map((e) => CardModel.fromJson(e)).toList();
    fruitCardList = date2.map((e) => CardModel.fromJson(e)).toList();
    loveCardList = date3.map((e) => CardModel.fromJson(e)).toList();
  }

  void moveUrl(String url) => launchUrl(Uri.parse(url));

  void loadMoon() {
    moon = prefs.getInt(moonKey) ?? 0;
  }

  void addMoon(int add) {
    moon += add;
    prefs.setInt(moonKey, moon);
  }

  bool isNowYear(int year) => DateTime.now().year - year <= 0;

  bool isNowMonth(DateTime date) => DateUtils.isSameMonth(DateTime.now(), date);

  int startDate(DateTime date) => (DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  ));

  int lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  String dateFormat(String format, DateTime date) =>
      DateFormat(format).format(date);

  String numberFormat(String format, int num) =>
      NumberFormat(format).format(num);

  String timeFormat(String format, TimeOfDay time) =>
      DateFormat(format).format(DateTime(0, 0, 0, time.hour, time.minute));

  void showSnack(BuildContext context, String m) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 600),
          backgroundColor: purpleAccent,
          content: Text(
            m,
            style: TextStyle(
              color: Colors.white,
              fontFamily: f2,
              fontWeight: .bold,
            ),
          ),
        ),
      );

  Future<void> move(BuildContext context, Widget page) => Navigator.push(
    context,
    PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, .2),
              end: Offset(0, 0),
            ).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          ),
      pageBuilder: (context, animation, secondaryAnimation) => page,
    ),
  );

  Future<void> moveReplace(BuildContext context, Widget page) =>
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, -.2),
                  end: Offset(0, 0),
                ).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              ),
          pageBuilder: (context, animation, secondaryAnimation) => page,
        ),
      );

  Future<void> moveRemove(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, -.2),
                  end: Offset(0, 0),
                ).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              ),
          pageBuilder: (context, animation, secondaryAnimation) => page,
        ),
        (route) => false,
      );
}
