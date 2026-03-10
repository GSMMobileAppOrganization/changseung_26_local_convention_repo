import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/models/card_model.dart';
import 'package:daily_tarot_poc_app_1/screens/my_soul_card_screen2.dart';
import 'package:daily_tarot_poc_app_1/widgets/card_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget_2.dart';
import 'package:flutter/material.dart';

class MySoulCardScreen1 extends StatefulWidget {
  const MySoulCardScreen1({super.key});

  @override
  State<MySoulCardScreen1> createState() => _MySoulCardScreen1State();
}

class _MySoulCardScreen1State extends State<MySoulCardScreen1> {
  final CardModel card = appController.getSoulCard();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 1));

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
          Spacer(),

          LogoWidget2(text: card.name),

          Spacer(),

          Center(
            child: Hero(
              tag: "soul_card",
              child: CardWidget(
                path: "assets/images/tarot_cards/${card.image}",
                width: 200,
              ),
            ),
          ),

          Spacer(flex: 3),
        ],
      ),
    );
  }
}
