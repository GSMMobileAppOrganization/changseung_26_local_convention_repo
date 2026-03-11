import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/screens/card_result_screen1.dart';
import 'package:daily_tarot_poc_app_2/widgets/background2.dart';
import 'package:daily_tarot_poc_app_2/widgets/button_2.dart';
import 'package:daily_tarot_poc_app_2/widgets/card_widget.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({super.key});

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
  Duration dur = Duration(milliseconds: 400);

  Map<Alignment, bool> list = {
    .topLeft: false,
    .topCenter: false,
    .topRight: false,
    .centerLeft: false,
    .centerRight: false,
    .bottomLeft: false,
    .bottomCenter: false,
    .bottomRight: false,
  };

  Future<void> supple() async {
    for (var e in list.entries) {
      list[e.key] = true;
    }
    setState(() {});

    await Future.delayed(dur);

    await Future.forEach(list.entries, (e) async {
      list[e.key] = false;
      setState(() {});
      await Future.delayed(dur);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          Spacer(),
          LogoWidget(title: "열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요.", ver2: true),
          SizedBox(height: 8),
          Text(
            "지금 생각하고 있는 일은 어떤 결과로 이어질까요?",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),

          SizedBox(height: 36),

          cardStack(),

          SizedBox(height: 64),

          Button2(
            text: "셔플",
            tap: () async {
              await supple();
            },
            hasIcon: false,
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget cardStack() => SizedBox(
    width: 260,
    height: 380,
    child: Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: .center,
            child: GestureDetector(
              onTap: () => appController.moveReplace(
                context,
                CardResultScreen1(
                  card: appController.getRandomCard(
                    appController.fruitCardList,
                  ),
                ),
              ),
              child: CardWidget(
                path: "assets/images/tarot_card_back.png",
                width: 80,
              ),
            ),
          ),
        ),

        ...list.entries.map(
          (e) => Positioned.fill(
            child: AnimatedAlign(
              duration: dur,
              alignment: e.value ? .center : e.key,
              child: GestureDetector(
                onTap: () => appController.moveReplace(
                  context,
                  CardResultScreen1(
                    card: appController.getRandomCard(
                      appController.fruitCardList,
                    ),
                  ),
                ),
                child: CardWidget(
                  path: "assets/images/tarot_card_back.png",
                  width: 80,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
