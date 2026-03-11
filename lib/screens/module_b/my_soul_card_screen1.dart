import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/models/card_model.dart';
import 'package:daily_tarot_poc_app_3/screens/module_b/my_soul_card_screen2.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MySoulCardScreen1 extends StatefulWidget {
  MySoulCardScreen1({super.key});

  @override
  State<MySoulCardScreen1> createState() => _MySoulCardScreen1State();
}

class _MySoulCardScreen1State extends State<MySoulCardScreen1> {
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

  final CardModel card = appController.getSoulCard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Spacer(),

            LogoWidget(ver2: true, title: "${card.number}번 ${card.name}"),

            Spacer(),

            Hero(
              tag: "1",
              child: cardWidget("assets/images/tarot_cards/${card.image}", 200),
            ),

            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
