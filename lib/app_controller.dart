import 'dart:convert';
import 'dart:math';

import 'package:daily_tarot_poc_app_12/main.dart';
import 'package:daily_tarot_poc_app_12/models/card_model.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appController = AppController();

class AppController {
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    name = prefs.getString(nameKey);
    moon = prefs.getInt(moonKey) ?? 0;
    age = prefs.getInt(ageKey);
    isMale = prefs.getBool(isMaleKey);
    date = DateTime.tryParse(prefs.getString(dateKey) ?? "");
    time = TimeOfDay.fromDateTime(
      DateTime.tryParse(prefs.getString(timeKey) ?? "") ??
          DateTime(0, 0, 0, 9, 0),
    );
    isAm = prefs.getBool(isAmKey) ?? false;
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

  final String nameKey = "name";
  final String ageKey = "age";
  final String isMaleKey = "isMale";
  final String dateKey = "date";
  final String timeKey = "time";
  final String isAmKey = "isAm";
  final String moonKey = "moonKey";

  String? name;
  int? age;
  bool? isMale;
  DateTime? date;
  TimeOfDay? time;
  bool isAm = false;
  int fixCount = 0;
  bool changeMoon = false;

  int moon = 0;
  int prevMoon = 0;

  late final SharedPreferences prefs;
  late final List<CardModel> soulCardList;
  late final List<CardModel> fruitCardList;
  late final List<CardModel> loveCardList;

  final List<String> animals = [
    '원숭이',
    '닭',
    '개',
    '돼지',
    '쥐',
    '소',
    '호랑이',
    '토끼',
    '용',
    '뱀',
    '말',
    '양',
  ];

  final MethodChannel channel = MethodChannel("daily_tarot_poc_app_12");

  void share(String text) {
    channel.invokeMethod("share", {"text": text});
  }

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

  void showSnack(BuildContext context, String m) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: titleW(m, isF2: true, size: 15),
          backgroundColor: purple,
          duration: Duration(milliseconds: 600),
        ),
      );

  int getYear(int year) => DateTime.now().year - year;

  bool isNowDay(DateTime date) =>
      date.isAfter(DateTime.now().add(Duration(days: -1)));

  int startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  String dateFormat(String f, DateTime date) => DateFormat(f).format(date);

  String timeFormat(String f, TimeOfDay time) =>
      DateFormat(f).format(DateTime(0, 0, 0, time.hour, time.minute));

  String numberFormat(String f, num n) => NumberFormat(f).format(n);

  T? save<T>(T? value, String key) {
    if (value == null) {
      prefs.remove(key);
      return null;
    }

    switch (T) {
      case int:
        prefs.setInt(key, value as int);
      case String:
        prefs.setString(key, value as String);
      case bool:
        prefs.setBool(key, value as bool);
      case DateTime:
        prefs.setString(key, (value as DateTime).toIso8601String());
    }

    return value;
  }

  void saveName(String m) {
    name = m;
    prefs.setString(nameKey, name!);
  }

  void saveAge(int m) {
    age = m;
    prefs.setInt(ageKey, age!);
  }

  void saveIsMale(bool m) {
    isMale = m;
    prefs.setBool(isMaleKey, isMale!);
  }

  void saveDate(DateTime m) {
    date = m;
    prefs.setString(dateKey, date!.toIso8601String());
  }

  void saveTime(TimeOfDay? m) {
    time = m;
    if (time == null) {
      prefs.remove(timeKey);
      return;
    }
    prefs.setString(
      timeKey,
      DateTime(0, 0, 0, time!.hour, time!.minute).toIso8601String(),
    );
  }

  void saveIsAm(bool m) {
    isAm = m;
    prefs.setBool(isAmKey, isAm);
  }

  Future<void> go(BuildContext context, Widget page) => Navigator.push(
    context,
    PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          RotationTransition(
            turns: Tween(begin: -.98, end: -1.0).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: .new(.4, 0),
                end: .zero,
              ).animate(animation),
              child: child,
            ),
          ),
      pageBuilder: (context, animation, secondaryAnimation) => page,
    ),
  );

  Future<void> goFade(BuildContext context, Widget page, {Duration? dur}) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: dur ?? Duration(milliseconds: 800),
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
                    begin: .new(-.4, 0),
                    end: .zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
          pageBuilder: (context, animation, secondaryAnimation) => page,
        ),
      );
}
