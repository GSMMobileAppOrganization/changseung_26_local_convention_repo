import 'dart:io';

import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/screens/c/card_result_screen.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/background2.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/widgets.dart';

class LoveScreen extends StatefulWidget {
  const LoveScreen({super.key});

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 82),

          LogoWidget(ver2: true, title: "인연 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),

          SizedBox(height: 12),

          titleSSW("생각하고 있는 그 사람과 인연이 될 수 있을까요?", font: f2, weight: .bold),

          Spacer(),

          titleMW("좌우로 스크롤하여\n카드 한 장을 골라보세요!", align: .center, font: f2),

          Spacer(),

          cardList(),
        ],
      ),
    );
  }

  int index = 4;

  Widget cardList() => SizedBox(
    height: 250,
    child: RotatedBox(
      quarterTurns: 1,
      child: ListWheelScrollView(
        itemExtent: 150,
        diameterRatio: 15,
        squeeze: 2,
        offAxisFraction: -8,
        onSelectedItemChanged: (value) {
          index = value;
          setState(() {});
        },
        children: List.generate(
          9,
          (i) => GestureDetector(
            onTap: () => appController.move(
              context,
              CardResultScreen1(
                card: appController.getRandomCard(appController.loveCardList),
              ),
            ),
            child: RotatedBox(
              quarterTurns: 1,
              child: Transform.rotate(
                angle: (index - i) * .05,
                child: cardWidget("assets/images/tarot_card_back.png", 150),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
