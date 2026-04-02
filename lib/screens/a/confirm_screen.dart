import 'package:daily_tarot_poc_app_13/app_controller.dart';
import 'package:daily_tarot_poc_app_13/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_13/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "입력한 정보가 맞는지 확인해주세요.",
      prevPage: null,
      count: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 58, vertical: 42),
        child: Column(
          spacing: 10,
          children: [
            outlineButton(
              "이름 : ${appController.name}",
              () => appController.go(context, NameScreen()),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: outlineButton(
                    "나이 : ${appController.age}세",
                    () => appController.go(context, AgeScreen()),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    appController.goReset(context, GenderScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: .all(color: Colors.white54, width: 1.6),
                      shape: .circle,
                    ),
                    padding: .all(6),
                    child: SvgPicture.asset(
                      appController.isMale!
                          ? "assets/icons/male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg"
                          : "assets/icons/female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg",
                      fit: .fitWidth,
                      width: 38,
                    ),
                  ),
                ),
              ],
            ),
            outlineButton(
              "생일 : ${appController.dateFormat("y.MM.dd", appController.date!)}",
              () => appController.go(context, DateScreen()),
            ),
            outlineButton(
              "태어난 시간 : ${appController.time != null ? appController.timeFormat("HH:mm", appController.time!) : "잘 모르겠어요."}",
              () => appController.go(context, TimeScreen()),
            ),

            SizedBox(height: 24),

            SizedBox(
              width: 180,
              child: startButton(
                () => appController.goReset(context, HomeScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget outlineButton(String m, VoidCallback tap) => GestureDetector(
    onTap: tap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: .circular(32),
        border: .all(color: Colors.white54, width: 1.6),
      ),
      alignment: .centerLeft,
      padding: .symmetric(vertical: 13, horizontal: 24),
      child: titleW(m, size: 15, isF2: true),
    ),
  );
}
