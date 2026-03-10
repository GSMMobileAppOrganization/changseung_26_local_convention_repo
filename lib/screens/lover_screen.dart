import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/screens/card_result_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/background_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/card_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget_2.dart';
import 'package:flutter/material.dart';

class LoverScreen extends StatefulWidget {
  const LoverScreen({super.key});

  @override
  State<LoverScreen> createState() => _LoverScreenState();
}

class _LoverScreenState extends State<LoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 36),

          LogoWidget2(text: "인연 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),
          SizedBox(height: 8),
          Text(
            "지금 생각하고 있는 일은 어떤 결과로 이어질까요?",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),

          Spacer(),

          Text(
            "좌우로 스크롤하여\n카드 한 장을 골라보세요!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: font2,
            ),
            textAlign: .center,
          ),

          Spacer(),

          _cardList(),
        ],
      ),
    );
  }

  Widget _cardList() => SizedBox(
    height: 280,
    child: RotatedBox(
      quarterTurns: 1,
      child: ListWheelScrollView(
        squeeze: 1.8,
        offAxisFraction: -15,
        perspective: 0.001,
        diameterRatio: 15,
        itemExtent: 150,
        children: List.generate(
          9,
          (index) => RotatedBox(
            quarterTurns: 1,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardResultScreen1(
                    card: appController.getRandomCard(
                      appController.loveCardList,
                    ),
                  ),
                ),
              ),
              child: CardWidget(
                path: "assets/images/tarot_card_back.png",
                width: 200,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
