import 'package:daily_tarot_poc_app_14/app_controller.dart';
import 'package:daily_tarot_poc_app_14/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_14/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_14/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_14/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GridView.builder(
              shrinkWrap: true,
              padding: .zero,
              physics: NeverScrollableScrollPhysics(),
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
                    appController.date = cur;
                    appController.go(context, TimeScreen());
                  },
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: .circle,
                        border: .all(
                          color: DateUtils.isSameDay(appController.date, cur)
                              ? Colors.white
                              : Colors.transparent,
                        ),
                      ),
                      alignment: .center,
                      child: titleW(
                        "${cur.day}",
                        color: DateUtils.isSameMonth(date, cur)
                            ? Colors.white
                            : Colors.white54,
                      ),
                    ),
                  ),
                );
              },
              itemCount:
                  appController.lastDate(date) + appController.startDate(date) >
                      7 * 5
                  ? 7 * 6
                  : 7 * 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget datePicker() {
    DateTime tempDate = date ?? DateTime(1901, 1, 1);

    final yController = FixedExtentScrollController(
      initialItem: tempDate.year - 1901,
    );
    final mController = FixedExtentScrollController(
      initialItem: tempDate.month - 1,
    );

    void updateDate(StateSetter set, {int? y, int? m, int? d}) {
      int year = y ?? tempDate.year;
      int month = m ?? tempDate.month;
      int day = d ?? tempDate.day;

      tempDate = DateTime(year, month);
      set(() {});
    }

    return Dialog(
      constraints: .tightFor(height: 280, width: 300),
      child: Container(
        clipBehavior: .hardEdge,
        decoration: BoxDecoration(
          borderRadius: .circular(12),
          gradient: LinearGradient(
            colors: [purple, deepPurple],
            begin: .topLeft,
            end: .bottomRight,
          ),
        ),
        padding: .symmetric(horizontal: 22, vertical: 18),
        child: StatefulBuilder(
          builder: (context, set) => Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: .symmetric(
                      horizontal: BorderSide(color: Colors.white30, width: 1.2),
                    ),
                  ),
                  padding: .symmetric(vertical: 12),
                  margin: .symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: listWheel(
                          List.generate(
                            DateTime.now().year - 1900,
                            (index) => index + 1901,
                          ),
                          (value) {
                            updateDate(set, y: value);
                          },
                          yController,
                        ),
                      ),
                      Expanded(
                        child: listWheel(
                          List.generate(12, (index) => index + 1),
                          (value) {
                            updateDate(set, m: value);
                          },
                          mController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: .center,
                children: [
                  GestureDetector(
                    onTap: () {
                      date = tempDate;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: titleW("선택", isF2: true, size: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
