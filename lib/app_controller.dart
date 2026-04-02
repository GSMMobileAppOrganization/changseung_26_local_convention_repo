import 'dart:convert';
import 'dart:math';

import 'package:daily_tarot_poc_app_9/main.dart';
import 'package:daily_tarot_poc_app_9/models/card_model.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final appController = AppController();

class AppController {
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    final res1 = await rootBundle.loadString(
      "assets/data/soul_cards_data.json",
    );
    final res2 = await rootBundle.loadString(
      "assets/data/fruit_tarot_cards_data.json",
    );
    final res3 = await rootBundle.loadString(
      "assets/data/loves_tarot_cards_data.json",
    );

    final List data1 = jsonDecode(res1);
    final List data2 = jsonDecode(res2);
    final List data3 = jsonDecode(res3);

    soulCardList = data1.map((e) => CardModel.fromJson(e)).toList();
    fruitCardList = data2.map((e) => CardModel.fromJson(e)).toList();
    loveCardList = data3.map((e) => CardModel.fromJson(e)).toList();
  }

  String? name;
  int? age;
  DateTime? date;
  TimeOfDay? time;
  bool? isMale;

  int moon = 0;
  String key = "dffdggfsd";
  late final SharedPreferences prefs;

  late final List<CardModel> soulCardList;
  late final List<CardModel> fruitCardList;
  late final List<CardModel> loveCardList;

  CardModel getRandomCard(List<CardModel> list) {
    final i = Random().nextInt(9) + 1;
    return list.where((e) => e.number == i).first;
  }

  String cardFormat(CardModel card, {bool ver2 = false}) =>
      ver2 ? "${card.number}. ${card.name}" : "${card.number}번 ${card.name}";

  String cardPath(CardModel card) => "assets/images/tarot_cards/${card.image}";

  CardModel getSoulCard() {
    final sum = date!.year + date!.month + date!.day;

    return soulCardList.where((e) => e.number == (sum - 1) % 9 + 1).first;
  }

  void loadMoon() => moon = prefs.getInt(key) ?? 0;

  void addMoon(int add) {
    moon += add;
    prefs.setInt(key, moon);
  }

  void goUrl(String uri) => launchUrl(Uri.parse(uri));

  String dateFormat(String f, DateTime date) => DateFormat(f).format(date);

  String timeFormat(String f, TimeOfDay time) =>
      DateFormat(f).format(DateTime(0, 0, 0, time.hour, time.minute));

  String numberFormat(String f, int num) => NumberFormat(f).format(num);

  int getYear(int year) => DateTime.now().year - year;

  int startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  bool isNowDay(DateTime date) =>
      date.isAfter(DateTime.now().add(Duration(days: -1)));

  DateTime initialDate() => DateTime.now().add(Duration(days: -1));

  void showSnack(BuildContext context, String m) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 800),
          backgroundColor: purple,
          content: title16W(m, font: f2),
        ),
      );

  Future<void> go(BuildContext context, Widget page) => Navigator.push(
    context,
    PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: Tween<Offset>(
              begin: .new(0, .2),
              end: .zero,
            ).animate(animation),
            child: child,
          ),
      pageBuilder: (context, animation, secondaryAnimation) => page,
    ),
  );

  Future<void> goCustom(
    BuildContext context,
    Widget page, {
    Duration dur = const Duration(milliseconds: 800),
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
              SlideTransition(
                position: Tween<Offset>(
                  begin: .new(0, -.2),
                  end: .zero,
                ).animate(animation),
                child: child,
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
              SlideTransition(
                position: Tween<Offset>(
                  begin: .new(0, -.2),
                  end: .zero,
                ).animate(animation),
                child: child,
              ),
          pageBuilder: (context, animation, secondaryAnimation) => page,
        ),
      );
}
