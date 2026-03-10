import 'dart:math';

import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:daily_tarot_poc_app_2/models/soul_card_model.dart';
import 'package:daily_tarot_poc_app_2/screens/home_screen.dart';
import 'package:daily_tarot_poc_app_2/widgets/card_widget.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class MySoulCardScreen2 extends StatefulWidget {
  const MySoulCardScreen2({super.key});

  @override
  State<MySoulCardScreen2> createState() => _MySoulCardScreen2State();
}

class _MySoulCardScreen2State extends State<MySoulCardScreen2> {
  SoulCardModel card = appController.getSoulCard();

  final TextStyle style = TextStyle(
    color: Colors.white,
    fontWeight: .bold,
    fontFamily: font1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: .symmetric(vertical: 32, horizontal: 22),
        child: Column(
          children: [
            _top(),

            Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment(0, -0.8),
                child: Text(
                  card.storytelling,
                  textAlign: .center,
                  style: style,
                  strutStyle: StrutStyle(height: 2),
                ),
              ),
            ),

            IconButton(
              style: ButtonStyle(
                shape: .all(
                  CircleBorder(
                    side: BorderSide(color: Colors.white, width: 0.4),
                  ),
                ),
              ),
              onPressed: () => appController.moveRemove(context, HomeScreen()),
              icon: Icon(Icons.close, color: Colors.white, size: 32),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _top() => SizedBox(
    height: 200,
    child: Row(
      mainAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        _card(),
        Flexible(
          child: Padding(
            padding: .only(left: 18),
            child: Column(
              mainAxisSize: .min,
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                SizedBox(width: 60, child: LogoWidget(ver2: true)),

                Text(
                  appController.dateFormat(
                    "y년 M월 d일생.",
                    appController.birthDate!,
                  ),
                  style: style,
                ),
                SizedBox(height: 32),

                Flexible(
                  child: Text(
                    "당신의 소울카드는\n${card.number}번 ${card.name} 입니다.",
                    style: style,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _card() => Hero(
    tag: "soul_card",
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
              ..setEntry(3, 2, 0.0001)
              ..rotateY(pi * animation.value * 4),
            child: toHeroContext.widget,
          ),
        ),
    child: CardWidget(
      path: "assets/images/tarot_cards/${card.image}",
      width: 100,
    ),
  );
}
