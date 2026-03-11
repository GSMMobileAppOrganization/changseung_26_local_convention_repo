import 'dart:convert';
import 'dart:math';

import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:daily_tarot_poc_app_2/models/soul_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final appController = AppController();

class AppController {
  DateTime? birthDate;
  TimeOfDay? birthTime;
  int? age;
  bool? isMale;
  String? name;

  final String moonKey = "moon";
  int moonCount = 0;

  late final List<SoulCardModel> soulCardList;
  late final List<SoulCardModel> fruitCardList;
  late final List<SoulCardModel> loveCardList;

  Future<void> move(BuildContext context, Widget page) async =>
      await Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 0.4),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              ),
          pageBuilder: (context, animation, secondaryAnimation) => page,
        ),
      );

  void moveReplace(BuildContext context, Widget page) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => page),
      );

  void moveRemove(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
        (route) => false,
      );

  String dateFormat(String format, DateTime date) =>
      DateFormat(format).format(date);

  String timeFormat(String format, TimeOfDay time) =>
      DateFormat(format).format(DateTime(0, 0, 0, time.hour, time.minute));

  String numberFormat(String format, int number) =>
      NumberFormat(format).format(number);

  late final SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    await loadCardList();
  }

  void loadMoonCount() => moonCount = prefs.getInt(moonKey) ?? 0;

  void addMoonCount(int add) {
    moonCount += add;
    prefs.setInt(moonKey, moonCount);
  }

  void showSnack(BuildContext context, String content) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 300),
          backgroundColor: purple,
          content: Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontWeight: .bold,
              fontFamily: font1,
            ),
          ),
        ),
      );

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

    final date1 = jsonDecode(res1);
    final date2 = jsonDecode(res2);
    final date3 = jsonDecode(res3);

    soulCardList = (date1 as List)
        .map((e) => SoulCardModel.fromJson(e))
        .toList();
    fruitCardList = (date2 as List)
        .map((e) => SoulCardModel.fromJson(e))
        .toList();
    loveCardList = (date3 as List)
        .map((e) => SoulCardModel.fromJson(e))
        .toList();
  }

  SoulCardModel getSoulCard() {
    int sum = birthDate!.year + birthDate!.month + birthDate!.day;

    int total = 0;
    while (sum > 0 || total < 10) {
      total += sum % 10;
      sum ~/= 10;
      if (sum == 0) {
        if (total < 10) {
          break;
        } else {
          sum = total;
          total = 0;
        }
      }
    }
    return soulCardList.where((card) => card.number == total).first;
  }

  SoulCardModel getRandomCard(List<SoulCardModel> list) {
    final n = Random().nextInt(list.length - 1) + 1;
    print(n);
    return list.where((e) => e.number == n).first;
  }

  void moveUrl(String url) => launchUrl(Uri.parse(url));
}
