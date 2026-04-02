import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/card_model.dart';
import 'package:daily_tarot_poc_app_11/main.dart';
import 'package:daily_tarot_poc_app_11/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/background.dart';
import 'package:daily_tarot_poc_app_11/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen1 extends StatelessWidget {
  const CardResultScreen1({
    super.key,
    required this.card,
    required this.isFruit,
  });

  final CardModel card;
  final bool isFruit;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(ver2: true, title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요"),

          Spacer(flex: 4),
          Hero(tag: 't1', child: cardWidget(appController.cardPath(card), 150)),
          SizedBox(height: 12),
          Hero(
            tag: 't2',
            child: Material(
              color: Colors.transparent,
              child: titleW(
                appController.cardFormat(card, ver2: true),
                size: 17,
              ),
            ),
          ),
          Spacer(flex: 3),
          SizedBox(
            width: 160,
            child: button1("결과 확인", () {
              appController.goFade(
                context,
                CardResultScreen2(card: card, isFruit: isFruit),
              );
            }, hasIcon: false),
          ),
          Spacer(flex: 7),
        ],
      ),
    );
  }
}

class CardResultScreen2 extends StatelessWidget {
  const CardResultScreen2({
    super.key,
    required this.card,
    required this.isFruit,
  });

  final CardModel card;
  final bool isFruit;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 48),

                LogoWidget(ver2: true, title: "카드풀이"),
                SizedBox(height: 32),
                Hero(
                  tag: 't1',
                  child: cardWidget(appController.cardPath(card), 100),
                ),
                SizedBox(height: 12),
                Hero(
                  tag: 't2',
                  child: Material(
                    color: Colors.transparent,
                    child: titleW(
                      appController.cardFormat(card, ver2: true),
                      size: 17,
                    ),
                  ),
                ),

                SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: titleW(
                    card.storytelling.replaceAll(". ", '.\n\n'),
                    size: 15,
                    color: Colors.white.withAlpha(180),
                    font: f2,
                  ),
                ),

                SizedBox(height: 120),
              ],
            ),
          ),

          Align(
            alignment: .bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 72),
              child: UnconstrainedBox(
                child: Row(
                  mainAxisAlignment: .spaceAround,
                  spacing: 36,
                  children: [
                    SizedBox(
                      width: 120,
                      child: button2(hasIcon: false, "돌아가기", () {
                        appController.goReset(context, HomeScreen());
                      }),
                    ),
                    SizedBox(
                      width: 120,
                      child: button2(hasIcon: false, "다시 뽑기", () {
                        appController.goReset(
                          context,
                          isFruit ? FruitScreen() : LoveScreen(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
