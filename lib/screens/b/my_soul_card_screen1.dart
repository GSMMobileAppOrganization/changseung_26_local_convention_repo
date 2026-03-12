import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/models/card_model.dart';
import 'package:daily_tarot_poc_app_4/screens/b/my_soul_card_screen2.dart';
import 'package:daily_tarot_poc_app_4/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MySoulCardScreen1 extends StatefulWidget {
  const MySoulCardScreen1({super.key, required this.card});

  final CardModel card;

  @override
  State<MySoulCardScreen1> createState() => _MySoulCardScreen1State();
}

class _MySoulCardScreen1State extends State<MySoulCardScreen1> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 1800));
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) =>
              MySoulCardScreen2(card: widget.card),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 64),

              LogoWidget(
                ver2: true,
                title: appController.cardFormat(widget.card),
              ),

              Spacer(),

              Hero(
                tag: "card_1",
                child: cardWidget(
                  "assets/images/tarot_cards/${widget.card.image}",
                  200,
                ),
              ),

              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
