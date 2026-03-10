import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:daily_tarot_poc_app_2/screens/birth_time_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/gender_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_2/widgets/base_input_page.dart';
import 'package:daily_tarot_poc_app_2/widgets/input.dart';
import 'package:flutter/material.dart';

class BirthDateInputScreen extends StatefulWidget {
  const BirthDateInputScreen({super.key});

  @override
  State<BirthDateInputScreen> createState() => _BirthDateInputScreenState();
}

class _BirthDateInputScreenState extends State<BirthDateInputScreen> {
  void submit() {
    appController.move(context, BirthTimeInputScreen());
  }

  DateTime date = DateTime.now();

  int _startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int _lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  @override
  Widget build(BuildContext context) {
    return BaseInputPage(
      title: "태어난 날짜를 입력해주세요.",
      prevPage: GenderInputScreen(),
      count: 4,
      child: Column(
        children: [
          _dateView(),
          SizedBox(height: 300, width: 300, child: _calender()),
        ],
      ),
    );
  }

  Widget _dateView() => Padding(
    padding: .symmetric(vertical: 8),
    child: GestureDetector(
      onTap: () async {
        date =
            await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              initialDate: date,
            ) ??
            date;
        setState(() {});
      },
      child: Text(
        appController.dateFormat("y.M", date),
        style: TextStyle(color: Colors.white, fontWeight: .bold, fontSize: 24),
      ),
    ),
  );

  Widget _calender() => GridView.builder(
    padding: .zero,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 7,
      childAspectRatio: .9,
    ),
    itemCount: 7 * 5,
    itemBuilder: (context, index) {
      final curDate = DateTime(
        date.year,
        date.month,
        1 - _startDate(date),
      ).add(Duration(days: index));

      return _dateItem(
        curDate.day,
        !(index >= _startDate(date)) || index >= _lastDate(date),
        () {
          appController.birthDate = curDate;
          submit();
        },
      );
    },
  );

  Widget _dateItem(int date, bool isOverMonth, VoidCallback tap) => InkWell(
    onTap: tap,
    child: Center(
      child: Text(
        "$date",
        style: TextStyle(
          fontWeight: .bold,
          color: isOverMonth ? Colors.white.withAlpha(100) : Colors.white,
        ),
      ),
    ),
  );
}
