import 'dart:math';

import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/models/card_model.dart';
import 'package:daily_tarot_poc_app_9/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
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
      await Future.delayed(Duration(milliseconds: 1800));
      appController.noAnimationGo(context, MySoulScreen2());
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
              Spacer(flex: 1),

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
              padding: .only(left: 24, top: 24),
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
                              ..setEntry(3, 2, 0.00001)
                              ..rotateY(animation.value * pi * 3),
                            child: toHeroContext.widget,
                          ),
                        ),
                    child: cardWidget(appController.cardPath(card), 100),
                  ),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisSize: .min,
                        crossAxisAlignment: .start,
                        children: [
                          LogoWidget(ver2: true),

                          title16W(
                            appController.dateFormat(
                              "y년 M월 d일생,",
                              appController.date!,
                            ),
                          ),

                          SizedBox(height: 24),

                          Flexible(
                            child: title16W(
                              "당신의 소울 카드는\n${appController.cardFormat(card)} 입니다.",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(flex: 2),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: title16W(card.storytelling, align: .center, height: 2.2),
            ),

            Spacer(flex: 4),

            closeButton(context),

            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
