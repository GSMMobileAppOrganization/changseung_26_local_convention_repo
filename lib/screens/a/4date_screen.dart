import 'package:daily_tarot_poc_app_15/app_controller.dart';
import 'package:daily_tarot_poc_app_15/main.dart';
import 'package:daily_tarot_poc_app_15/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_15/widgets/widgets.dart';
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
          SizedBox(height: 24),

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

                return Center(
                  child: InkWell(
                    onTap: () {
                      appController.date = cur;
                      appController.go(context, TimeScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: .circle,
                        border: .all(
                          color: DateUtils.isSameDay(cur, appController.date)
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

    void updateDate(StateSetter set, {int? y, int? m, int? d}) {
      int year = y ?? tempDate.year;
      int month = m ?? tempDate.month;
      int day = d ?? tempDate.day;

      tempDate = DateTime(year, month, day);
      set(() {});
    }

    return Dialog(
      constraints: .tightFor(height: 280, width: 300),
      child: Container(
        clipBehavior: .hardEdge,
        decoration: BoxDecoration(
          borderRadius: .circular(18),
          gradient: LinearGradient(
            colors: [purple, deepPurple],
            begin: .topLeft,
            end: .bottomRight,
          ),
        ),
        padding: .symmetric(horizontal: 24, vertical: 18),
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
                          tempDate.year - 1901,
                        ),
                      ),
                      Expanded(
                        child: listWheel(
                          List.generate(12, (index) => index + 1),
                          (value) {
                            updateDate(set, m: value);
                          },
                          tempDate.month - 1,
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
                    child: titleW("선택", size: 20, isF2: true),
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
