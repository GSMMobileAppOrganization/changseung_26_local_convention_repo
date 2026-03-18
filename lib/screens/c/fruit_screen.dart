import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/main.dart';
import 'package:daily_tarot_poc_app_9/screens/c/card_result_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/background2.dart';
import 'package:daily_tarot_poc_app_9/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
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
      child: Column(
        children: [
          Spacer(flex: 2),

          LogoWidget(ver2: true, title: "열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),

          SizedBox(height: 8),

          title12W(
            "지금 생각하고 있는 일은 어떤 결과로 이어질까요?",
            font: f2,
            color: Colors.white70,
          ),

          SizedBox(height: 36),

          cardStack(),

          Spacer(flex: 2),

          SizedBox(
            width: 100,
            child: button2("셔플", () async {
              for (var i in list.keys) {
                list[i] = true;
              }
              setState(() {});
              await Future.delayed(duration);

              Future.forEach(list.keys, (e) async {
                list[e] = false;
                setState(() {});
                await Future.delayed(duration);
              });
            }, hasIcon: false),
          ),

          Spacer(flex: 3),
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
                appController.go(
                  context,
                  CardResultScreen1(
                    card: appController.getRandomCard(
                      appController.fruitCardList,
                    ),
                  ),
                );
              },
              child: cardWidget(null, 80),
            ),
          ),
        ),

        ...list.entries.map(
          (e) => Positioned.fill(
            child: AnimatedAlign(
              curve: Curves.easeOut,
              duration: duration,
              alignment: e.value ? .center : e.key,
              child: GestureDetector(
                onTap: () {
                  appController.go(
                    context,
                    CardResultScreen1(
                      card: appController.getRandomCard(
                        appController.fruitCardList,
                      ),
                    ),
                  );
                },
                child: cardWidget(null, 80),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
