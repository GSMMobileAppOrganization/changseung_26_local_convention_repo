import 'dart:math';

import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/card_model.dart';
import 'package:daily_tarot_poc_app_3/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
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
      await Future.delayed(Duration(milliseconds: 1200));

      appController.goCustom(
        context,
        MySoulScreen2(),
        dur: Duration(milliseconds: 1200),
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

              Spacer(flex: 5),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 32),
                child: Row(
                  children: [
                    Hero(
                      tag: "t1",
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
                                ..setEntry(3, 2, .0001)
                                ..rotateY(animation.value * pi * 2),
                              alignment: .center,
                              child: toHeroContext.widget,
                            ),
                          ),
                      child: cardWidget(appController.cardPath(card), 110),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            LogoWidget(ver2: true),
                            titleW(
                              size: 15,
                              appController.dateFormat(
                                "y년 M월 d일생, ",
                                appController.date!,
                              ),
                            ),
                            SizedBox(height: 24),

                            Flexible(
                              child: titleW(
                                size: 15,
                                appController.dateFormat(
                                  "당신의 소울 카드는\n${appController.cardFormat(card)} 입니다.",
                                  appController.date!,
                                ),
                                height: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 38),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: titleW(
                  card.storytelling.replaceAll(".", ".\n"),
                  size: 15,
                  align: .center,
                  height: 2,
                ),
              ),

              SizedBox(height: 62),

              GestureDetector(
                onTap: () {
                  appController.goReset(context, HomeScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: .circle,
                    border: .all(color: Colors.white30, width: 1.2),
                  ),
                  padding: .all(6),
                  child: Icon(Icons.close, color: Colors.white54, size: 36),
                ),
              ),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
