import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DateScreen extends StatefulWidget {
  const DateScreen({super.key});

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  DateTime date = appController.date ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "태어난 날짜를 입력해주세요.",
      prevPage: GenderScreen(),
      count: 4,
      child: Column(
        children: [
          SizedBox(height: 24),

          dateView(),

          SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: .zero,
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

                    appController.saveDate(cur);
                    appController.go(context, TimeScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: .all(
                        color: DateUtils.isSameDay(cur, date)
                            ? Colors.white
                            : Colors.transparent,
                        width: 1.6,
                      ),
                      shape: .circle,
                    ),
                    alignment: .center,
                    child: title18W(
                      "${cur.day}",
                      color: DateUtils.isSameMonth(cur, date)
                          ? Colors.white
                          : Colors.white70,
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
    child: title24W(appController.dateFormat("y.M", date)),
  );

  Widget datePicker() => Dialog(
    child: Container(
      height: 300,
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(borderRadius: .circular(16)),
      child: StatefulBuilder(
        builder: (context, set) => background(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: listWheel(
                    List.generate(
                      appController.getYear(1900),
                      (index) => index + 1901,
                    ),
                    (value) {
                      date = DateTime(value, date.month);
                      setState(() {});
                      set(() {});
                    },
                    date.year - 1901,
                  ),
                ),
                Expanded(
                  child: listWheel(List.generate(12, (index) => index + 1), (
                    value,
                  ) {
                    date = DateTime(date.year, value);
                    setState(() {});
                    set(() {});
                  }, date.month - 1),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
