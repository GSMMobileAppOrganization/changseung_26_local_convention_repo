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
  bool scrolled = false;

  final double width = 140;
  double curPosition = 4;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 42),

          LogoWidget(ver2: true, title: "인연 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),
          SizedBox(height: 10),
          titleW(
            "생각하고 있는 그 사람과 인연이 될 수 있을까요?",
            isF2: true,
            size: 12,
            color: Colors.white.withAlpha(180),
          ),

          Spacer(),

          titleW(
            "좌우로 스크롤하여\n카드 한 장을 골라보세요!",
            color: Colors.white.withAlpha(180),
            isF2: true,
            align: .center,
            height: 1.6,
          ),

          Spacer(),

          cardList(),
        ],
      ),
    );
  }

  Widget cardList() => GestureDetector(
    onHorizontalDragUpdate: (details) {
      scrolled = true;
      curPosition -= details.delta.dx / width;
      curPosition = curPosition.clamp(0, 8);
      setState(() {});
    },
    child: RepeatingAnimationBuilder(
      duration: Duration(seconds: 10),
      curve: Curves.bounceInOut,
      animatable: Tween(begin: -1.0, end: 1.0),
      repeatMode: .reverse,
      paused: scrolled,
      builder: (context, value, child) {
        if (!scrolled) {
          curPosition = 4 + value.toDouble();
        }
        return SizedBox(
          height: 220,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [.0, .05, .95, 1.0],
              ).createShader(bounds);
            },
            child: Stack(
              children: List.generate(9, (index) {
                final position = curPosition - index;

                final double offX = position * width / 2;
                final double offY = position.abs() * -10 - 5;
                final angle = position * .05;

                return Positioned(
                  left: MediaQuery.widthOf(context) / 2 - width / 2 + offX,
                  bottom: offY,
                  child: Transform.rotate(
                    angle: angle,
                    alignment: .center,
                    child: card(),
                  ),
                );
              }).reversed.toList(),
            ),
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
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(180),
            offset: .new(-.4, 0),
            blurRadius: 16,
          ),
        ],
      ),
      child: cardWidget(null, width),
    ),
  );
}
