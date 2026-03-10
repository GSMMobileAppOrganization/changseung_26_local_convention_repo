import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/screens/age_input_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/base_input_page.dart';
import 'package:daily_tarot_poc_app_1/screens/birth_date_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderInputScreen extends StatefulWidget {
  const GenderInputScreen({super.key});

  @override
  State<GenderInputScreen> createState() => _GenderInputScreenState();
}

class _GenderInputScreenState extends State<GenderInputScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseInputPage(
      prevPage: AgeInputScreen(),
      title: "성별을 선택해주세요.",
      count: 3,
      child: Column(
        children: [
          SizedBox(height: 80),

          Row(
            mainAxisAlignment: .center,
            spacing: 24,
            children: [
              _button("assets/icons/female.svg", () {
                appController.gender = 2;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BirthDateInputScreen(),
                  ),
                );
              }),

              _button("assets/icons/male.svg", () {
                appController.gender = 1;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BirthDateInputScreen(),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }





  Widget _button(String path, VoidCallback tap) => GestureDetector(
    onTap: tap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: .circular(24),
        border: .all(color: Colors.white),
      ),
      padding: .all(12),
      child: SizedBox.square(dimension: 64, child: SvgPicture.asset(path)),
    ),
  );
}
