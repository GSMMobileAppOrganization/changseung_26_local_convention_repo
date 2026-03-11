import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/models/soul_card_model.dart';
import 'package:daily_tarot_poc_app_2/screens/card_result_screen2.dart';
import 'package:daily_tarot_poc_app_2/widgets/background2.dart';
import 'package:daily_tarot_poc_app_2/widgets/button_1.dart';
import 'package:daily_tarot_poc_app_2/widgets/card_widget.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardResultScreen1 extends StatelessWidget {
  const CardResultScreen1({super.key, required this.card});

  final SoulCardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 32),

          LogoWidget(title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요", ver2: true),

          Spacer(flex: 3),

          Hero(
            tag: "result_tag",
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 18,
                children: [
                  CardWidget(
                    path: "assets/images/tarot_cards/${card.image}",
                    width: 150,
                  ),

                  Text(
                    "${card.number}. ${card.name}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: .bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Spacer(flex: 2),

          Button1(
            hasIcon: false,
            title: "결과 확인",
            tap: () => Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 600),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CardResultScreen2(card: card),
              ),
            ),
          ),

          Spacer(flex: 5),
        ],
      ),
    );
  }
}
