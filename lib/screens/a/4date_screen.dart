import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
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
    return BaseScreen(
      title: "태어난 날짜를 입력해주세요.",
      prevPage: GenderScreen(),
      count: 4,
      child: Column(
        children: [
          SizedBox(height: 32),

          GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (context) => datePicker());
            },
            child: titleW(appController.dateFormat("y.M", date), size: 24),
          ),

          SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
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
                    appController.date = date;
                    appController.go(context, TimeScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: .circle,
                      border: .all(
                        color: cur.isAtSameMomentAs(date)
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    alignment: .center,
                    child: titleW(
                      "${cur.day}",
                      color: DateUtils.isSameMonth(cur, date)
                          ? Colors.white
                          : Colors.white54,
                    ),
                  ),
                );
              },
              itemCount: appController.lastDate(date) >= 35 ? 7 * 6 : 7 * 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget datePicker() {
    void updateDate(StateSetter set, {int? y, int? m, int? d}) {
      int newY = y ?? date.year;
      int newM = m ?? date.month;
      int newD = d ?? date.day;

      final maxD = appController.lastDate(DateTime(newY, newM));

      if (newD > maxD) {
        newD = maxD;
      }

      date = DateTime(newY, newM, newD);
      set(() {});
    }

    return Dialog(
      constraints: .tightFor(height: 300),
      child: Container(
        clipBehavior: .hardEdge,
        decoration: BoxDecoration(borderRadius: .circular(16)),
        child: background(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
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
                        updateDate(set, y: value);
                        setState(() {});
                      },
                      date.year - 1901,
                    ),
                  ),
                  Expanded(
                    child: listWheel(List.generate(12, (index) => index + 1), (
                      value,
                    ) {
                      updateDate(set, m: value);
                      setState(() {});
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
}
