import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/main.dart';
import 'package:daily_tarot_poc_app_8/models/card_model.dart';
import 'package:daily_tarot_poc_app_8/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_8/widgets/background2.dart';
import 'package:daily_tarot_poc_app_8/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen1 extends StatelessWidget {
  const CardResultScreen1({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(ver2: true, title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요"),

          Spacer(flex: 3),

          Hero(
            tag: "t2",
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 8,
                mainAxisSize: .min,
                children: [
                  cardWidget(appController.cardPath(card), 150),
                  titleMW(
                    appController.cardFormat(card, ver2: true),
                    weight: .bold,
                  ),
                ],
              ),
            ),
          ),

          Spacer(flex: 2),

          SizedBox(
            width: 160,
            child: button1("결과 확인", () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 600),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CardResultScreen2(card: card),
                ),
              );
            }, hasIcon: false),
          ),

          Spacer(flex: 5),
        ],
      ),
    );
  }
}

class CardResultScreen2 extends StatelessWidget {
  const CardResultScreen2({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(ver2: true, title: "카드풀이"),
          SizedBox(height: 36),
          Hero(
            tag: "t2",
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 8,
                mainAxisSize: .min,
                children: [
                  cardWidget(appController.cardPath(card), 100),
                  titleMW(
                    appController.cardFormat(card, ver2: true),
                    weight: .bold,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: SingleChildScrollView(
                child: titleSW(
                  color: Colors.white.withAlpha(220),
                  font: f2,
                  card.storytelling.split(".").fold("", (
                    previousValue,
                    element,
                  ) {
                    if (!element.contains(".") && element.trim().isNotEmpty) {
                      return "$previousValue${element.trim()}.\n\n";
                    }
                    return previousValue + element;
                  }),
                ),
              ),
            ),
          ),

          SizedBox(height: 36),

          SizedBox(
            width: 140,
            child: button2("돌아가기", () {
              appController.goReset(context, HomeScreen());
            }, hasIcon: false),
          ),

          SizedBox(height: 60),
        ],
      ),
    );
  }
}
