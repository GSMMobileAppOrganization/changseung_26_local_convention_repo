import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/main.dart';
import 'package:daily_tarot_poc_app_5/screens/a/name_screen.dart';
import 'package:daily_tarot_poc_app_5/widgets/background1.dart';
import 'package:daily_tarot_poc_app_5/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> ani1;
  late final Animation<double> ani2;
  late final Animation<double> ani3;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800),
    );

    ani1 = Tween(begin: .0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(.0, .3)),
    );
    ani2 = Tween(begin: .0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(.4, .6)),
    );
    ani3 = Tween(begin: .0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(.7, 1.0)),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? date;
    return Scaffold(
      backgroundColor: purple,
      body: Stack(
        children: [
          FadeTransition(opacity: ani1, child: Background1()),

          Column(
            children: [
              Spacer(),

              Center(
                child: FadeTransition(
                  opacity: ani2,
                  child: LogoWidget(title: "운명을 엿볼 시간이에요."),
                ),
              ),

              SizedBox(height: 120),

              FadeTransition(
                opacity: ani3,
                child: SizedBox(
                  width: 180,
                  child: button1(
                    "시작하기",
                    () => appController.move(context, NameScreen()),
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
