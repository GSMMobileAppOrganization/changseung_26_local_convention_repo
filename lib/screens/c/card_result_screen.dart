import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/main.dart';
import 'package:daily_tarot_poc_app_6/models/card_model.dart';
import 'package:daily_tarot_poc_app_6/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/background2.dart';
import 'package:daily_tarot_poc_app_6/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
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

          Spacer(),

          Hero(
            tag: "t2",
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 12,
                mainAxisSize: .min,
                children: [
                  cardWidget(appController.cardPath(card), 150),
                  titleMW(appController.cardFormat(card, ver2: true)),
                ],
              ),
            ),
          ),

          Spacer(flex: 2),

          SizedBox(
            width: 160,
            child: button1(
              radius: 2,
              hasIcon: false,
              "결과 확인",
              () => appController.noAnimationMove(
                dur: Duration(milliseconds: 1000),
                context,
                CardResultScreen2(card: card),
              ),
            ),
          ),

          Spacer(flex: 3),
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

          SizedBox(height: 38),

          Hero(
            tag: "t2",
            flightShuttleBuilder:
                (
                  flightContext,
                  animation,
                  flightDirection,
                  fromHeroContext,
                  toHeroContext,
                ) => FadeTransition(
                  opacity: animation,
                  child: toHeroContext.widget,
                ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 12,
                mainAxisSize: .min,
                children: [
                  cardWidget(appController.cardPath(card), 120),
                  titleMW(appController.cardFormat(card, ver2: true)),
                ],
              ),
            ),
          ),

          SizedBox(height: 18),

          Padding(
            padding: .symmetric(horizontal: 32),
            child: titleSW(
              card.storytelling,
              font: f2,
              align: .start,
              weight: .w500,
            ),
          ),

          Spacer(flex: 2),

          SizedBox(
            width: 160,
            child: button2(
              hasIcon: false,
              "돌아가기",
              () => appController.moveReset(context, HomeScreen()),
            ),
          ),

          Spacer(flex: 3),
        ],
      ),
    );
  }
}
