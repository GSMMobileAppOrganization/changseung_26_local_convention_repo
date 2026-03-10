import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/screens/name_input_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/base_input_page.dart';
import 'package:daily_tarot_poc_app_1/screens/gender_input_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/background.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/page_indicator.dart';
import 'package:daily_tarot_poc_app_1/widgets/text_input.dart';
import 'package:flutter/material.dart';

class AgeInputScreen extends StatefulWidget {
  const AgeInputScreen({super.key});

  @override
  State<AgeInputScreen> createState() => _AgeInputScreenState();
}

class _AgeInputScreenState extends State<AgeInputScreen> {
  final TextEditingController _controller = TextEditingController(
    text: "${appController.age ?? ""}" ,
  );

  void _submit(String text) {
    final number = int.tryParse(text.trim());

    if (number == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: purpleAccent,
          content: Text(
            "나이 입력을 필수이며 숫자만 입력가능합니다.",
            style: TextStyle(color: Colors.white, fontWeight: .bold),
          ),
        ),
      );
      return;
    }

    appController.age = number;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GenderInputScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseInputPage(
      prevPage: NameInputScreen(),
      title: "나이를 입력해주세요.",
      count: 2,
      child: Column(
        children: [
          SizedBox(height: 32),

          Padding(
            padding: .symmetric(horizontal: 32),
            child: TextInput(
              controller: _controller,
              hint: "나이를 입력해주세요.",
              submit: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
