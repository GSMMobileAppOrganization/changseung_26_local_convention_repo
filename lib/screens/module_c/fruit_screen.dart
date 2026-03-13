import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/screens/module_c/card_result_screen1.dart';
import 'package:daily_tarot_poc_app_3/widgets/background2.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
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

  final Duration duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(title: "열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요.", ver2: true),
          Text(
            "지금 생각하고 있는 일은 어떤 결과로 이어질까요?",
            style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: f2),
          ),

          SizedBox(height: 36),

          cardStack(),

          Spacer(),

          SizedBox(
            width: 120,
            child: button2(align: .center, hasIcon: false, "셔플", () async {
              for (var e in list.entries) {
                list[e.key] = true;
              }
              setState(() {});
              await Future.delayed(duration);
              await Future.delayed(Duration(milliseconds: 300));

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

  Widget cardStack() => SizedBox(
    width: 260,
    height: 400,
    child: Stack(
      children: [
        card(.center, true),
        ...list.entries.map((e) => card(e.key, e.value)),
      ],
    ),
  );

  Widget card(Alignment align, bool isCenter) => AnimatedAlign(
    alignment: isCenter ? .center : align,
    duration: duration,
    curve: Curves.easeOut,
    child: GestureDetector(
      onTap: () {
        appController.move(
          context,
          CardResultScreen1(
            card: appController.getRandomCard(appController.fruitCardList),
          ),
        );
      },
      child: cardWidget("assets/images/tarot_card_back.png", 80),
    ),
  );
}
