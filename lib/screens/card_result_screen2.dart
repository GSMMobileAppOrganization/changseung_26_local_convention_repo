import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/models/card_model.dart';
import 'package:daily_tarot_poc_app_1/screens/home_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/background_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_1.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/card_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget_2.dart';
import 'package:flutter/material.dart';

class CardResultScreen2 extends StatefulWidget {
  const CardResultScreen2({super.key, required this.card});

  final CardModel card;

  @override
  State<CardResultScreen2> createState() => _CardResultScreen2State();
}

class _CardResultScreen2State extends State<CardResultScreen2> {
  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Padding(
        padding: .symmetric(horizontal: 48),
        child: Column(
          children: [
            SizedBox(height: 36),

            LogoWidget2(text: "카드풀이"),

            SizedBox(height: 36),

            Hero(
              tag: "result_card",
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: .min,
                  spacing: 8,
                  children: [
                    CardWidget(
                      path: "assets/images/tarot_cards/${widget.card.image}",
                      width: 100,
                    ),
                    Text(
                      "${widget.card.number}. ${widget.card.name}",
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

            SizedBox(height: 36),

            Text(
              widget.card.storytelling,
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontFamily: font2,
              ),
              textAlign: .start,
              strutStyle: StrutStyle(height: 2),
            ),

            Spacer(),

            Button2(
              hasIcon: false,
              text: "돌아가기",
              tap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              ),
            ),

            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
