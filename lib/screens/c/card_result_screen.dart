import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/models/card_model.dart';
import 'package:daily_tarot_poc_app_12/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_12/widgets/background.dart';
import 'package:daily_tarot_poc_app_12/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
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
          SizedBox(height: 42),

          LogoWidget(title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요", ver2: true),

          Spacer(flex: 4),

          Hero(tag: "t1", child: cardWidget(appController.cardPath(card), 150)),
          SizedBox(height: 12),
          Hero(
            tag: "t2",
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
            width: 150,
            child: button1(hasIcon: false, "결과 확인", () {
              appController.goFade(
                context,
                CardResultScreen2(card: card, isFruit: isFruit),
              );
            }),
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
      child: Column(
        children: [
          SizedBox(height: 42),

          LogoWidget(title: "카드풀이", ver2: true),

          SizedBox(height: 36),

          Hero(tag: "t1", child: cardWidget(appController.cardPath(card), 100)),
          SizedBox(height: 12),
          Hero(
            tag: "t2",
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
            padding: const EdgeInsets.symmetric(horizontal: 46.0),
            child: titleW(
              card.storytelling.replaceAll(". ", ".\n\n"),
              isF2: true,
              color: Colors.white.withAlpha(180),
              size: 15,
              align: .start,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                SizedBox(
                  width: 130,
                  child: button2(hasIcon: false, "돌아가기", () {
                    appController.goReset(context, HomeScreen());
                  }),
                ),
                SizedBox(
                  width: 130,
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
        ],
      ),
    );
  }
}
