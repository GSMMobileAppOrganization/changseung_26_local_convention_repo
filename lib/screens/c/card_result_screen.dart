import 'package:daily_tarot_poc_app_15/app_controller.dart';
import 'package:daily_tarot_poc_app_15/card_model.dart';
import 'package:daily_tarot_poc_app_15/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_15/widgets/background.dart';
import 'package:daily_tarot_poc_app_15/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_15/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen1 extends StatelessWidget {
  const CardResultScreen1({
    super.key,
    required this.isFruit,
    required this.card,
  });

  final bool isFruit;
  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 32),

          LogoWidget(ver2: true, title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요"),

          Spacer(flex: 4),

          Hero(tag: "t1", child: cardWidget(appController.cardPath(card), 150)),
          Hero(
            tag: "t2",
            child: Material(
              color: Colors.transparent,
              child: titleW(
                appController.cardFormat(card, ver2: true),
                size: 17,
                height: 3,
              ),
            ),
          ),

          Spacer(flex: 3),

          SizedBox(
            width: 150,
            child: button1(
              () {
                appController.goFade(
                  context,
                  CardResultScreen2(isFruit: isFruit, card: card),
                  dur: Duration(milliseconds: 800),
                );
              },
              m: "결과 확인",
              hasIcon: false,
            ),
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
    required this.isFruit,
    required this.card,
  });

  final bool isFruit;
  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 32),

            LogoWidget(ver2: true, title: "카드 풀이"),

            SizedBox(height: 36),

            Hero(
              tag: "t1",
              child: cardWidget(appController.cardPath(card), 100),
            ),
            Hero(
              tag: "t2",
              child: Material(
                color: Colors.transparent,
                child: titleW(
                  appController.cardFormat(card, ver2: true),
                  size: 17,
                  height: 3,
                ),
              ),
            ),

            SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: titleW(
                card.storytelling.replaceAll(". ", ".\n\n"),
                size: 15,
                color: Colors.white.withAlpha(180),
                isF2: true,
              ),
            ),

            SizedBox(height: 48),

            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: button2("다시 뽑기", () {
                      appController.back(
                        context,
                        isFruit ? FruitScreen() : LoveScreen(),
                      );
                    }, hasIcon: false),
                  ),
                ),

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: button2("돌아가기", () {
                      appController.goReset(context, HomeScreen());
                    }, hasIcon: false),
                  ),
                ),
              ],
            ),

            SizedBox(height: 38),
          ],
        ),
      ),
    );
  }
}
