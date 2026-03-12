import 'package:daily_tarot_poc_app_5/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final appController = AppController();

class AppController {
  Future<void> init() async {}

  int? age;
  String? name;
  DateTime? date;
  TimeOfDay? time;
  bool? isMale;

  String dateFormat(String f, DateTime date) => DateFormat(f).format(date);

  String timeFormat(String f, TimeOfDay time) =>
      DateFormat(f).format(DateTime(0, 0, 0, time.hour, time.minute));

  String numberFormat(String f, int n) => NumberFormat(f).format(n);

  DateTime getInitialDate() => DateTime(1901, 1, 1);

  int getYear() => DateTime.now().year - DateTime(1900).year;

  int getMonth(DateTime date) =>
      isNowYear(date.year) ? DateTime.now().month : 12;

  bool isNowYear(int year) => DateTime.now().year - year == 0;

  bool isNowMonth(DateTime date) => DateUtils.isSameMonth(DateTime.now(), date);

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
