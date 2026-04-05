import 'package:daily_tarot_poc_app_14/app_controller.dart';
import 'package:daily_tarot_poc_app_14/card_model.dart';
import 'package:daily_tarot_poc_app_14/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_14/widgets/background.dart';
import 'package:daily_tarot_poc_app_14/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_14/widgets/widgets.dart';
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

          LogoWidget(title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요", ver2: true),

          Spacer(flex: 4),
          Hero(tag: "t1", child: cardWidget(appController.cardPath(card), 140)),
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
            width: 160,
            child: button1(
              () {
                appController.goFade(context, CardResultScreen2(card: card));
              },
              hasIcon: false,
              m: "결과 확인",
            ),
          ),

          Spacer(flex: 8),
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
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 48),

                LogoWidget(title: "카드풀이", ver2: true),

                SizedBox(height: 36),

                Hero(
                  tag: "t1",
                  child: cardWidget(appController.cardPath(card), 100),
                ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: titleW(
                    card.storytelling.replaceAll(". ", ".\n\n"),
                    size: 15,
                    color: Colors.white.withAlpha(180),
                    isF2: true,
                  ),
                ),

                SizedBox(height: 84),
              ],
            ),
          ),

          Align(
            alignment: .bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 84),
              child: UnconstrainedBox(
                child: SizedBox(
                  width: 120,
                  child: button2(hasIcon: false, "돌아가기", () {
                    appController.goReset(context, HomeScreen());
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
