import 'dart:math';

import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/models/card_model.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MySoulCardScreen2 extends StatelessWidget {
  MySoulCardScreen2({super.key});

  final CardModel card = appController.getSoulCard();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 24),
              _top(),
              Spacer(),
              Padding(
                padding: .symmetric(horizontal: 24),
                child: text(card.storytelling, align: .center),
              ),
              Spacer(flex: 3),

              closeButton(context),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _top() => SizedBox(
    height: 160,
    child: Padding(
      padding: .only(left: 24),
      child: Row(
        children: [
          _card(),
          Expanded(
            child: Align(
              alignment: .bottomLeft,
              child: Padding(
                padding: .only(left: 18, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    LogoWidget(ver2: true),
                    text(
                      appController.dateFormat(
                        "y년 M월 d일생,",
                        appController.birthDate!,
                      ),
                    ),
                    Spacer(),

                    text("당신의 소울 카드는\n${card.number}번 ${card.name}입니다."),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _card() => Hero(
    tag: "1",
    createRectTween: (begin, end) => RectTween(begin: begin, end: end),
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

  Widget text(String m, {TextAlign align = .start}) => Text(
    m,
    softWrap: true,
    style: TextStyle(
      color: Colors.white,
      fontWeight: .bold,
      fontSize: 14,
      height: 2,
    ),
    textAlign: align,
  );
}
