import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/main.dart';
import 'package:daily_tarot_poc_app_7/models/card_model.dart';
import 'package:daily_tarot_poc_app_7/screesn/b/home_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/background.dart';
import 'package:daily_tarot_poc_app_7/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen1 extends StatelessWidget {
  const CardResultScreen1({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 36),

          LogoWidget(ver2: true, title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요"),

          Spacer(flex: 3),

          Hero(
            tag: "t2",
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: .min,
                spacing: 12,
                children: [
                  cardWidget(appController.cardPath(card), 150),
                  Flexible(
                    child: title18W(appController.cardFormat(card, ver2: true)),
                  ),
                ],
              ),
            ),
          ),

          Spacer(flex: 2),

          SizedBox(
            width: 160,
            child: button1("결과 확인", () {
              appController.goCustom(
                context,
                CardResultScreen2(card: card),
                dur: Duration(milliseconds: 600),
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
          SizedBox(height: 36),

          LogoWidget(ver2: true, title: "카드풀이"),

          SizedBox(height: 24),

          Hero(
            tag: "t2",
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 12,
                mainAxisSize: .min,
                children: [
                  cardWidget(appController.cardPath(card), 100),
                  Flexible(
                    child: title18W(appController.cardFormat(card, ver2: true)),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: SingleChildScrollView(
                child: title16W(
                  card.storytelling.split(".").fold("", (
                    previousValue,
                    element,
                  ) {
                    if (element.trim().isNotEmpty && !element.contains(".")) {
                      return "$previousValue${element.trim()}.\n\n";
                    }
                    return previousValue + element.trim();
                  }),
                  font: f2,
                  color: Colors.white70,
                ),
              ),
            ),
          ),

          SizedBox(height: 24),

          SizedBox(
            width: 160,
            child: button2("돌아가기", () {
              appController.goReset(context, HomeScreen());
            }, hasIcon: false),
          ),

          SizedBox(height: 72),
        ],
      ),
    );
  }
}
