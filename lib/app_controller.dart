import 'dart:convert';
import 'dart:math';

import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:daily_tarot_poc_app_4/models/card_model.dart';
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
    await loadCardList();
  }

  String? name;
  int? age;
  DateTime? date;
  TimeOfDay? time;
  bool? isMale;

  late final List<CardModel> soulCardList;
  late final List<CardModel> fruitCardList;
  late final List<CardModel> loveCardList;

  int moon = 0;
  final String moonKey = "sdfdsf";

  late final SharedPreferences prefs;

  String cardFormat(CardModel card, {bool ver2 = false}) => ver2 ? "${card.number}. ${card.name}" : "${card.number}번 ${card.name}";

  CardModel getSoulCard() {
    final sum = date!.year + date!.month + date!.day;

    final total = (sum - 1) % 9 + 1;

    return soulCardList.where((e) => e.number == total).first;
  }

  CardModel getRandomCard(List<CardModel> list) =>
      list.where((e) => e.number == Random().nextInt(8) + 1).first;

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

    final List data1 = jsonDecode(res1);
    final List data2 = jsonDecode(res2);
    final List data3 = jsonDecode(res3);

    soulCardList = data1.map((e) => CardModel.fronJson(e)).toList();
    fruitCardList = data2.map((e) => CardModel.fronJson(e)).toList();
    loveCardList = data3.map((e) => CardModel.fronJson(e)).toList();
  }

  void moveUrl(String url) => launchUrl(Uri.parse(url));

  void loadMoon() {
    moon = prefs.getInt(moonKey) ?? 0;
  }

  void addMoon(int add) {
    moon += add;
    prefs.setInt(moonKey, moon);
  }

  int getYear() => DateTime.now().year - DateTime(1900).year;

  int getDay(DateTime date) =>
      isNowMonth(date) ? DateTime.now().day - 1 : lastDate(date);

  DateTime getInitialDate() => DateTime(1901, 1, 1);

  int getMonth(DateTime date) =>
      isNowYear(date.year) ? DateTime.now().month : 12;

  String dateFormat(String format, DateTime date) =>
      DateFormat(format).format(date);

  String numberFormat(String format, int num) =>
      NumberFormat(format).format(num);

  String timeFormat(String format, TimeOfDay time) =>
      DateFormat(format).format(DateTime(0, 0, 0, time.hour, time.minute));

  int startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  bool isNowYear(int year) => DateTime.now().year - year == 0;

  bool isNowMonth(DateTime date) => DateUtils.isSameMonth(DateTime.now(), date);

  void showSnack(BuildContext context, String m) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 600),
          backgroundColor: purpleAccent,
          content: Text(
            m,
            style: TextStyle(
              color: Colors.white,
              fontWeight: .bold,
              fontFamily: f2,
            ),
          ),
        ),
      );

  Future<void> move(BuildContext context, Widget page) async => Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
        position: Tween<Offset>(
          begin: .new(0, 0.4),
          end: .new(0, 0),
        ).animate(animation),
        child: page,
      ),
    ),
  );

  Future<void> moveReset(BuildContext context, Widget page) async =>
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: .new(0, 0.4),
                  end: .new(0, 0),
                ).animate(animation),
                child: page,
              ),
        ),
        (route) => false,
      );

  Future<void> back(BuildContext context, Widget page) async => Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
        position: Tween<Offset>(
          begin: .new(0, -0.4),
          end: .new(0, 0),
        ).animate(animation),
        child: page,
      ),
    ),
  );
}
