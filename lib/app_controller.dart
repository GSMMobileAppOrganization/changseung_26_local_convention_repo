import 'dart:convert';

import 'package:daily_tarot_poc_app_10/main.dart';
import 'package:daily_tarot_poc_app_10/models/card_model.dart';
import 'package:daily_tarot_poc_app_10/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final appController = AppController();

class AppController {
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    moon = prefs.getInt(moonKey) ?? 0;

    soulCardList =
        (jsonDecode(
                  await rootBundle.loadString(
                    "assets/data/soul_cards_data.json",
                  ),
                )
                as List)
            .map((e) => CardModel.fromJson(e))
            .toList();
  }

  String? name;
  int? age;
  bool? isMale;
  DateTime? date;
  TimeOfDay? time;

  int moon = 0;
  String moonKey = "sdfsdfsd";

  late final SharedPreferences prefs;
  late final List<CardModel> soulCardList;

  String cardFormat(CardModel card) => "${card.number}번 ${card.name}";

  String cardPath(CardModel card) => "assets/images/tarot_cards/${card.image}";

  CardModel getSoulCard() {
    final sum = date!.year + date!.month + date!.day;

    return soulCardList
        .where((element) => element.number == (sum - 1) % 9 + 1)
        .first;
  }

  void addMoon(int add) {
    moon += add;
    prefs.setInt(moonKey, moon);
  }

  void goUrl(String uri) => launchUrl(Uri.parse(uri));

  int getYear(int year) => DateTime.now().year - year;

  int getMonth(int year, int max) =>
      isNowYear(year) ? DateTime.now().month : max;

  bool isNowYear(int year) => DateTime.now().year - year <= 0;

  bool isNowDay(DateTime date) =>
      date.isAfter(DateTime.now().add(Duration(days: -1)));

  String dateFormat(String f, DateTime date) => DateFormat(f).format(date);

  String timeFormat(String f, TimeOfDay time) =>
      DateFormat(f).format(DateTime(0, 0, 0, time.hour, time.minute));

  String numberFormat(String f, int num) => NumberFormat(f).format(num);

  int startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  void showSnack(BuildContext context, String m) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: titleW(m, font: f2),
          backgroundColor: purple,
          duration: Duration(milliseconds: 800),
        ),
      );

  Future<void> go(BuildContext context, Widget page) => Navigator.push(
    context,
    PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          RotationTransition(
            turns: Tween(begin: .02, end: 0.0).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: .new(.5, 0),
                end: .zero,
              ).animate(animation),
              child: child,
            ),
          ),
      pageBuilder: (context, animation, secondaryAnimation) => page,
    ),
  );

  Future<void> goCustom(
    BuildContext context,
    Widget page, {
    required Duration dur,
  }) => Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: dur,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (context, animation, secondaryAnimation) => page,
    ),
  );

  Future<void> goReset(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: .new(0, .2),
                    end: .zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
          pageBuilder: (context, animation, secondaryAnimation) => page,
        ),
        (route) => false,
      );

  Future<void> back(BuildContext context, Widget page) =>
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              RotationTransition(
                turns: Tween(begin: -.02, end: .0).animate(animation),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: .new(-.5, 0),
                    end: .zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
          pageBuilder: (context, animation, secondaryAnimation) => page,
        ),
      );
}
