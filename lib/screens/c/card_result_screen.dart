import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/main.dart';
import 'package:daily_tarot_poc_app_9/models/card_model.dart';
import 'package:daily_tarot_poc_app_9/screens/b/home_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/background2.dart';
import 'package:daily_tarot_poc_app_9/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen1 extends StatelessWidget {
  const CardResultScreen1({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(ver2: true, title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요"),

          Spacer(flex: 3),

          Column(
            spacing: 12,
            children: [
              Hero(
                tag: "t1",
                child: cardWidget(appController.cardPath(card), 140),
              ),
              Hero(
                tag: "t2",
                child: Material(
                  color: Colors.transparent,
                  child: title18W(appController.cardFormat(card, ver2: true)),
                ),
              ),
            ],
          ),

          Spacer(flex: 2),

          SizedBox(
            width: 160,
            child: button1("결과 확인", () {
              appController.goCustom(context, CardResultScreen2(card));
            }, hasIcon: false),
          ),

          Spacer(flex: 5),
        ],
      ),
    );
  }
}

class CardResultScreen2 extends StatelessWidget {
  const CardResultScreen2(this.card, {super.key});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          SizedBox(height: 48),

          LogoWidget(ver2: true, title: "카드풀이"),
          SizedBox(height: 36),
          Material(
            color: Colors.transparent,
            child: Column(
              spacing: 12,
              children: [
                Hero(
                  tag: "t1",
                  child: cardWidget(appController.cardPath(card), 100),
                ),
                Hero(
                  tag: "t2",
                  child: Material(
                    color: Colors.transparent,
                    child: title18W(appController.cardFormat(card, ver2: true)),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          Expanded(
            child: Padding(
              padding: .symmetric(horizontal: 48),
              child: SingleChildScrollView(
                child: title16W(
                  size: 15,
                  card.storytelling.split(".").fold("", (
                    previousValue,
                    element,
                  ) {
                    if (!element.contains(".") && element.trim().isNotEmpty) {
                      return "$previousValue${element.trim()}.\n\n";
                    }
                    return previousValue + element;
                  }),
                  font: f2,
                ),
              ),
            ),
          ),

          SizedBox(height: 48),

          SizedBox(
            width: 140,
            child: button2("돌아가기", () {
              appController.goReset(context, HomeScreen());
            }, hasIcon: false),
          ),

          SizedBox(height: 60),
        ],
      ),
    );
  }
}
