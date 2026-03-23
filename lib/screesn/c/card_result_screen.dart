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
                  cardWidget(appController.cardPath(card), 140),
                  Flexible(
                    child: title16W(appController.cardFormat(card, ver2: true)),
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

          Spacer(flex: 6),
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
          mainAxisAlignment: .start,
          children: [
            SizedBox(height: 42,),

            LogoWidget(ver2: true, title: "카드풀이"),

            SizedBox(height: 36),

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
                      child: title16W(
                        appController.cardFormat(card, ver2: true),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56),
              child: SingleChildScrollView(
                child: title16W(
                  size: 14,
                  card.storytelling.replaceAll(". ", ".\n\n"),
                  font: f2,
                  color: Colors.white70,
                  height: 1.6,
                ),
              ),
            ),

            SizedBox(height: 62),

            SizedBox(
              width: 130,
              child: button2("돌아가기", () {
                appController.goReset(context, HomeScreen());
              }, hasIcon: false),
            ),

            SizedBox(height: 62),

          ],
        ),
      ),
    );
  }
}
