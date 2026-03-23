import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/main.dart';
import 'package:daily_tarot_poc_app_7/screesn/c/card_result_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/background.dart';
import 'package:daily_tarot_poc_app_7/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoveScreen extends StatefulWidget {
  const LoveScreen({super.key});

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  final double width = 150;
  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Background2(
      down: true,
      child: Column(
        children: [
          SizedBox(height: 76),

          LogoWidget(ver2: true, title: "연인 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),

          SizedBox(height: 8),

          title12W(
            "생각하고 있는 그 사람과 인연이 될 수 있을까요?",
            font: f2,
            color: Colors.white70,
          ),

          Spacer(),

          title16W(
            "좌우로 스크롤하여\n카드 한 장을 골라보세요!",
            font: f2,
            color: Colors.white70,
            align: .center,
            height: 1.8,
          ),

          Spacer(),

          cardList(),
        ],
      ),
    );
  }

  Widget cardList() => SizedBox(
    height: 240,
    child: GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          currentPage -= details.delta.dx / width;
        });
      },
      child: Stack(
        children: List.generate(9, (index) {
          final position = index - currentPage;
          final double xOffset = position * width / 2;
          final double yOffset = position.abs() * -15;
          final double angle = position * .1;
          return Positioned(
            left: MediaQuery.widthOf(context) / 2 - width / 2 + xOffset,
            bottom: yOffset - 5,
            child: Transform.rotate(
              angle: angle,
              alignment: .center,
              child: GestureDetector(
                onTap: () {
                  appController.go(
                    context,
                    CardResultScreen1(
                      card: appController.getRandomCard(
                        appController.loveCardList,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black87, blurRadius: 8),
                    ],
                  ),
                  child: cardWidget(null, width),
                ),
              ),
            ),
          );
        }),
      ),
    ),
  );
}
