import 'dart:convert';

import 'package:daily_tarot_poc_app_1/models/soul_card_model.dart';
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

  late final List<SoulCardModel> soulCardList;

  String timeFormat(String format) => DateFormat(
    format,
  ).format(DateTime(0, 0, 0, birthTime?.hour ?? 0, birthTime?.minute ?? 0));

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    await loadSoulCardList();
  }

  void getMoonCount() {
    moonCount = prefs.getInt(moonKey) ?? 0;
  }

  late final SharedPreferences prefs;

  void addMoon(int add) {
    moonCount += add;
    prefs.setInt(moonKey, moonCount);
  }

  Future<void> loadSoulCardList() async {
    final res = await rootBundle.loadString("assets/data/soul_cards_data.json");

    final data = jsonDecode(res);

    soulCardList = (data as List)
        .map((e) => SoulCardModel.fromJson(e))
        .toList();
  }

  SoulCardModel getSoulCard() {
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
}
