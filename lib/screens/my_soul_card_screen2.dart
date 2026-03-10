import 'dart:math';

import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/models/card_model.dart';
import 'package:daily_tarot_poc_app_1/screens/home_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MySoulCardScreen2 extends StatefulWidget {
  const MySoulCardScreen2({super.key});

  @override
  State<MySoulCardScreen2> createState() => _MySoulCardScreen2State();
}

class _MySoulCardScreen2State extends State<MySoulCardScreen2> {
  final CardModel card = appController.getSoulCard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: .symmetric(horizontal: 36, vertical: 64),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
            height: 2,
            fontWeight: .bold,
            fontFamily: font1,
          ),
          textAlign: .start,
          child: Column(
            children: [
              _top(),

              Expanded(
                child: Center(
                  child: Text(
                    card.storytelling,
                    textAlign: .center,
                    softWrap: true,
                  ),
                ),
              ),

              IconButton(
                style: ButtonStyle(
                  shape: .all(
                    CircleBorder(
                      side: BorderSide(color: Colors.white, width: 0.5),
                    ),
                  ),
                ),
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                ),
                icon: Icon(Icons.close, size: 38, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _top() => SizedBox(
    width: 400,
    child: Row(
      children: [
        _card(),

        Expanded(
          child: Padding(
            padding: .symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              children: [
                SizedBox(
                  height: 36,
                  child: ClipRect(
                    clipBehavior: .hardEdge,
                    child: Image.asset(
                      "assets/images/graphic.png",
                      fit: .fitWidth,
                      width: 60,
                    ),
                  ),
                ),
                Text(DateFormat("y년 M월 d일생.").format(appController.birthDate!)),

                SizedBox(height: 24),

                Text("당신의 소울카드는\n${card.name} 입니다.", softWrap: true),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _card() => Hero(
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
              ..rotateY(pi * animation.value * 4),
            child: toHeroContext.widget,
          ),
        ),
    tag: "soul_card",
    child: CardWidget(
      path: "assets/images/tarot_cards/${card.image}",
      width: 100,
    ),
  );
}
