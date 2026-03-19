import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/input_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/time_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
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
      progress: 4,
      child: Column(
        children: [
          SizedBox(height: 28),

          dateView(),

          SizedBox(height: 12),

          Padding(
            padding: .symmetric(horizontal: 36),
            child: GridView.builder(
              shrinkWrap: true,
              padding: .zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemBuilder: (context, index) {
                final cur = DateTime(
                  date.year,
                  date.month,
                  1 - appController.startDate(date),
                ).add(Duration(days: index));
                return GestureDetector(
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
                          : Colors.white.withAlpha(100),
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

  Widget datePicker() {
    return Dialog(
      child: SizedBox(
        height: 300,
        child: background(
          child: StatefulBuilder(
            builder: (context, set) => Row(
              children: [
                Expanded(
                  child: wheelList(
                    List.generate(
                      appController.getYear(1900),
                      (index) => index + 1 + 1900,
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
                  child: wheelList(List.generate(12, (index) => index + 1), (
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
