import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/screens/module_c/card_result_screen1.dart';
import 'package:daily_tarot_poc_app_3/widgets/background2.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
          SizedBox(height: 48),

          LogoWidget(title: "인연 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요.", ver2: true),
          Text(
            "생각하고 있는 그 사람과 인연이 될 수 있을까요?",
            style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: f2),
          ),

          Spacer(),

          Text(
            "좌우로 스크롤하여\n카드 한 장을 골라보세요!",
            style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: f2),
            textAlign: .center,
          ),

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
        diameterRatio: 10,
        squeeze: 2,
        perspective: 0.001,
        offAxisFraction: -15,
        onSelectedItemChanged: (value) {
          index = value;
          setState(() {});
        },
        children: List.generate(
          9,
          (i) => RotatedBox(
            quarterTurns: 1,
            child: GestureDetector(
              onTap: () {
                appController.move(
                  context,
                  CardResultScreen1(
                    card: appController.getRandomCard(
                      appController.loveCardList,
                    ),
                  ),
                );
              },
              child: Transform.rotate(
                angle: (index - i) * .05,
                child: cardWidget("assets/images/tarot_card_back.png", 180),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
