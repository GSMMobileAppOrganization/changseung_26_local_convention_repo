import 'dart:math';

import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateScreen extends StatefulWidget {
  const DateScreen({super.key});

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      prevPage: GenderScreen(),
      progress: 4,
      title: "태어난 날짜를 입력해주세요.",
      child: Column(
        children: [
          SizedBox(height: 24),

          dateView(),

          SizedBox(height: 12),

          Padding(
            padding: .symmetric(horizontal: 36),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemBuilder: (context, index) {
                final cur = DateTime(
                  date.year,
                  date.month,
                  1 - appController.startDate(date),
                ).add(Duration(days: index));

                return InkWell(
                  onTap: () {
                    if (appController.isNowDay(cur)) {
                      appController.showSnack(
                        context,
                        "오늘 이후의 날짜는 선택할 수 없습니다.",
                      );
                      return;
                    }
                    appController.date = cur;
                    appController.go(context, TimeScreen());
                  },

                  child: Center(
                    child: title18W(
                      "${cur.day}",
                      color: DateUtils.isSameMonth(date, cur)
                          ? Colors.white
                          : Colors.white54,
                      weight: .bold,
                    ),
                  ),
                );
              },
              itemCount: 7 * 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget dateView() => GestureDetector(
    onTap: () {
      showDialog(context: context, builder: (context) => datePicker());
    },
    child: title24W(appController.dateFormat("y.M", date), weight: .bold),
  );

  Widget datePicker() {
    return Dialog(
      constraints: .tightFor(height: 300),
      child: background(
        child: Padding(
          padding: .symmetric(vertical: 24),
          child: StatefulBuilder(
            builder: (context, set) => Row(
              children: [
                Expanded(
                  child: listWheel(
                    List.generate(
                      appController.getYear(1900),
                      (index) => index + 1901,
                    ),
                    (value) {
                      date = DateTime(value, date.month);
                      set(() {});
                      setState(() {});
                    },
                    date.year - 1901,
                  ),
                ),
                Expanded(
                  child: listWheel(List.generate(12, (index) => index + 1), (
                    value,
                  ) {
                    date = DateTime(date.year, value);
                    set(() {});
                    setState(() {});
                  }, date.month - 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
