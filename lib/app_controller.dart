import 'dart:convert';
import 'dart:math';

import 'package:daily_tarot_poc_app_1/models/card_model.dart';
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
  String? name;
  int? gender;

  int moonCount = 0;
  final String moonKey = "moon";

  late final List<CardModel> soulCardList;
  late final List<CardModel> fruitCardList;
  late final List<CardModel> loveCardList;

  String timeFormat(String format) => DateFormat(
    format,
  ).format(DateTime(0, 0, 0, birthTime?.hour ?? 0, birthTime?.minute ?? 0));

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    await loadCardLists();
  }

  void getMoonCount() {
    moonCount = prefs.getInt(moonKey) ?? 0;
  }

  late final SharedPreferences prefs;

  void addMoon(int add) {
    moonCount += add;
    prefs.setInt(moonKey, moonCount);
  }

  Future<void> loadCardLists() async {
    final res1 = await rootBundle.loadString(
      "assets/data/soul_cards_data.json",
    );
    final res2 = await rootBundle.loadString(
      "assets/data/fruit_tarot_cards_data.json",
    );
    final res3 = await rootBundle.loadString(
      "assets/data/soul_cards_data.json",
    );

    final data1 = jsonDecode(res1);
    final data2 = jsonDecode(res1);
    final data3 = jsonDecode(res1);

    soulCardList = (data1 as List).map((e) => CardModel.fromJson(e)).toList();
    fruitCardList = (data2 as List).map((e) => CardModel.fromJson(e)).toList();
    loveCardList = (data3 as List).map((e) => CardModel.fromJson(e)).toList();
  }

  CardModel getSoulCard() {
    int sum = birthDate!.year + birthDate!.month + birthDate!.day;

    int total = 0;
    while (sum > 0 || total >= 10) {
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

    return soulCardList.where((card) => card.number == total).first;
  }

  void moveUrl(String url) => launchUrl(Uri.parse(url));

  CardModel getRandomCard(List<CardModel> list) {
    final index = Random().nextInt(list.length - 1);
    return list[index];
  }
}
