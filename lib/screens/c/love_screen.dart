import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/c/card_result_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/background.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoveScreen extends StatefulWidget {
  const LoveScreen({super.key});

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  double curPosition = 0;
  final double width = 140;

  @override
  Widget build(BuildContext context) {
    return Background2(
      down: true,
      child: Column(
        children: [
          SizedBox(height: 36),

          LogoWidget(ver2: true, title: "인연 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),

          SizedBox(height: 3),

          titleW(
            "생각하고 있는 그 사람과 인연이 될 수 있을까요?",
            color: Colors.white70,
            isF2: true,
            size: 12,
          ),

          Spacer(),


          titleW(
            height: 2,
            "좌우로 스크롤하여\n카드 한 장을 골라보세요!",
            isF2: true,
            color: Colors.white.withAlpha(180),
            align: .center,
          ),
          Spacer(),

          cardList(),
        ],
      ),
    );
  }

  Widget cardList() => SizedBox(
    height: 300,
    child: GestureDetector(
      onHorizontalDragUpdate: (details) {
        curPosition -= details.delta.dx / width;
        curPosition = curPosition.clamp(0, 8);
        setState(() {});
      },
      child: Stack(
        children: List.generate(9, (index) {
          final position = index - curPosition;
          final offX = position * width / 2;
          final offY = position.abs() * -10 - 5;
          final angle = position * .08;
          return Positioned(
            left: MediaQuery.widthOf(context) / 2 - width / 2 + offX,
            bottom: offY,
            child: Transform.rotate(
              angle: angle,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: .new(-.8, 0),
                      color: Colors.black,
                      blurRadius: 6,
                    ),
                  ],
                ),
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
