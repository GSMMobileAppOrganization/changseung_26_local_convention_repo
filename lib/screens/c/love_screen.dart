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
  double curIndex = 4;
  final double width = 140;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 86),

          LogoWidget(title: "인연 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요.", ver2: true),

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
            size: 16,
            isF2: true,
            color: Colors.white.withAlpha(180),
            align: .center,
            height: 1.6,
          ),

          Spacer(),

          cardList(),
        ],
      ),
    );
  }

  Widget cardList() => SizedBox(
    height: 220,
    child: GestureDetector(
      onHorizontalDragUpdate: (details) {
        curIndex -= details.delta.dx / width;
        curIndex = curIndex.clamp(0, 8);
        setState(() {});
      },
      child: Stack(
        children: List.generate(9, (index) {
          final position = index - curIndex;

          final offX = position * width * .5;
          final offY = position.abs() * -10 - 5;
          final angle = position * .07;

          return Positioned(
            left: MediaQuery.widthOf(context) / 2 - width / 2 + offX,
            bottom: offY,
            child: Transform.rotate(
              alignment: .center,
              angle: angle,
              child: card(),
            ),
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
          BoxShadow(
            color: Colors.black87,
            offset: .new(-.2, 0),
            blurRadius: 12,
          ),
        ],
      ),
      child: cardWidget(null, width),
    ),
  );
}
