import 'dart:math';

import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/models/card_model.dart';
import 'package:daily_tarot_poc_app_12/screens/c/card_result_screen.dart';
import 'package:daily_tarot_poc_app_12/widgets/background.dart';
import 'package:daily_tarot_poc_app_12/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
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
    .center: false,
    .centerRight: false,
    .bottomLeft: false,
    .bottomCenter: false,
    .bottomRight: false,
  };

  final Duration duration = Duration(milliseconds: 400);

  bool actioning = false;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(title: "열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요.", ver2: true),

          SizedBox(height: 6,),

          titleW(
            "지금 생각하고 있는 일은 어떤 결과로 이어질까요?",
            color: Colors.white.withAlpha(180),
            isF2: true,
            size: 13,
          ),

          SizedBox(height: 32),

          cardStack(),

          SizedBox(height: 48),

          SizedBox(
            width: 100,
            child: button2(hasIcon: false, "셔플", () async {
              if (!actioning) {
                actioning = true;
                for (var k in list.keys) {
                  list[k] = true;
                }

                setState(() {});
                await Future.delayed(duration);

                await Future.forEach(list.keys, (k) async {
                  if (k == .center) {
                    return;
                  }

                  list[k] = false;

                  setState(() {});
                  await Future.delayed(duration);
                });

                actioning = false;
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget cardStack() => SizedBox(
    height: 400,
    width: 260,
    child: Stack(
      children: [
        ...list.entries.map(
          (e) => Positioned.fill(
            child: AnimatedAlign(
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

    bool hover = false;

    final controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    controller.addListener(() {
      if (controller.isCompleted) {
        appController.goFade(
          context,
          CardResultScreen1(card: card, isFruit: true),
        );
      }
    });

    return StatefulBuilder(
      builder: (context, set) => GestureDetector(
        onLongPressStart: (details) {
          hover = true;
          set(() {});
          print(hover);
        },
        onLongPressEnd: (details) {
          hover = false;
          set(() {});
          print(hover);
        },
        onTap: () {
          if (!actioning) {
            actioning = true;
            card = appController.getRandomCard(appController.fruitCardList);
            controller.forward();
          }
        },
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, .002)
                ..rotateY(controller.value * pi)
                ..translateByDouble(0, 0, hover ? -20 : 0, 1),
              alignment: .center,
              child: cardWidget(
                controller.value >= .5 ? appController.cardPath(card) : null,
                80,
              ),
            );
          },
        ),
      ),
    );
  }
}
