import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
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

          dateView(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
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
                    appController.saveDate(cur);
                    appController.go(context, TimeScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: .all(
                        color: DateUtils.isSameDay(appController.date, cur)
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
                          : Colors.white54,
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
    DateTime tempDate = date ?? DateTime(1901, 1, 1);

    final yController = FixedExtentScrollController(initialItem: tempDate.year);
    final mController = FixedExtentScrollController(
      initialItem: tempDate.month,
    );

    final dController = FixedExtentScrollController(initialItem: tempDate.day);

    void update(StateSetter set, {int? y, int? m, int? d}) {
      int year = y ?? tempDate.year;
      int month = m ?? tempDate.month;
      int day = d ?? tempDate.day;

      final max = appController.lastDate(DateTime(year, month));

      if (max < day) {
        day = max;
        dController.animateToItem(
          day - 1,
          duration: Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }

      tempDate = DateTime(year, month, day);
      set(() {});
    }

    return Dialog(
      constraints: .tightFor(height: 300),
      child: StatefulBuilder(
        builder: (context, set) => background(
          isClip: true,
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
                  yController,
                ),
              ),

              Expanded(
                child: listWheel(List.generate(12, (index) => index + 1), (
                  value,
                ) {
                  date = DateTime(date.year, value);
                  setState(() {});
                  set(() {});
                }, mController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
