import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/models/card_model.dart';
import 'package:daily_tarot_poc_app_3/screens/module_b/home_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_c/card_result_screen2.dart';
import 'package:daily_tarot_poc_app_3/widgets/background2.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen2 extends StatelessWidget {
  const CardResultScreen2({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(title: "카드풀이", ver2: true),

          SizedBox(height: 42),

          Hero(
            tag: "r2",
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
                children: [
                  cardWidget("assets/images/tarot_cards/${card.image}", 100),
                  Text(
                    appController.cardFormat(card),
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

          Padding(
            padding: .symmetric(horizontal: 38, vertical: 24),
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
            width: 150,
            child: button2(
              align: .center,
              hasIcon: false,
              "돌아가기",
              () => appController.moveRemove(context, HomeScreen()),
            ),
          ),

          Spacer(flex: 2),
        ],
      ),
    );
  }
}
