import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/models/soul_card_model.dart';
import 'package:daily_tarot_poc_app_2/widgets/card_widget.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

import 'my_soul_card_screen2.dart';

class MySoulCardScreen1 extends StatefulWidget {
  const MySoulCardScreen1({super.key});

  @override
  State<MySoulCardScreen1> createState() => _MySoulCardScreen1State();
}

class _MySoulCardScreen1State extends State<MySoulCardScreen1> {
  SoulCardModel card = appController.getSoulCard();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 2));

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) =>
              MySoulCardScreen2(),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 64),

          LogoWidget(ver2: true, title: "${card.number}번 ${card.name}"),

          SizedBox(height: 120),

          Expanded(
            child: Center(
              child: Hero(
                tag: "soul_card",
                child: CardWidget(
                  path: "assets/images/tarot_cards/${card.image}",
                  width: 200,
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
