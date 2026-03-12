import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/main.dart';
import 'package:daily_tarot_poc_app_5/models/card_model.dart';
import 'package:daily_tarot_poc_app_5/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_5/widgets/background2.dart';
import 'package:daily_tarot_poc_app_5/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen2 extends StatelessWidget {
  const CardResultScreen2({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 42),

            LogoWidget(title: "카드풀이", ver2: true),

            SizedBox(height: 36),

            Hero(
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
              tag: "t2",
              child: Material(
                color: Colors.transparent,
                child: Column(
                  spacing: 12,
                  children: [
                    cardWidget(appController.cardPath(card), 100),
                    Text(
                      appController.cardFormat(card, ver2: true),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Text(
                card.storytelling,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .w500,
                  fontFamily: f2,
                ),
                textAlign: .start,
              ),
            ),

            Spacer(),

            SizedBox(
              width: 160,
              child: button2(
                hasIcon: false,
                "돌아가기",
                () => appController.moveReset(context, HomeScreen()),
              ),
            ),

            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
