import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/screens/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/time_screen.dart';
import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
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
      prevPage: GenderScreen(),
      progress: 4,
      child: Column(
        children: [
          SizedBox(height: 32),

          dateView(),

          SizedBox(height: 24),

          Padding(
            padding: .symmetric(horizontal: 32),
            child: GridView.builder(
              padding: .zero,
              shrinkWrap: true,
              itemCount: 7 * 5,
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
                    child: titleMW(
                      "${cur.day}",
                      color: DateUtils.isSameMonth(date, cur)
                          ? Colors.white
                          : Colors.white.withAlpha(100),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget dateView() => GestureDetector(
    onTap: () {
      date = DateTime(1901, 1);
      setState(() {});
      showDialog(context: context, builder: (context) => datePicker());
    },
    child: titleW(appController.dateFormat("y.M", date)),
  );

  Widget datePicker() => Dialog(
    child: Container(
      width: 300,
      height: 300,
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(borderRadius: .circular(12)),
      child: background(
        child: Padding(
          padding: .symmetric(vertical: 24),
          child: StatefulBuilder(
            builder: (context, set) => Row(
              children: [
                Expanded(
                  child: wheelList(
                    List.generate(
                      appController.getYear(1900),
                      (index) => index + 1901,
                    ),
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
      ),
    ),
  );
}
