import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/screens/gender_input_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/base_input_page.dart';
import 'package:daily_tarot_poc_app_1/screens/birth_time_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthDateInputScreen extends StatefulWidget {
  const BirthDateInputScreen({super.key});

  @override
  State<BirthDateInputScreen> createState() => _BirthDateInputScreenState();
}

class _BirthDateInputScreenState extends State<BirthDateInputScreen> {
  int _startDate(DateTime date) => DateUtils.firstDayOffset(
    date.year,
    date.month,
    DefaultMaterialLocalizations(),
  );

  int _lastDate(DateTime date) =>
      DateUtils.getDaysInMonth(date.year, date.month);

  DateTime date = appController.birthDate == null
      ? DateTime.now()
      : appController.birthDate!;

  @override
  Widget build(BuildContext context) {
    return BaseInputPage(
      prevPage: GenderInputScreen(),
      title: "태어난 날짜를 입력해주세요.",
      count: 4,
      child: Column(
        children: [
          SizedBox(height: 32),

          dateView(),

          SizedBox(height: 24),

          SizedBox.square(dimension: 300, child: calender()),
        ],
      ),
    );
  }

  Widget dateView() => GestureDetector(
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
      DateFormat("y.M").format(date),
      style: TextStyle(fontWeight: .bold, fontSize: 24, color: Colors.white),
    ),
  );

  Widget calender() => GridView.builder(
    padding: .zero,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
    itemBuilder: (context, index) {
      final curDate = DateTime(
        date.year,
        date.month,
        1 - _startDate(date),
      ).add(Duration(days: index));
      return dateItem(curDate.day, () {
        appController.birthDate = curDate;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BirthTimeInputScreen()),
        );
      }, !(index >= _startDate(date)) || (index >= _lastDate(date)));
    },
    itemCount: 7 * 5,
  );

  Widget dateItem(int value, VoidCallback tap, bool isNotInMonth) => InkWell(
    onTap: tap,
    child: Center(
      child: Text(
        "$value",
        style: TextStyle(
          fontWeight: .bold,
          color: isNotInMonth ? Colors.white.withAlpha(100) : Colors.white,
        ),
      ),
    ),
  );
}
