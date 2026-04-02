import 'package:daily_tarot_poc_app_13/app_controller.dart';
import 'package:daily_tarot_poc_app_13/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/4date_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "성별을 선택해주세요.",
      prevPage: AgeScreen(),
      count: 3,
      child: Padding(
        padding: const EdgeInsets.only(top: 108),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 24,
          children: [genderButton(false), genderButton(true)],
        ),
      ),
    );
  }

  Widget genderButton(bool isMale) => GestureDetector(
    onTap: () {
      appController.isMale = isMale;
      appController.go(context, DateScreen());
    },
    child: Container(
      decoration: BoxDecoration(
        border: .all(color: Colors.white54, width: 1.6),
        borderRadius: .circular(16),
      ),
      padding: .all(8),
      child: SvgPicture.asset(
        isMale
            ? "assets/icons/male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg"
            : "assets/icons/female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg",
        fit: .fitWidth,
        width: 52,
      ),
    ),
  );
}
