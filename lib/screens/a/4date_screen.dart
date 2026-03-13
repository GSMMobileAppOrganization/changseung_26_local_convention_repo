import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '3gender_screen.dart';
import '5time_screen.dart';

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
          SizedBox(height: 24),

          dateView(),

          SizedBox(height: 12),

          Padding(
            padding: .symmetric(horizontal: 32),
            child: GridView.builder(
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
                        "현재 이후의 날짜는 선택할 수 없습니다.",
                      );
                      return;
                    }
                    appController.date = date;
                    appController.move(context, TimeScreen());
                  },
                  child: Center(
                    child: Text(
                      "${cur.day}",
                      style: TextStyle(
                        color: DateUtils.isSameMonth(cur, date)
                            ? Colors.white
                            : Colors.white.withAlpha(100),
                        fontSize: 16,
                        fontWeight: .bold,
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


      date = DateTime(1900, 1);

      setState(() {});

      showDialog(context: context, builder: (context) => datePicker());
    },
    child: titleW(appController.dateFormat("y.M", date)),
  );

  Widget datePicker() => Dialog(
    child: SizedBox(
      height: 300,
      child: background(
        Padding(
          padding: .symmetric(vertical: 18),
          child: StatefulBuilder(
            builder: (context, set) => Row(
              children: [
                Expanded(
                  child: wheelList(
                    List.generate(
                      appController.getYear(DateTime(1900)),
                      (index) => index + 1900,
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
