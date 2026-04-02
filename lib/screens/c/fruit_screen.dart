import 'package:daily_tarot_poc_app_13/app_controller.dart';
import 'package:daily_tarot_poc_app_13/screens/c/card_result_screen.dart';
import 'package:daily_tarot_poc_app_13/widgets/background.dart';
import 'package:daily_tarot_poc_app_13/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_13/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({super.key});

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
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

  final Duration duration = Duration(milliseconds: 400);
  bool actioning = false;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 38),

          LogoWidget(title: "열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요.", ver2: true),

          SizedBox(height: 8),

          titleW(
            "지금 생각하고 있는 일은 어떤 결과로 이어질까요?",
            size: 12,
            isF2: true,
            color: Colors.white.withAlpha(180),
          ),

          SizedBox(height: 38),

          cardStack(),

          SizedBox(height: 62),

          SizedBox(
            width: 90,
            child: button("셔플", () async {
              if (!actioning) {
                actioning = true;

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

                actioning = false;
              }
            }, hasIcon: false),
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
        Positioned.fill(child: Center(child: card())),

        ...list.entries.map(
          (e) => Positioned.fill(
            child: AnimatedAlign(
              curve: Curves.easeOut,
              alignment: e.value ? .center : e.key,
              duration: duration,
              child: card(),
            ),
          ),
        ),
      ],
    ),
  );

  Widget card() => GestureDetector(
    onTap: () {
      appController.goFade(
        context,
        CardResultScreen1(
          card: appController.getRandomCard(appController.fruitCardList),
        ),
      );
    },
    child: cardWidget(null, 80),
  );
}
