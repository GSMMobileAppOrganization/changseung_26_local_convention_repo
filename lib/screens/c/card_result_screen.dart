import 'package:daily_tarot_poc_app_13/app_controller.dart';
import 'package:daily_tarot_poc_app_13/card_model.dart';
import 'package:daily_tarot_poc_app_13/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_13/widgets/background.dart';
import 'package:daily_tarot_poc_app_13/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_13/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

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
          SizedBox(height: 42),
          LogoWidget(ver2: true, title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요"),

          Spacer(flex: 4),

          Hero(
            tag: "t1",
            child: cardWidget(appController.cardPath(widget.card), 150),
          ),
          SizedBox(height: 12),
          Hero(
            tag: "t2",
            child: Material(
              color: Colors.transparent,
              child: titleW(
                appController.cardFormat(widget.card, ver2: true),
                size: 17,
              ),
            ),
          ),

          Spacer(flex: 3),

          button1(),

          Spacer(flex: 7),
        ],
      ),
    );
  }

  Widget button1() => SizedBox(
    width: 160,
    child: GestureDetector(
      onTap: () {
        appController.goCustom(
          context,
          CardResultScreen2(card: widget.card),
          dur: Duration(milliseconds: 600),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [grad, accentPurple],
            radius: 2.2,
            center: .topLeft,
          ),
          borderRadius: .circular(32),
          boxShadow: [
            BoxShadow(
              color: grad.withAlpha(60),
              offset: .new(0, 8),
              blurRadius: 16,
            ),
          ],
        ),
        alignment: .center,
        padding: .symmetric(vertical: 16),
        child: titleW("결과 확인", size: 17),
      ),
    ),
  );
}

class CardResultScreen2 extends StatelessWidget {
  const CardResultScreen2({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 42),
            LogoWidget(ver2: true, title: "카드풀이"),
        
            SizedBox(height: 38),
        
            Hero(tag: "t1", child: cardWidget(appController.cardPath(card), 100)),
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
                size: 14,
                isF2: true,
                color: Colors.white.withAlpha(180),
              ),
            ),
        
            SizedBox(height: 72),
        
            SizedBox(
              width: 120,
              child: button(hasIcon: false, "돌아가기", () {
                appController.goReset(context, HomeScreen());
              }),
            ),
        
            SizedBox(height: 62),
          ],
        ),
      ),
    );
  }
}
