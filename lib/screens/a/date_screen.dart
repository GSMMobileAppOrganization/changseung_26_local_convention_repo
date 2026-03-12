import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/screens/a/age_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/time_screen.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
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
      title: "태어난 날짜를 입력해주세요.",
      progress: 4,
      prevPage: GenderScreen(),
      child: Column(
        children: [
          dateView(),

          Padding(
            padding: .symmetric(horizontal: 32),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemBuilder: (context, index) {
                final curDate = DateTime(
                  date.year,
                  date.month,
                  1 - appController.startDate(date),
                ).add(Duration(days: index));
                return InkWell(
                  onTap: () {
                    if (curDate.isAfter(DateTime.now())) {
                      appController.showSnack(
                        context,
                        "오늘 이후의 날짜는 선택할 수 없습니다.",
                      );
                      return;
                    }
                    appController.date = curDate;
                    appController.move(context, TimeScreen());
                  },
                  child: Center(
                    child: Text(
                      "${curDate.day}",
                    style: TextStyle(
                        color: DateUtils.isSameMonth(date, curDate)
                            ? Colors.white
                            : Colors.white.withAlpha(100),
                        fontWeight: .bold,
                        fontSize: 16,
                      ),
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
      date = appController.getInitialDate();
      setState(() {});
      showDialog(context: context, builder: (context) => datePicker());
    },
    child: Text(
      appController.dateFormat("y.M", date),
      style: TextStyle(color: Colors.white, fontWeight: .bold, fontSize: 24),
    ),
  );

  Widget datePicker() => Dialog(
    child: background(
      height: 300,
      StatefulBuilder(
        builder: (context, set) => Row(
          children: [
            Expanded(
              child: wheelList(
                List.generate(appController.getYear(), (index) => index + 1901),
                (value) {
                  date = DateTime(value, date.month);
                  set(() {});
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: wheelList(
                List.generate(
                  appController.getMonth(date),
                  (index) => index + 1,
                ),
                (value) {
                  date = DateTime(date.year, value);
                  set(() {});
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
