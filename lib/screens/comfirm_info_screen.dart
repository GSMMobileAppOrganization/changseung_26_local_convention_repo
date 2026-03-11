import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/screens/age_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/birth_date_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/birth_time_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/gender_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/home_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/name_input_screen.dart';
import 'package:daily_tarot_poc_app_2/widgets/background.dart';
import 'package:daily_tarot_poc_app_2/widgets/button_1.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfirmInfoScreen extends StatelessWidget {
  const ConfirmInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),

          Column(
            children: [
              Spacer(flex: 4),
              LogoWidget(title: "입력한 정보가 맞는지 확인해주세요."),

              Padding(
                padding: .symmetric(horizontal: 43),
                child: Column(
                  spacing: 12,
                  children: [
                    _infoBox(
                      "이름: ${appController.name}",
                      () =>
                          appController.moveReplace(context, NameInputScreen()),
                    ),
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: _infoBox(
                            "나이: ${appController.age}",
                            () => appController.moveReplace(
                              context,
                              AgeInputScreen(),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () => appController.moveReplace(
                            context,
                            GenderInputScreen(),
                          ),
                          child: SizedBox.square(
                            dimension: 46,
                            child: Container(
                              decoration: BoxDecoration(
                                border: .all(color: Colors.white),
                                shape: .circle,
                              ),
                              child: SvgPicture.asset(
                                appController.isMale!
                                    ? "assets/icons/male.svg"
                                    : "assets/icons/female.svg",
                                fit: .fitWidth,
                                width: 48,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _infoBox(
                      "생일: ${appController.dateFormat("yyyy.MM.dd", appController.birthDate!)}",
                      () => appController.moveReplace(
                        context,
                        BirthDateInputScreen(),
                      ),
                    ),
                    _infoBox(
                      "태어난 시간: ${appController.birthTime == null ? "모름" : appController.timeFormat("HH:mm", appController.birthTime!)}",
                      () => appController.moveReplace(
                        context,
                        BirthTimeInputScreen(),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 64),
              Button1(
                title: "시작하기",
                tap: () => appController.moveRemove(context, HomeScreen()),
              ),

              Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String text, VoidCallback tap) => GestureDetector(
    onTap: tap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: .circular(32),
        border: .all(color: Colors.white),
      ),
      padding: .symmetric(horizontal: 24, vertical: 12),
      alignment: .centerLeft,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: .bold),
      ),
    ),
  );
}
