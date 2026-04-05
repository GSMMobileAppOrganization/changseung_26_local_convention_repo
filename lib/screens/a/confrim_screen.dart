import 'package:daily_tarot_poc_app_15/app_controller.dart';
import 'package:daily_tarot_poc_app_15/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/a/5time_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_15/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({super.key});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "입력한 정보가 맞는지 확인해주세요.",
      prevPage: null,
      count: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 48),
        child: Column(
          spacing: 10,
          children: [
            outlineButton(
              "이름 : ${appController.name}",
              () => appController.goReset(context, NameScreen()),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: outlineButton(
                    "나이 : ${appController.age}세",
                    () => appController.goReset(context, AgeScreen()),
                  ),
                ),
                genderButton(),
              ],
            ),
            outlineButton(
              "생일 : ${appController.dateFormat("y.MM.dd", appController.date!)}",
              () => appController.goReset(context, DateScreen()),
            ),
            outlineButton(
              "태어난 시간 : ${appController.time != null ? appController.timeFormat("HH:mm", appController.time!) : "미입력"}",
              () => appController.goReset(context, TimeScreen()),
            ),

            SizedBox(height: 24),

            Row(
              spacing: 24,
              mainAxisAlignment: .center,
              children: [
                SizedBox(
                  width: 100,
                  child: button2("이전", () {
                    appController.back(context, TimeScreen());
                  }),
                ),

                SizedBox(
                  width: 160,
                  child: button1(
                    () => appController.goReset(context, HomeScreen()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget genderButton() => GestureDetector(
    onTap: () {
      appController.goReset(context, GenderScreen());
    },
    child: Container(
      decoration: BoxDecoration(
        shape: .circle,
        border: .all(color: Colors.white54, width: 1.6),
      ),
      padding: .all(6),
      child: SvgPicture.asset(
        appController.isMale!
            ? "assets/icons/male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg"
            : "assets/icons/female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg",
        fit: .fitWidth,
        width: 34,
      ),
    ),
  );

  Widget outlineButton(String m, VoidCallback tap) => GestureDetector(
    onTap: tap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: .circular(32),
        border: .all(color: Colors.white54, width: 1.2),
      ),
      padding: .symmetric(vertical: 13, horizontal: 24),
      alignment: .centerStart,
      child: titleW(
        m,
        color: Colors.white.withAlpha(220),
        size: 15,
        isF2: true,
      ),
    ),
  );
}
