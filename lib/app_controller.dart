import 'dart:convert';
import 'dart:math';

import 'package:daily_tarot_poc_app_3/card_model.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final appController = AppController();

class AppController {
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    soulCardList =
        (jsonDecode(
                  await rootBundle.loadString(
                    "assets/data/soul_cards_data.json",
                  ),
                )
                as List)
            .map((e) => CardModel.fromJson(e))
            .toList();
    fruitCardList =
        (jsonDecode(
                  await rootBundle.loadString(
                    "assets/data/fruit_tarot_cards_data.json",
                  ),
                )
                as List)
            .map((e) => CardModel.fromJson(e))
            .toList();
    loveCardList =
        (jsonDecode(
                  await rootBundle.loadString(
                    "assets/data/loves_tarot_cards_data.json",
                  ),
                )
                as List)
            .map((e) => CardModel.fromJson(e))
            .toList();

    loadMoon();
  }

  String? name;
  int? age;
  bool? isMale;
  DateTime? date;
  TimeOfDay? time;

  int moon = 0;
  final String moonKey = "sdfsdf";

  late final SharedPreferences prefs;

  late final List<CardModel> soulCardList;
  late final List<CardModel> loveCardList;
  late final List<CardModel> fruitCardList;

  CardModel getRandomCard(List<CardModel> list) {
    final n = Random().nextInt(9) + 1;
    return list.where((e) => e.number == n).first;
  }

  CardModel getSoulCard() {
    final sum = date!.year + date!.month + date!.day;

    return soulCardList
        .where((element) => element.number == (sum - 1) % 9 + 1)
        .first;
  }

  String cardFormat(CardModel card, {bool ver2 = false}) =>
      ver2 ? "${card.number}. ${card.name}" : "${card.number}번 ${card.name}";

  String cardPath(CardModel card) => "assets/images/tarot_cards/${card.image}";

  void goUrl(String uri) => launchUrl(Uri.parse(uri));

  void showSnack(BuildContext context, String m) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: titleW(m, isF2: true),
          backgroundColor: purple,
          duration: Duration(milliseconds: 600),
        ),
      );

  void addMoon(int add) {
    moon += add;
    prefs.setInt(moonKey, moon);
  }

  void loadMoon() => moon = prefs.getInt(moonKey) ?? 0;

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

  String dateFormat(String f, DateTime date) => DateFormat(f).format(date);

  String numberFormat(String f, int n) => NumberFormat(f).format(n);

  String timeFormat(String f, TimeOfDay time) =>
      DateFormat(f).format(DateTime(0, 0, 0, time.hour, time.minute));

  void go(BuildContext context, Widget page) => Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          RotationTransition(
            turns: Tween(begin: .02, end: 0.0).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: .new(.6, 0),
                end: .zero,
              ).animate(animation),
              child: child,
            ),
          ),
    ),
  );

  void goReset(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: .new(0, .2),
                  end: .zero,
                ).animate(animation),
                child: child,
              ),
        ),
        (route) => false,
      );

  void goCustom(BuildContext context, Widget page, {required Duration dur}) =>
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          transitionDuration: dur,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
        (route) => false,
      );

  void back(BuildContext context, Widget page) => Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          RotationTransition(
            alignment: .bottomCenter,
            turns: Tween(begin: -.02, end: 0.0).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: .new(-.6, 0),
                end: .zero,
              ).animate(animation),
              child: child,
            ),
          ),
    ),
  );
}
