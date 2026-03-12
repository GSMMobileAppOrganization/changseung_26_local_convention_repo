import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/models/card_model.dart';
import 'package:daily_tarot_poc_app_5/screens/c/card_result_screen2.dart';
import 'package:daily_tarot_poc_app_5/widgets/background2.dart';
import 'package:daily_tarot_poc_app_5/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardResultScreen1 extends StatelessWidget {
  const CardResultScreen1({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 42),

            LogoWidget(title: "아래의 타로카드를 선택하셨군요\n결과를 확인해보세요", ver2: true),

            Spacer(),

            Hero(
              tag: "t2",
              child: Material(
                color: Colors.transparent,
                child: Column(
                  spacing: 12,
                  children: [
                    cardWidget(appController.cardPath(card), 150),
                    Text(
                      appController.cardFormat(card, ver2: true),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            SizedBox(
              width: 180,
              child: button1(
                "결과 확인",
                () => appController.noAnimationMove(
                  dur: Duration(milliseconds: 600),
                  context,
                  CardResultScreen2(card: card),
                ),
              ),
            ),

            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
