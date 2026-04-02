import 'package:daily_tarot_poc_app_13/app_controller.dart';
import 'package:daily_tarot_poc_app_13/main.dart';
import 'package:daily_tarot_poc_app_13/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_13/widgets/widgets.dart';
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
          SizedBox(height: 36),

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

                return Center(
                  child: InkWell(
                    onTap: () {
                      appController.date = cur;
                      appController.go(context, TimeScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: .all(
                          color: DateUtils.isSameDay(cur, appController.date)
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        shape: .circle,
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
              itemCount: appController.lastDate(date) > 5 * 7 ? 7 * 6 : 7 * 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget datePicker() {
    DateTime tempDate = date;
    void updateDate(StateSetter set, {int? y, int? m}) {
      int year = y ?? tempDate.year;
      int month = m ?? tempDate.month;

      tempDate = DateTime(year, month);
      set(() {});
    }

    return Dialog(
      constraints: .tightFor(width: 300, height: 280),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [purple, deepPurple],
            begin: .topLeft,
            end: .bottomRight,
          ),
          borderRadius: .circular(16),
        ),
        padding: .symmetric(horizontal: 28, vertical: 18),
        clipBehavior: .hardEdge,
        child: StatefulBuilder(
          builder: (context, set) => Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: .symmetric(
                      horizontal: BorderSide(color: Colors.white30, width: 1.6),
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
                mainAxisAlignment: .end,
                children: [
                  GestureDetector(
                    onTap: () {
                      date = tempDate;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: titleW("선택", isF2: true),
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
