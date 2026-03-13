import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/models/card_model.dart';
import 'package:daily_tarot_poc_app_3/screens/module_c/card_result_screen2.dart';
import 'package:daily_tarot_poc_app_3/widgets/background2.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
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

          Spacer(flex: 2),

          Hero(
            tag: "r2",
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 12,
                children: [
                  cardWidget(
                    "assets/images/tarot_cards/${card.image}",
                    150,
                  ),
                  Text(
                    appController.cardFormat(card),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: .bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Spacer(flex: 1),

          SizedBox(
            width: 180,
            child: button1("결과 확인", () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CardResultScreen2(card: card),
                ),
              );
            }, hasIcon: false),
          ),

          Spacer(flex: 3),
        ],
      ),
    );
  }
}
