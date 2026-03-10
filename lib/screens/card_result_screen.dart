import 'package:daily_tarot_poc_app_1/models/card_model.dart';
import 'package:daily_tarot_poc_app_1/screens/card_result_screen2.dart';
import 'package:daily_tarot_poc_app_1/widgets/background_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_1.dart';
import 'package:daily_tarot_poc_app_1/widgets/card_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget_2.dart';
import 'package:flutter/material.dart';

class CardResultScreen1 extends StatefulWidget {
  const CardResultScreen1({super.key, required this.card});

  final CardModel card;

  @override
  State<CardResultScreen1> createState() => _CardResultScreen1State();
}

class _CardResultScreen1State extends State<CardResultScreen1> {
  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 36),

          LogoWidget2(text: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요"),

          Spacer(),

          Center(
            child: Hero(
              tag: "result_card",
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: .min,
                  spacing: 8,
                  children: [
                    CardWidget(
                      path: "assets/images/tarot_cards/${widget.card.image}",
                      width: 150,
                    ),
                    Text(
                      "${widget.card.number}. ${widget.card.name}",
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
          ),
          Spacer(),

          Button1(
            tap: () => Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 600),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CardResultScreen2(card: widget.card),
              ),
            ),
            text: "결과 확인",
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
