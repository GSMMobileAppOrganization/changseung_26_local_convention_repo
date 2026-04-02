import 'dart:async';
import 'dart:math';

import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/card_model.dart';
import 'package:daily_tarot_poc_app_11/main.dart';
import 'package:daily_tarot_poc_app_11/screens/c/card_result_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/background.dart';
import 'package:daily_tarot_poc_app_11/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({super.key});

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen>
    with TickerProviderStateMixin {
  Map<Alignment, bool> list = {
    .topLeft: false,
    .topCenter: false,
    .topRight: false,
    .centerLeft: false,
    .centerRight: false,
    .bottomLeft: false,
    .bottomCenter: false,
    .bottomRight: false,
  };

  final Duration duration = Duration(milliseconds: 450);

  bool actioning = false;

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(ver2: true, title: "열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),
          SizedBox(height: 6),
          titleW(
            "지금 생각하고 있는 일은 어떤 결과로 이어질까요?",
            size: 13,
            color: Colors.white.withAlpha(180),
            font: f2,
          ),
          SizedBox(height: 34),

          cardStack(),

          SizedBox(height: 48),

          SizedBox(
            width: 100,
            child: button2(
              timer != null && timer!.isActive
                  ? appController.numberFormat("0.00", timer!.tick / 100)
                  : "셔플",
              () async {
                if (!actioning) {
                  actioning = true;

                  timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
                    setState(() {});
                    if (timer.tick == 500) {
                      timer.cancel();
                      actioning = false;
                    }
                  });

                  for (var k in list.keys) {
                    list[k] = true;
                  }
                  setState(() {});
                  await Future.delayed(duration);

                  await Future.forEach(list.keys, (k) async {
                    list[k] = false;
                    setState(() {});
                    await Future.delayed(duration);
                  });
                }
              },
              hasIcon: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardStack() => SizedBox(
    width: 260,
    height: 400,
    child: Stack(
      children: [
        Positioned.fill(child: Center(child: card())),
        ...list.entries.map(
          (e) => Positioned.fill(
            child: AnimatedAlign(
              curve: Curves.easeInOut,
              alignment: e.value ? .center : e.key,
              duration: duration,
              child: card(),
            ),
          ),
        ),
      ],
    ),
  );

  Widget card() {
    late final CardModel card;

    final controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    controller.addListener(() {
      if (controller.isCompleted) {
        appController.goFade(
          context,
          CardResultScreen1(isFruit: true, card: card),
        );
      }
    });

    return GestureDetector(
      onTap: () {
        if (!actioning) {
          card = appController.getRandomCard(appController.fruitCardList);
          controller.forward();
          actioning = true;
        }
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, .002)
            ..rotateY(controller.value * pi),
          alignment: .center,
          child: cardWidget(
            controller.value >= .5 ? appController.cardPath(card) : null,
            80,
          ),
        ),
      ),
    );
  }
}
