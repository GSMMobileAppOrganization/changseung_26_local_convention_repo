import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/screens/age_input_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/birth_date_input_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/birth_time_input_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/gender_input_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/home_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/name_input_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/background.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_1.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/page_indicator.dart';
import 'package:daily_tarot_poc_app_1/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ConfirmInfoScreen extends StatefulWidget {
  const ConfirmInfoScreen({super.key});

  @override
  State<ConfirmInfoScreen> createState() => _ConfirmInfoScreenState();
}

class _ConfirmInfoScreenState extends State<ConfirmInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        spacing: 48,
        mainAxisAlignment: .center,
        children: [
          Spacer(),

          LogoWidget(text: "입력한 정보가 맞는지 확인해주세요."),

          Padding(
            padding: .symmetric(horizontal: 48),
            child: Column(
              spacing: 12,
              children: [
                _box(
                  "이름 : ${appController.name}",
                  () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => NameInputScreen()),
                    (route) => false,
                  ),
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: _box(
                        "나이 : ${appController.age}세",
                        () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AgeInputScreen(),
                          ),
                          (route) => false,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GenderInputScreen(),
                        ),
                        (route) => false,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: .circle,
                          border: .all(color: Colors.white),
                        ),
                        child: SizedBox.square(
                          dimension: 50,
                          child: SvgPicture.asset(
                            appController.gender == 1
                                ? "assets/icons/male.svg"
                                : "assets/icons/female.svg",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _box(
                  "생일 : ${DateFormat("y.MM.dd").format(appController.birthDate!)}",
                  () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BirthDateInputScreen(),
                    ),
                    (route) => false,
                  ),
                ),
                _box(
                  "태어난 시간 : ${appController.birthTime != null ? appController.timeFormat("HH:mm") : "모름"}",
                  () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BirthTimeInputScreen(),
                    ),
                    (route) => false,
                  ),
                ),
              ],
            ),
          ),

          Button1(
            tap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            ),
            text: "시작하기",
          ),

          Spacer(),
        ],
      ),
    );
  }

  Widget _box(String text, VoidCallback tap) => GestureDetector(
    onTap: tap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: .circular(32),
        border: .all(color: Colors.white),
      ),
      alignment: .centerLeft,
      padding: .symmetric(horizontal: 18, vertical: 16),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: .bold),
      ),
    ),
  );
}
