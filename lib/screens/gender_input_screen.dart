import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/screens/age_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/birth_date_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/birth_time_input_screen.dart';
import 'package:daily_tarot_poc_app_2/widgets/base_input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderInputScreen extends StatefulWidget {
  const GenderInputScreen({super.key});

  @override
  State<GenderInputScreen> createState() => _GenderInputScreenState();
}

class _GenderInputScreenState extends State<GenderInputScreen> {
  void submit() {
    appController.move(context, BirthDateInputScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BaseInputPage(
      title: "성별을 선택해주세요.",
      prevPage: AgeInputScreen(),
      count: 3,
      child: Align(
        alignment: .topCenter,
        child: Padding(
          padding: .only(top: 64),
          child: Row(
            spacing: 24,
            mainAxisAlignment: .center,
            children: [
              _button(false, () {
                appController.isMale = false;
                submit();
              }),
              _button(true, () {
                appController.isMale = true;
                submit();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(bool isMale, VoidCallback tap) => GestureDetector(
    onTap: tap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        border: .all(color: Colors.white, width: 1.5),
      ),
      padding: .all(16),
      child: SvgPicture.asset(
        isMale ? "assets/icons/male.svg" : "assets/icons/female.svg",
        fit: .fitWidth,
        width: 48,
      ),
    ),
  );
}
