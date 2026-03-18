import 'dart:math';

import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/models/card_model.dart';
import 'package:daily_tarot_poc_app_8/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MySoulScreen1 extends StatefulWidget {
  MySoulScreen1({super.key});

  @override
  State<MySoulScreen1> createState() => _MySoulScreen1State();
}

class _MySoulScreen1State extends State<MySoulScreen1> {
  final CardModel card = appController.getSoulCard();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 1800));

      appController.noAnimationMove(
        context,
        MySoulScreen2(),
        dur: Duration(milliseconds: 800),
      );
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
              Spacer(),

              LogoWidget(ver2: true, title: appController.cardFormat(card)),

              Spacer(flex: 2),

              Hero(
                tag: "t1",
                child: cardWidget(appController.cardPath(card), 200),
              ),

              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class MySoulScreen2 extends StatelessWidget {
  MySoulScreen2({super.key});

  final CardModel card = appController.getSoulCard();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: .only(top: 32, left: 28),
              child: SizedBox(
                height: 150,
                child: Row(
                  children: [
                    Hero(
                      tag: "t1",
                      createRectTween: (begin, end) =>
                          RectTween(begin: begin, end: end),
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
                                ..rotateY(animation.value * pi * 2),
                              child: toHeroContext.widget,
                            ),
                          ),
                      child: cardWidget(appController.cardPath(card), 100),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            LogoWidget(ver2: true),

                            titleSW(
                              appController.dateFormat(
                                "y년 M월 d일생,",
                                appController.date!,
                              ),
                            ),

                            Spacer(),

                            titleSW(
                              "당신의 소울카드는\n${appController.cardFormat(card)}",
                              align: .start,
                              height: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),
            Padding(
              padding: .symmetric(horizontal: 24),
              child: titleSW(card.storytelling, height: 2, align: .center),
            ),
            Spacer(flex: 1),
            closeButton(context),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
