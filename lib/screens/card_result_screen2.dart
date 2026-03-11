import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:daily_tarot_poc_app_2/models/soul_card_model.dart';
import 'package:daily_tarot_poc_app_2/screens/home_screen.dart';
import 'package:daily_tarot_poc_app_2/widgets/background2.dart';
import 'package:daily_tarot_poc_app_2/widgets/button_1.dart';
import 'package:daily_tarot_poc_app_2/widgets/button_2.dart';
import 'package:daily_tarot_poc_app_2/widgets/card_widget.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class CardResultScreen2 extends StatelessWidget {
  const CardResultScreen2({super.key, required this.card});

  final SoulCardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 32),

          LogoWidget(title: "카드풀이", ver2: true),

          SizedBox(height: 36),

          Hero(
            tag: "result_tag",
            createRectTween: (begin, end) => RectTween(begin: begin, end: end),
            child: Material(
              color: Colors.transparent,
              child: Column(
                spacing: 18,
                children: [
                  CardWidget(
                    path: "assets/images/tarot_cards/${card.image}",
                    width: 100,
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

          Padding(
            padding: .symmetric(horizontal: 36, vertical: 24),
            child: Text(
              card.storytelling,
              style: TextStyle(
                fontFamily: font2,
                fontWeight: .bold,
                color: Colors.white,
              ),
              strutStyle: StrutStyle(height: 2),
            ),
          ),

          Spacer(),

          Button2(
            tap: () => appController.moveRemove(context, HomeScreen()),
            text: "돌아가기",
            hasIcon: false,
          ),

          Spacer(),
        ],
      ),
    );
  }
}
