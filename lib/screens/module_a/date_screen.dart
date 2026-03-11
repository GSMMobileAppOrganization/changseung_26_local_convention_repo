import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/age_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/base_input_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/gender_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/time_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
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
    return BaseInputScreen(
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
              padding: .symmetric(vertical: 12),
              itemCount: 7 * 5,
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
                    appController.birthDate = curDate;
                    appController.move(context, TimeScreen());
                  },
                  child: Center(
                    child: Text(
                      "${curDate.day}",
                      style: TextStyle(
                        color: DateUtils.isSameMonth(curDate, date)
                            ? Colors.white
                            : Colors.white.withAlpha(100),
                        fontWeight: .bold,
                      ),
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

  Widget dateView() =>
      GestureDetector(
        onTap: () {
          showDialog(context: context, builder: (context) => datePicker());
          setState(() {});
        },
        child: Text(
          appController.dateFormat("y.M", date),
          style: TextStyle(
              color: Colors.white, fontWeight: .bold, fontSize: 24),
        ),
      );

  Widget datePicker() {

    date = DateTime(1900, 1);

    return Dialog(
      backgroundColor: purpleAccent,
      constraints: .tightFor(height: 300),
      child: Padding(
        padding: .symmetric(vertical: 32),
        child: StatefulBuilder(
          builder: (context, set) =>
              Row(
                mainAxisSize: .min,
                children: [
                  Expanded(
                    child: wheelList(
                        List.generate(127, (index) => index + 1900), (value,) {
                      date = DateTime(value, date.month);
                      setState(() {});
                      set(() {});
                    }),
                  ),
                  Expanded(
                    child: wheelList(
                      List.generate(
                        appController.isNowYear(date.year) ? DateTime.now().month : 12,
                            (index) =>
                        index + 1,
                      ),
                          (value) {
                        date = DateTime(date.year, value);
                        setState(() {});
                        set(() {});
                      },
                ),
              ),
                ],
              ),
        ),
      ),
    );
  }
}
