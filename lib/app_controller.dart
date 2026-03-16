import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appController = AppController();

class AppController {
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? name;
  int? age;
  DateTime? date;
  TimeOfDay? time;
  bool? isMale;

  int moon = 0;
  final String moonKey = "sdfdsf";

  late final SharedPreferences prefs;

  void loadMoon() => moon = prefs.getInt(moonKey) ?? 0;

  void addMoon(int add) {
    moon += add;
    prefs.setInt(moonKey, moon);
  }

  void subtractMoon(int sub) {
    moon -= sub;
    prefs.setInt(moonKey, moon);
  }

  String dateFormat(String f, DateTime date) => DateFormat(f).format(date);

  String timeFormat(String f, TimeOfDay time) =>
      DateFormat(f).format(DateTime(0, 0, 0, time.hour, time.minute));

  String numberFormat(String f, int num) => NumberFormat(f).format(num);

  int getYear(int year) => DateTime.now().year - year;

  int getMonth(DateTime date) =>
      isNowYear(date.year) ? DateTime.now().month : 12;

  bool isNowYear(int year) => DateTime.now().year - year == 0;

  bool isNowMonth(DateTime date) => DateUtils.isSameMonth(DateTime.now(), date);

  bool isNowDay(DateTime date) =>
      date.isAfter(DateTime.now().add(Duration(days: -1)));

  int startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

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
  );

  Future<void> goRest(BuildContext context, Widget page) =>
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

  Future<void> back(BuildContext context, Widget page) =>
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: .new(0, -.2),
                  end: .zero,
                ).animate(animation),
                child: child,
              ),
        ),
      );
}
