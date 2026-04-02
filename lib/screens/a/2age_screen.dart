import 'package:daily_tarot_poc_app_13/app_controller.dart';
import 'package:daily_tarot_poc_app_13/main.dart';
import 'package:daily_tarot_poc_app_13/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/splash_screen.dart';
import 'package:daily_tarot_poc_app_13/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  String error = "";

  final TextEditingController _controller = TextEditingController(
    text: appController.age?.toString(),
  );

  void submit(String m) {
    final res = int.tryParse(m.trim());

    if (res == null) {
      error = "나이 입력은 필수 입니다.";
      setState(() {});
      return;
    }
    appController.age = res;
    appController.go(context, GenderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "나이를 입력해주세요.",
      prevPage: NameScreen(),
      count: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 58, vertical: 50),
        child: Column(
          spacing: 24,
          children: [
            TextField(
              controller: _controller,
              keyboardType: .number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: .circular(32),
                  borderSide: BorderSide(color: Colors.white54, width: 1.6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: .circular(32),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                hint: titleW(
                  "나이를 입력해주세요.",
                  isF2: true,
                  color: Colors.white54,
                  size: 15,
                ),
                contentPadding: .symmetric(vertical: 14, horizontal: 24),
              ),
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontFamily: f2,
              ),
              onSubmitted: submit,
            ),

            if (error.isNotEmpty)
              titleW(
                error,
                color: Colors.red,
                align: .center,
                isF2: true,
                size: 14,
              ),
          ],
        ),
      ),
    );
  }
}
