import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/models/card_model.dart';
import 'package:daily_tarot_poc_app_4/screens/c/card_result_screen2.dart';
import 'package:daily_tarot_poc_app_4/widgets/background2.dart';
import 'package:daily_tarot_poc_app_4/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen1 extends StatelessWidget {
  const CardResultScreen1({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 38),

          LogoWidget(ver2: true, title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요"),

          Spacer(flex: 2),

          Hero(
            tag: "r2",
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 8,
                children: [
                  cardWidget("assets/images/tarot_cards/${card.image}", 150),
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

          Spacer(),

          SizedBox(
            width: 160,
            child: button1(
              hasIcon: false,
              "결과 확인",
              () => Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 600),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CardResultScreen2(card: card),
                ),
              ),
            ),
          ),

          Spacer(flex: 3),
        ],
      ),
    );
  }
}
