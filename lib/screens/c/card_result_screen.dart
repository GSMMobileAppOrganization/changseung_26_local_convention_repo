import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/card_model.dart';
import 'package:daily_tarot_poc_app_3/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/background.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen1 extends StatelessWidget {
  const CardResultScreen1({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      down: true,
      child: Column(
        children: [
          SizedBox(height: 36),

          LogoWidget(ver2: true, title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요"),

          Spacer(flex: 3),

          Hero(
            tag: 't2',
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 12,
                children: [
                  cardWidget(appController.cardPath(card), 140),
                  titleW(appController.cardFormat(card, ver2: true)),
                ],
              ),
            ),
          ),

          Spacer(flex: 2),

          SizedBox(
            width: 150,
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
      down: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 36),

            LogoWidget(ver2: true, title: "카드 풀이"),

            SizedBox(height: 36),

            Hero(
              tag: 't2',
              child: Material(
                color: Colors.transparent,
                child: Column(
                  spacing: 12,
                  children: [
                    cardWidget(appController.cardPath(card), 100),
                    titleW(appController.cardFormat(card, ver2: true)),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 22),
              child: titleW(
                card.storytelling.replaceAll(". ", ".\n\n"),
                isF2: true,
                size: 15,
                color: Colors.white.withAlpha(220),
              ),
            ),

            SizedBox(height: 38),

            SizedBox(
              width: 140,
              child: button2("돌아가기", () {
                appController.goReset(context, HomeScreen());
              }, hasIcon: false),
            ),

            SizedBox(height: 38),
          ],
        ),
      ),
    );
  }
}
