import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/screens/card_result_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/background_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/card_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget_2.dart';
import 'package:flutter/material.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({super.key});

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
  final Duration duration = Duration(milliseconds: 300);

  Map<Alignment, bool> list = {
    .topLeft: true,
    .topCenter: true,
    .topRight: true,
    .centerLeft: true,
    .centerRight: true,
    .bottomLeft: true,
    .bottomCenter: true,
    .bottomRight: true,
  };

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 36),

          LogoWidget2(text: "열매 타로를 선택하셨네요.\n신중하게 카드 1장을 선택해주세요."),
          SizedBox(height: 8),
          Text(
            "지금 생각하고 있는 일은 어떤 결과로 이어질까요?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: font2,
            ),
          ),

          SizedBox(height: 36),

          _cardStack(),

          Spacer(),

          Button2(
            text: "셔플",
            tap: () async {
              for (var e in list.entries) {
                setState(() {
                  list[e.key] = false;
                });
              }
              await Future.delayed(duration);

              await Future.forEach(list.entries, (e) async {
                setState(() {
                  list[e.key] = true;
                });

                await Future.delayed(duration);
              });
            },
          ),

          Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _cardStack() => SizedBox(
    height: 430,
    width: 300,
    child: Stack(
      children: [
        ...list.entries.map((e) => _card(e.key, e.value)),
        _card(.center, false),
      ],
    ),
  );

  Widget _card(Alignment align, isNotCenter) => Positioned(
    child: AnimatedAlign(
      duration: duration,
      curve: Curves.easeOut,
      alignment: isNotCenter ? align : .center,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardResultScreen1(
                card: appController.getRandomCard(appController.fruitCardList),
              ),
            ),
          );
        },
        child: CardWidget(path: "assets/images/tarot_card_back.png", width: 90),
      ),
    ),
  );
}
