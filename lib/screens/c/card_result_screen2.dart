import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:daily_tarot_poc_app_4/models/card_model.dart';
import 'package:daily_tarot_poc_app_4/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/background2.dart';
import 'package:daily_tarot_poc_app_4/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen2 extends StatelessWidget {
  const CardResultScreen2({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 38),

          LogoWidget(ver2: true, title: "카드풀이"),

          SizedBox(height: 32),

          Hero(
            tag: "r2",
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 8,
                children: [
                  cardWidget("assets/images/tarot_cards/${card.image}", 100),
                  Text(
                    appController.cardFormat(card, ver2: true),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: .bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: .symmetric(horizontal: 42, vertical: 24),
            child: Text(
              card.storytelling,
              style: TextStyle(
                color: Colors.white,
                height: 1.6,
                fontFamily: f2,
              ),
              textAlign: .start,
            ),
          ),

          Spacer(),

          SizedBox(
            width: 140,
            child: button2(
              "돌아가기",
              () => appController.moveReset(context, HomeScreen()),
              hasIcon: false,
            ),
          ),

          Spacer(),
        ],
      ),
    );
  }
}
