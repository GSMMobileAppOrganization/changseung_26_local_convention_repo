import 'dart:math';

import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/card_model.dart';
import 'package:daily_tarot_poc_app_11/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MySoulScreen1 extends StatefulWidget {
  const MySoulScreen1({super.key});

  @override
  State<MySoulScreen1> createState() => _MySoulScreen1State();
}

class _MySoulScreen1State extends State<MySoulScreen1> {
  final CardModel card = appController.getSoulCard();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 1));

      appController.goFade(context, MySoulScreen2());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              Spacer(flex: 3),

              LogoWidget(ver2: true, title: appController.cardFormat(card)),

              Spacer(flex: 4),

              Hero(
                tag: "t1",
                child: cardWidget(appController.cardPath(card), 200),
              ),

              Spacer(flex: 7),
            ],
          ),
        ),
      ),
    );
  }
}

class MySoulScreen2 extends StatefulWidget {
  const MySoulScreen2({super.key});

  @override
  State<MySoulScreen2> createState() => _MySoulScreen2State();
}

class _MySoulScreen2State extends State<MySoulScreen2> {
  final CardModel card = appController.getSoulCard();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28, top: 18),
                    child: Row(
                      children: [
                        Hero(
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
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.003)
                                    ..rotateY(animation.value * pi * 2),
                                  alignment: .center,
                                  child: toHeroContext.widget,
                                ),
                              ),
                          tag: "t1",
                          child: cardWidget(appController.cardPath(card), 100),
                        ),

                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              crossAxisAlignment: .start,
                              mainAxisSize: .min,
                              children: [
                                LogoWidget(ver2: true),

                                titleW(
                                  appController.dateFormat(
                                    "y년 M월 d일생",
                                    appController.date!,
                                  ),
                                ),
                                SizedBox(height: 24),
                                titleW(
                                  "당신의 소울카드는\n${appController.cardFormat(card)}입니다.",
                                  height: 2.2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 48,
                    ),
                    child: titleW(card.storytelling, height: 2.2),
                  ),
                ],
              ),
            ),

            Align(
              alignment: .bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 34),
                child: close(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget close() => GestureDetector(
    onTap: () {
      appController.goReset(context, HomeScreen());
    },
    child: Container(
      decoration: BoxDecoration(
        shape: .circle,
        border: .all(color: Colors.white, width: 1.2),
      ),
      padding: .all(14),
      child: Row(
        mainAxisSize: .min,
        children: [
          Transform.flip(flipX: true, child: back(30)),
          back(30),
        ],
      ),
    ),
  );
}
