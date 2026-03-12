import 'dart:math';

import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/models/card_model.dart';
import 'package:daily_tarot_poc_app_4/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MySoulCardScreen2 extends StatelessWidget {
  const MySoulCardScreen2({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 24),

              Padding(padding: .only(left: 24), child: top()),

              Spacer(),

              Padding(
                padding: .symmetric(horizontal: 24),
                child: text(card.storytelling, tAlign: .center),
              ),

              Spacer(flex: 2),

              closeButton(context),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget top() => Row(
    crossAxisAlignment: .center,
    children: [
      _cardWidget(),

      Padding(
        padding: .only(left: 12),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            LogoWidget(ver2: true),
            text(appController.dateFormat("y년 M월 d일생,", appController.date!)),

            SizedBox(height: 32),

            text("당신의 소울카드는\n${appController.cardFormat(card)}입니다."),
          ],
        ),
      ),
    ],
  );

  Widget text(String m, {TextAlign tAlign = .start}) => Text(
    m,
    style: TextStyle(color: Colors.white, fontWeight: .bold),
    textAlign: tAlign,
    strutStyle: StrutStyle(height: 2),
  );

  Widget _cardWidget() => Hero(
    tag: "card_1",
    flightShuttleBuilder:
        (
          flightContext,
          animation,
          flightDirection,
          fromHeroContext,
          toHeroContext,
        ) => AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Transform(
            alignment: .center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value * pi * 4),
            child: toHeroContext.widget,
          ),
        ),
    child: cardWidget("assets/images/tarot_cards/${card.image}", 100),
  );
}
