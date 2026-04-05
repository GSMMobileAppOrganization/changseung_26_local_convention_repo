import 'package:daily_tarot_poc_app_14/app_controller.dart';
import 'package:daily_tarot_poc_app_14/main.dart';
import 'package:daily_tarot_poc_app_14/screens/a/2age_screen.dart';
import 'package:daily_tarot_poc_app_14/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_14/screens/a/splash_screen.dart';
import 'package:daily_tarot_poc_app_14/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _controller = TextEditingController(
    text: appController.name,
  );

  String error = "";

  void submit(String m) {
    final res = m.trim();

    if (res.length < 2 || res.length > 20) {
      error = res.isEmpty ? "이름 입력은 필수 입니다." : "이름은 최소 2자,\n최대 20자까지 가능합니다.";
      setState(() {});
      return;
    }

    appController.name = res;
    appController.go(context, AgeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "이름을 입력해주세요.",
      prevPage: SplashScreen(),
      count: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 58, vertical: 42),
        child: Column(
          spacing: 24,
          children: [
            TextField(
              decoration: InputDecoration(
                hint: titleW(
                  "이름을 입력해주세요.",
                  size: 15,
                  isF2: true,
                  color: Colors.white54,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: .circular(32),
                  borderSide: BorderSide(color: Colors.white54, width: 1.6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: .circular(32),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                contentPadding: .symmetric(horizontal: 24, vertical: 14),
              ),
              onSubmitted: submit,
              controller: _controller,
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontFamily: f2,
              ),
            ),

            if (error.isNotEmpty)
              titleW(
                error,
                color: Colors.red,
                isF2: true,
                size: 14,
                align: .center,
              ),
          ],
        ),
      ),
    );
  }
}
