import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:daily_tarot_poc_app_4/screens/c/card_result_screen1.dart';
import 'package:daily_tarot_poc_app_4/widgets/background2.dart';
import 'package:daily_tarot_poc_app_4/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({super.key});

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
  final Map<Alignment, bool> list = {
    .topLeft: false,
    .topCenter: false,
    .topRight: false,
    .centerLeft: false,
    .centerRight: false,
    .bottomLeft: false,
    .bottomCenter: false,
    .bottomRight: false,
  };

  final Duration duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(ver2: true, title: "열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),

          SizedBox(height: 8),

          Text(
            "지금 생각하고 있는 일은 어떤 결과로 이어질까요?",
            style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: f2),
          ),

          SizedBox(height: 48),

          SizedBox(width: 260, height: 380, child: cardStack()),

          Spacer(),

          SizedBox(
            width: 110,
            child: button2("셔플", hasIcon: false, () async {
              for (var e in list.entries) {
                list[e.key] = true;
              }
              setState(() {});
              await Future.delayed(duration);

              await Future.forEach(list.entries, (e) async {
                list[e.key] = false;
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

  Widget cardStack() => Stack(
    children: [
      Positioned.fill(
        child: Align(
          alignment: .center,
          child: GestureDetector(
            onTap: () => appController.move(
              context,
              CardResultScreen1(
                card: appController.getRandomCard(appController.fruitCardList),
              ),
            ),
            child: cardWidget(
              "assets/images/tarot_card_back.png",
              80,
              radius: 4,
            ),
          ),
        ),
      ),

      ...list.entries.map(
        (e) => Positioned.fill(
          child: AnimatedAlign(
            alignment: e.value ? .center : e.key,
            duration: duration,
            curve: Curves.easeOut,
            child: GestureDetector(
              onTap: () => appController.move(
                context,
                CardResultScreen1(
                  card: appController.getRandomCard(
                    appController.fruitCardList,
                  ),
                ),
              ),
              child: cardWidget(
                "assets/images/tarot_card_back.png",
                80,
                radius: 4,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
