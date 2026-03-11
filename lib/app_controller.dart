import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final appController = AppController();

class AppController {
  Future<void> init() async {}

  String? name;
  int? age;
  DateTime? date;
  TimeOfDay? time;
  bool? isMale;

  int getYear() => DateTime.now().year - DateTime(1900).year;

  DateTime getInitialDate() => DateTime(1901, 1, 1);

  int getMonth(DateTime date) => isNowYear(date.year) ? DateTime.now().month : 12;

  String dateFormat(String format, DateTime date) =>
      DateFormat(format).format(date);

  String numberFormat(String format, int num) =>
      NumberFormat(format).format(num);

  String timeFormat(String format, TimeOfDay time) =>
      DateFormat(format).format(DateTime(0, 0, 0, time.hour, time.minute));

  int startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  bool isNowYear(int year) => DateTime.now().year - year == 0;

  bool isNowMonth(DateTime date) => DateUtils.isSameMonth(DateTime.now(), date);

  void showSnack(BuildContext context, String m) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: purpleAccent,
          content: Text(
            m,
            style: TextStyle(
              color: Colors.white,
              fontWeight: .bold,
              fontFamily: f2,
            ),
          ),
        ),
      );

  Future<void> move(BuildContext context, Widget page) async => Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
        position: Tween<Offset>(
          begin: .new(0, 0.4),
          end: .new(0, 0),
        ).animate(animation),
        child: page,
      ),
    ),
  );

  Future<void> moveReset(BuildContext context, Widget page) async =>
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: .new(0, 0.4),
                  end: .new(0, 0),
                ).animate(animation),
                child: page,
              ),
        ),
        (route) => false,
      );

  Future<void> back(BuildContext context, Widget page) async => Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
        position: Tween<Offset>(
          begin: .new(0, -0.4),
          end: .new(0, 0),
        ).animate(animation),
        child: page,
      ),
    ),
  );
}
