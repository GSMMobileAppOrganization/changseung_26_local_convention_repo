import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/models/card_model.dart';
import 'package:daily_tarot_poc_app_5/screens/b/my_soul_card_screen2.dart';
import 'package:daily_tarot_poc_app_5/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
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
      await Future.delayed(Duration(seconds: 2));

      appController.noAnimationMove(
        context,
        MySoulCardScreen2(),
        dur: Duration(milliseconds: 600),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              Spacer(flex: 1),

              LogoWidget(ver2: true, title: appController.cardFormat(card)),

              Spacer(flex: 2),

              Hero(
                tag: "t1",
                child: cardWidget(appController.cardPath(card), 200),
              ),

              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
