import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/screens/name_input_screen.dart';
import 'package:daily_tarot_poc_app_2/widgets/background.dart';
import 'package:daily_tarot_poc_app_2/widgets/button_1.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/cloud_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _ani1;
  late final Animation<double> _ani2;
  late final Animation<double> _ani3;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800),
    );

    _ani1 = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(.0, .3)));
    _ani2 = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(.4, .6)));
    _ani3 = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(.7, 1.0)));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FadeTransition(opacity: _ani1, child: Background()),

          Column(
            children: [
              Spacer(flex: 2),

              FadeTransition(
                opacity: _ani2,
                child: LogoWidget(title: "운명을 엿볼 시간이에요."),
              ),

              SizedBox(height: 64),

              FadeTransition(
                opacity: _ani3,
                child: Button1(
                  title: "시작하기",
                  tap: () => appController.move(context, NameInputScreen()),
                ),
              ),

              Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }
}
