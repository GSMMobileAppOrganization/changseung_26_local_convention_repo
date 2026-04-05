import 'package:flutter/material.dart';

import '../../app_controller.dart';
import '../../widgets/background.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/widgets.dart';
import 'card_result_screen.dart';

class LoveScreen extends StatefulWidget {
  const LoveScreen({super.key});

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  double value = 4;
  final double width = 140;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 92),
          LogoWidget(ver2: true, title: "인연 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),

          SizedBox(height: 8),

          titleW(
            "생각하고 있는 그 사람과 인연이 될 수 있을까요?",
            size: 12,
            isF2: true,
            color: Colors.white.withAlpha(180),
          ),

          Spacer(),
          titleW(
            "좌우로 스크롤하여\n카드 한 장을 골라보세요!",
            isF2: true,
            height: 1.6,
            align: .center,
            color: Colors.white.withAlpha(180),
          ),

          Spacer(),

          cardList(),
        ],
      ),
    );
  }

  Widget cardList() => GestureDetector(
    onHorizontalDragUpdate: (details) {
      value -= details.delta.dx / width;
      value = value.clamp(0, 8);
      setState(() {});
    },
    child: SizedBox(
      height: 220,
      child: Stack(
        children: List.generate(9, (index) {
          final pos = index - value;

          final offX = pos * width / 2;
          final offy = pos.abs() * -8 - 5;
          final angle = pos * .05;

          return Positioned(
            left: MediaQuery.widthOf(context) / 2 - width / 2 + offX,
            bottom: offy,
            child: Transform.rotate(angle: angle, child: card()),
          );
        }),
      ),
    ),
  );

  Widget card() => GestureDetector(
    onTap: () {
      appController.goFade(
        context,
        CardResultScreen1(
          card: appController.getRandomCard(appController.loveCardList),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, offset: .new(-8, 0), blurRadius: 16),
        ],
      ),
      child: cardWidget(null, width),
    ),
  );
}
