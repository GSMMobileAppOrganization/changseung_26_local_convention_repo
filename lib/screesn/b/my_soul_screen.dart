import 'dart:math';

import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/models/card_model.dart';
import 'package:daily_tarot_poc_app_7/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
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

      appController.goCustom(
        context,
        MySoulScreen2(),
        dur: Duration(milliseconds: 600),
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
              LogoWidget(title: appController.cardFormat(card), ver2: true),

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
                padding: const EdgeInsets.only(left: 36, top: 16),
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
                                ..setEntry(3, 2, .00001)
                                ..rotateY(animation.value * pi * 2),
                              alignment: .center,
                              child: toHeroContext.widget,
                            ),
                          ),
                      child: cardWidget(appController.cardPath(card), 100),
                    ),

                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Column(
                          mainAxisSize: .min,
                          crossAxisAlignment: .start,
                          children: [
                            LogoWidget(ver2: true),
                            title16W(
                              size: 15,
                              appController.dateFormat(
                                "y년 M월 d일생,",
                                appController.date!,
                              ),
                            ),

                            SizedBox(height: 24),
                            Flexible(
                              child: title16W(
                                size: 15,
                                "당신의 소울카드는\n${appController.cardFormat(card)} 입니다.",
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

              SizedBox(height: 48),

              Padding(
                padding: .symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: .center,
                    children: split(card.storytelling, 8)
                        .map((e) => title16W(size: 15, e, align: .center, height: 2.2))
                        .toList(),
                  ),
                ),
              ),

              SizedBox(height: 98,),

              closeButton(context),

              SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  List<String> split(String text, int stand) {
    final List<String> res = [];
    String remain = text;

    while (remain.length > stand) {
      int index = -1;

      for (int i = stand; i < remain.length; i++) {
        if (remain[i] == "." || remain[i] == " ") {
          index = i;
          break;
        }
      }

      if (index != -1) {
        res.add(remain.substring(0, index + 1));
        remain = remain.substring(index + 1);
      } else {
        break;
      }
    }

    if (remain.isNotEmpty) res.add(remain.trim());
    return res;
  }
}
