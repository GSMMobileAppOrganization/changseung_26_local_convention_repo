import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/screens/c/card_result_screen.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/background.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/widgets.dart';

class LoveScreen extends StatefulWidget {
  const LoveScreen({super.key});

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  double posC = 0;
  final double width = 140;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(ver2: true, title: "인연 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),
          SizedBox(height: 6),
          titleW(
            "생각하고 있는 그 사람과 인연이 될 수 있을까요?",
            size: 13,
            color: Colors.white.withAlpha(180),
            font: f2,
          ),

          Spacer(),

          titleW(
            "좌우로 스크롤하여\n카드 한 장을 골라보세요!",
            size: 15,
            color: Colors.white.withAlpha(180),
            font: f2,
            height: 1.6,
            align: .center,
          ),

          Spacer(),

          cardList(),
        ],
      ),
    );
  }

  bool quitAni = false;

  Widget cardList() => GestureDetector(
    onHorizontalDragUpdate: (details) {
      quitAni = true;
      posC -= details.delta.dx / width;
      posC = posC.clamp(0, 8);
      setState(() {});
    },
    child: SizedBox(
      height: 220,
      child: TweenAnimationBuilder(
        tween: Tween(begin: .0, end: 1.0),
        curve: Curves.easeInOutQuart,
        duration: Duration(seconds: 9),
        builder: (context, value, child) {
          if (!quitAni) {
            posC = value * 8;
          }

          return Stack(
            children: List.generate(9, (index) {
              final pos = index - posC;

              final offX = pos * width / 2;
              final offY = pos.abs() * -10 - 5;
              final angle = pos * .05;

              return Positioned(
                left: MediaQuery.widthOf(context) / 2 - width / 2 + offX,
                bottom: offY,
                child: Transform.rotate(angle: angle, child: card()),
              );
            }),
          );
        },
      ),
    ),
  );

  Widget card() => GestureDetector(
    onTap: () {
      appController.goFade(
        context,
        CardResultScreen1(
          card: appController.getRandomCard(appController.loveCardList),
          isFruit: false,
        ),
      );
    },
    child: cardWidget(null, width),
  );
}
