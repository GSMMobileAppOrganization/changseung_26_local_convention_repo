import 'dart:math';

import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:flutter/material.dart';

import '../../models/card_model.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/widgets.dart';

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
              Padding(
                padding: .only(left: 24, top: 34),
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
                              alignment: .center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, .001)
                                ..rotateY(animation.value * pi * 2),
                              child: toHeroContext.widget,
                            ),
                          ),
                      createRectTween: (begin, end) =>
                          RectTween(end: end, begin: begin),
                      tag: "t1",
                      child: cardWidget(appController.cardPath(card), 100),
                    ),

                    Padding(
                      padding: .only(left: 12),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          LogoWidget(ver2: true),
                          text(
                            appController.dateFormat(
                              "y년 M월 d일생,",
                              appController.date!,
                            ),
                          ),

                          SizedBox(height: 18),

                          text(
                            "당신의 소울카드는\n${appController.cardFormat(card)} 입니다.",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),

              Padding(
                padding: .symmetric(horizontal: 18),
                child: text(card.storytelling, a: .center),
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

  Widget text(String m, {TextAlign a = .start}) => Text(
    m,
    textAlign: a,
    style: TextStyle(height: 2, color: Colors.white, fontWeight: .bold),
    softWrap: true,
  );
}
