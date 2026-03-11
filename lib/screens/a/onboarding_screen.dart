import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:daily_tarot_poc_app_4/screens/a/name_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/background1.dart';
import 'package:daily_tarot_poc_app_4/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          FadeTransition(opacity: ani1, child: Background1()),

          Positioned.fill(
            child: Column(
              children: [
                Spacer(flex: 2),

                SlideTransition(
                  position: Tween<Offset>(
                    begin: .new(0, 0.2),
                    end: .new(0, 0),
                  ).animate(ani2),
                  child: FadeTransition(
                    opacity: ani2,
                    child: LogoWidget(title: "운명을 엿볼 시간이에요."),
                  ),
                ),

                Spacer(),

                FadeTransition(
                  opacity: ani3,
                  child: SizedBox(
                    width: 160,
                    child: button1(
                      isBack: true,
                      "시작하기",
                      () => appController.move(context, NameScreen()),
                    ),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
