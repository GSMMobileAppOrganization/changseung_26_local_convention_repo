import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/name_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/background.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> ani1;
  late final Animation<double> ani2;
  late final Animation<double> ani3;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800),
    );

    ani1 = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(.0, .3)));
    ani2 = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(.4, .6)));
    ani3 = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(.7, 1.0)));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      body: Stack(
        children: [
          FadeTransition(opacity: ani1, child: Background()),
          Column(
            children: [
              Spacer(),

              SlideTransition(
                position: ani2.drive(
                  Tween<Offset>(begin: Offset(0, .2), end: Offset(0, 0)),
                ),
                child: FadeTransition(
                  opacity: ani2,
                  child: Center(child: LogoWidget(title: "운명을 엿볼 시간이에요.")),
                ),
              ),

              SizedBox(height: 160),

              FadeTransition(
                opacity: ani3,
                child: SizedBox(
                  width: 200,
                  child: button1(
                    "시작하기",
                    () => appController.move(context, NameScreen()),
                    isBack: true,
                  ),
                ),
              ),

              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
