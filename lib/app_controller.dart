import 'dart:convert';
import 'dart:math';

import 'package:daily_tarot_poc_app_15/card_model.dart';
import 'package:daily_tarot_poc_app_15/main.dart';
import 'package:daily_tarot_poc_app_15/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  DateTime? date;
  TimeOfDay? time;

  int moon = 0;
  final String moonKey = "sdfsf";
  late final SharedPreferences prefs;

  late final List<CardModel> soulCardList;
  late final List<CardModel> fruitCardList;
  late final List<CardModel> loveCardList;

  MethodChannel channel = MethodChannel("mc");

  void sendResult(String text) {
    channel.invokeMethod("send", {"text": text});
  }

  void addMoon(int add) {
    moon += add;
    prefs.setInt(moonKey, moon);
  }

  void showSnack(BuildContext context, String m) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: titleW(m, isF2: true, size: 15),
          backgroundColor: purple,
          duration: Duration(milliseconds: 600),
        ),
      );

  void showAlert(
    BuildContext context,
    String title,
    String select,
    VoidCallback action,
  ) => showDialog(
    context: context,
    builder: (context) => Dialog(
      constraints: .tightFor(height: 260),
      backgroundColor: purple,
      child: Container(
        clipBehavior: .hardEdge,
        decoration: BoxDecoration(
          borderRadius: .circular(18),
          gradient: LinearGradient(
            colors: [purple, deepPurple],
            begin: .topLeft,
            end: .bottomRight,
          ),
        ),
        padding: .symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                margin: .symmetric(vertical: 12),
                padding: .symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: .symmetric(
                    horizontal: BorderSide(color: Colors.white30, width: 1.2),
                  ),
                ),
                alignment: .center,
                child: titleW(title, isF2: true, align: .center, size: 22),
              ),
            ),

            Row(
              mainAxisAlignment: .center,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: button2("취소", () {
                      Navigator.pop(context);
                    }, hasIcon: false),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: button2(select, () {
                      Navigator.pop(context);
                      action.call();
                    }, isBack: false),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  String cardPath(CardModel card) => "assets/images/tarot_cards/${card.image}";

  String cardFormat(CardModel card, {bool ver2 = false}) =>
      ver2 ? "${card.number}. ${card.name}" : "${card.number}번 ${card.name}";

  CardModel getSoulCard() {
    final sum = date!.year + date!.month + date!.day;

    return soulCardList
        .where((element) => element.number == (sum - 1) % 9 + 1)
        .first;
  }

  CardModel getToDayCard() {
    final n =
        Random(
          int.parse(appController.dateFormat("yyyyMMdd", DateTime.now())),
        ).nextInt(9) +
        1;

    return soulCardList.where((e) => n == e.number).first;
  }

  CardModel getRandomCard(List<CardModel> list) {
    final n = Random().nextInt(9) + 1;

    return list.where((e) => n == e.number).first;
  }

  bool isOverNow(DateTime date) =>
      date.isAfter(DateTime.now().add(Duration(days: -1)));

  String dateFormat(String f, DateTime date) => DateFormat(f).format(date);

  String timeFormat(String f, TimeOfDay time) =>
      DateFormat(f).format(DateTime(0, 0, 0, time.hour, time.minute));

  String numberFormat(String f, int n) => NumberFormat(f).format(n);

  int startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  Future<void> go(BuildContext context, Widget page) => Navigator.push(
    context,
    PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          RotationTransition(
            turns: Tween(begin: .02, end: 0.0).animate(animation),
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

  Future<void> goFade(
    BuildContext context,
    Widget page, {
    Duration dur = const Duration(milliseconds: 300),
  }) => Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: dur,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (context, animation, secondaryAnimation) => page,
    ),
  );

  Future<void> back(BuildContext context, Widget page) =>
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              RotationTransition(
                turns: Tween(begin: -.02, end: 0.0).animate(animation),
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
