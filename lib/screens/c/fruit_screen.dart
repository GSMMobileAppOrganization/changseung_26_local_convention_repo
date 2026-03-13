import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/main.dart';
import 'package:daily_tarot_poc_app_6/screens/c/card_result_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/background2.dart';
import 'package:daily_tarot_poc_app_6/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({super.key});

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
  Map<Alignment, bool> list = {
    .topLeft: true,
    .topCenter: true,
    .topRight: true,
    .centerLeft: true,
    .centerRight: true,
    .bottomLeft: true,
    .bottomCenter: true,
    .bottomRight: true,
  };

  final Duration duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(ver2: true, title: "열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),

          SizedBox(height: 12),

          titleSSW("지금 생각하고 있는 일은 어떤 결과로 이어질까요?", font: f2, weight: .bold),

          SizedBox(height: 38),

          cardStack(),

          Spacer(),

          SizedBox(
            width: 120,
            child: button2('셔플', () async {
              for (var e in list.keys) {
                list[e] = false;
              }
              setState(() {});
              await Future.delayed(duration);
              await Future.delayed(Duration(milliseconds: 300));

              await Future.forEach(list.keys, (e) async {
                list[e] = true;
                setState(() {});
                await Future.delayed(duration);
              });
            }),
          ),

          Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget cardStack() => SizedBox(
    height: 400,
    width: 260,
    child: Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: .center,
            child: GestureDetector(
              onTap: () {
                appController.move(
                  context,
                  CardResultScreen1(
                    card: appController.getRandomCard(
                      appController.fruitCardList,
                    ),
                  ),
                );
              },
              child: cardWidget("assets/images/tarot_card_back.png", 80),
            ),
          ),
        ),

        ...list.entries.map(
          (e) => Positioned.fill(
            child: AnimatedAlign(
              curve: Curves.easeOut,
              duration: duration,
              alignment: !e.value ? .center : e.key,
              child: GestureDetector(
                onTap: () {
                  appController.move(
                    context,
                    CardResultScreen1(
                      card: appController.getRandomCard(
                        appController.fruitCardList,
                      ),
                    ),
                  );
                },
                child: cardWidget("assets/images/tarot_card_back.png", 80),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
