import 'dart:convert';
import 'dart:math';

import 'package:daily_tarot_poc_app_11/card_model.dart';
import 'package:daily_tarot_poc_app_11/main.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final appController = AppController();

class AppController {
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    name = prefs.getString(nameKey);
    age = prefs.getInt(ageKey);
    isMale = prefs.getBool(isMaleKey);
    isAm = prefs.getBool(isAmKey) ?? false;
    date = DateTime.tryParse(prefs.getString(dateKey) ?? "");
    time = TimeOfDay.fromDateTime(
      DateTime.tryParse(prefs.getString(timeKey) ?? "") ??
          DateTime(0, 0, 0, 9, 0),
    );

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
  }

  String? name;
  int? age;
  bool? isMale;
  bool isAm = false;
  DateTime? date;
  TimeOfDay? time;
  int fixCount = 0;

  int moon = 0;

  final String nameKey = "dssd";
  final String ageKey = "sdfadf";
  final String isMaleKey = "sdfsd";
  final String isAmKey = "sdfsdsadasdfdas";
  final String dateKey = "sdffsdfewsrfws";
  final String timeKey = "dsakajsndfka";
  final String moonKey = "dsakajsndfkaasa";

  late final SharedPreferences prefs;
  late final List<CardModel> soulCardList;
  late final List<CardModel> fruitCardList;
  late final List<CardModel> loveCardList;

  String cardFormat(CardModel card, {bool ver2 = false}) =>
      ver2 ? "${card.number}. ${card.name}" : "${card.number}번 ${card.name}";

  String cardPath(CardModel card) => "assets/images/tarot_cards/${card.image}";

  CardModel getSoulCard() {
    final sum = date!.year + date!.month + date!.day;
    return soulCardList
        .where((element) => element.number == (sum - 1) % 9 + 1)
        .first;
  }

  CardModel getRandomCard(List<CardModel> list) {
    final n = Random().nextInt(9) + 1;
    return list.where((element) => element.number == n).first;
  }

  void goUrl(String uri) => launchUrl(Uri.parse(uri));

  void showSnack(BuildContext context, String m) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 600),
          backgroundColor: accentPurple,
          content: title14W(m, font: f2),
        ),
      );

  void addMoon(int add) {
    moon += add;
    prefs.setInt(moonKey, moon);
  }

  String dateFormat(String f, DateTime date) => DateFormat(f).format(date);

  String numberFormat(String f, num n) => NumberFormat(f).format(n);

  String timeFormat(String f, TimeOfDay time) =>
      DateFormat(f).format(DateTime(0, 0, 0, time.hour, time.minute));

  int startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  int getYear(int year) => DateTime.now().year - year;

  bool isNowDay(DateTime date) =>
      date.isAfter(DateTime.now().add(Duration(days: -1)));

  void saveName(String name) {
    this.name = name;
    prefs.setString(nameKey, name);
  }

  void saveIsAm(bool isAm) {
    this.isAm = isAm;
    prefs.setBool(isAmKey, isAm);
  }

  void saveAge(int age) {
    this.age = age;
    prefs.setInt(ageKey, age);
  }

  void saveIsMale(bool isMale) {
    this.isMale = isMale;
    prefs.setBool(isMaleKey, isMale);
  }

  void saveDate(DateTime date) {
    this.date = date;
    prefs.setString(dateKey, date.toIso8601String());
  }

  void saveTime(TimeOfDay? time) {
    this.time = time;

    if (time == null) {
      prefs.remove(timeKey);
      return;
    }
    prefs.setString(
      timeKey,
      DateTime(0, 0, 0, time.hour, time.minute).toIso8601String(),
    );
  }

  Future<void> go(BuildContext context, Widget page) => Navigator.push(
    context,
    PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          RotationTransition(
            turns: Tween(begin: -.98, end: -1.0).animate(animation),
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

  Future<void> goFade(
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
              RotationTransition(
                turns: Tween(begin: .98, end: 1.0).animate(animation),
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
