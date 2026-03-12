import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/main.dart';
import 'package:daily_tarot_poc_app_5/screens/c/card_result_screen1.dart';
import 'package:daily_tarot_poc_app_5/widgets/background2.dart';
import 'package:daily_tarot_poc_app_5/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 48),

            LogoWidget(
              title: "열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요.",
              ver2: true,
            ),

            SizedBox(height: 8),

            Text(
              "지금 생각하고 있는 일은 어떤 결과로 이어질까요?",
              style: TextStyle(
                color: Colors.white,
                fontFamily: f2,
                fontSize: 12,
              ),
            ),

            SizedBox(height: 36),

            cardStack(),

            Spacer(),

            SizedBox(
              width: 120,
              child: button2("셔플", () async {
                for (var e in list.keys) {
                  list[e] = true;
                }
                setState(() {});

                await Future.delayed(duration);
                await Future.delayed(Duration(milliseconds: 300));

                await Future.forEach(list.keys, (e) async {
                  list[e] = false;

                  setState(() {});
                  await Future.delayed(duration);
                });
              }, hasIcon: false),
            ),

            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget cardStack() => SizedBox(
    height: 400,
    width: 260,
    child: Stack(
      children: [
        Align(
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

        ...list.entries.map(
          (e) => AnimatedAlign(
            curve: Curves.easeOut,
            alignment: e.value ? .center : e.key,
            duration: duration,
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
      ],
    ),
  );
}
