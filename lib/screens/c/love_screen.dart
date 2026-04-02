import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:flutter/material.dart';

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
  double value = 0;
  final double width = 140;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(title: "인연 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요.", ver2: true),

          SizedBox(height: 6,),

          titleW(
            "생각하고 있는 그 사람과 인연이 될 수 있을까요?",
            color: Colors.white.withAlpha(180),
            isF2: true,
            size: 13,
          ),

          Spacer(),
          titleW(
            "좌우로 스크롤하여\n카드 한 장을 골라보세요!",
            color: Colors.white.withAlpha(180),
            isF2: true,
            size: 16,
            height: 1.6,
          ),
          Spacer(),

          cardList(),
        ],
      ),
    );
  }

  bool drag = false;
  bool isShow = false;

  Widget cardList() => GestureDetector(
    onHorizontalDragUpdate: (details) {
      drag = true;
      value -= details.delta.dx / width;
      value = value.clamp(0, 8);

      if (value == 8) {
        if (!isShow) {
          appController.showSnack(context, " 모든 카드를 확인했어요!\n마음에 드는 카드를 선택하세요.");
          isShow = true;
        }
      } else {
        isShow = false;
      }

      setState(() {});
    },
    child: TweenAnimationBuilder(
      tween: Tween(begin: .0, end: 1.0),
      duration: Duration(seconds: 9),
      curve: Curves.easeInOut,
      builder: (context, v, child) {
        if (!drag) {
          value = v * 8;
        }

        return SizedBox(
          height: 220,
          child: Stack(
            children: List.generate(9, (index) {
              final position = index - value;

              final offX = position * width / 2;
              final offY = position.abs() * -10 - 5;
              final angle = position * .05;

              return Positioned(
                left: MediaQuery.widthOf(context) / 2 - width / 2 + offX,
                bottom: offY,
                child: Transform.rotate(angle: angle, child: card()),
              );
            }),
          ),
        );
      },
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
