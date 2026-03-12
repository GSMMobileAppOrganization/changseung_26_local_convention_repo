import 'dart:convert';
import 'dart:math';

import 'package:daily_tarot_poc_app_5/main.dart';
import 'package:daily_tarot_poc_app_5/models/card_model.dart';
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

  int? age;
  String? name;
  DateTime? date;
  TimeOfDay? time;
  bool? isMale;

  int moon = 0;
  final String moonKey = "sdfsdfds";
  late final SharedPreferences prefs;

  late final List<CardModel> soulCardList;
  late final List<CardModel> fruitCardList;
  late final List<CardModel> loveCardList;

  String cardFormat(CardModel card, {bool ver2 = false}) => ver2 ? "${card.number}. ${card.name}" :  "${card.number}번 ${card.name}";

  String cardPath(CardModel card) => "assets/images/tarot_cards/${card.image}";

  CardModel getSoulCard() {
    final sum = date!.year + date!.month + date!.day;

    final total = (sum - 1) % 9 + 1;

    return soulCardList.where((e) => e.number == total).first;
  }

  CardModel getRandomCard(List<CardModel> list) {
    final num = Random().nextInt(9) + 1;

    return soulCardList.where((e) => e.number == num).first;
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
    fruitCardList = date3.map((e) => CardModel.fromJson(e)).toList();
    loveCardList = date2.map((e) => CardModel.fromJson(e)).toList();
  }

  void loadMoon() => moon = prefs.getInt(moonKey) ?? 0;

  void addMoon(int add) {
    moon += add;
    prefs.setInt(moonKey, moon);
  }

  String dateFormat(String f, DateTime date) => DateFormat(f).format(date);

  String timeFormat(String f, TimeOfDay time) =>
      DateFormat(f).format(DateTime(0, 0, 0, time.hour, time.minute));

  String numberFormat(String f, int n) => NumberFormat(f).format(n);

  DateTime getInitialDate() => DateTime(1901, 1, 1);

  int getYear() => DateTime.now().year - DateTime(1900).year;

  int getMonth(DateTime date) =>
      isNowYear(date.year) ? DateTime.now().month : 12;

  int getDay(DateTime date) =>
      isNowMonth(date) ? DateTime.now().day - 1 : lastDate(date);

  bool isNowYear(int year) => DateTime.now().year - year == 0;

  bool isNowMonth(DateTime date) => DateUtils.isSameMonth(DateTime.now(), date);

  int startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  void moveUrl(String uri) => launchUrl(Uri.parse(uri));

  void showSnack(BuildContext context, String m) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 600),
          backgroundColor: purple,
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
              begin: .new(0, .4),
              end: .zero,
            ).animate(animation),
            child: child,
          ),
      pageBuilder: (context, animation, secondaryAnimation) => page,
    ),
  );

  Future<void> noAnimationMove(
    BuildContext context,
    Widget page, {
    Duration dur = const Duration(milliseconds: 300),
  }) => Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: dur,
      pageBuilder: (context, animation, secondaryAnimation) => page,
    ),
  );

  Future<void> moveReset(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: .new(0, .4),
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
                  begin: .new(0, -.4),
                  end: .zero,
                ).animate(animation),
                child: child,
              ),
          pageBuilder: (context, animation, secondaryAnimation) => page,
        ),
      );
}
