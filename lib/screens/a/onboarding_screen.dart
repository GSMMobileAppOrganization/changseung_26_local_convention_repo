import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
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

    ani1 = CurvedAnimation(parent: _controller, curve: Interval(.0, .3));
    ani2 = CurvedAnimation(parent: _controller, curve: Interval(.4, .6));
    ani3 = CurvedAnimation(parent: _controller, curve: Interval(.7, 1.0));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 100));
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: background(
          child: Stack(
            children: [
              ScaleTransition(
                scale: ani1,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: .new(-.2, .2),
                    end: .zero,
                  ).animate(ani1),
                  child: moon(140),
                ),
              ),

              FadeTransition(
                opacity: ani1,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: .new(0, .2),
                    end: .zero,
                  ).animate(ani1),
                  child: cloud(),
                ),
              ),

              Center(
                child: Column(
                  children: [
                    Spacer(flex: 2),
                    FadeTransition(
                      opacity: ani2,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: .new(0, .2),
                          end: .zero,
                        ).animate(ani2),
                        child: LogoWidget(title: "운명을 엿볼 시간이에요."),
                      ),
                    ),
                    Spacer(),
                    FadeTransition(
                      opacity: ani3,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: .new(0, -.2),
                          end: .zero,
                        ).animate(ani1),
                        child: SizedBox(
                          width: 180,
                          child: button1(
                            "시작하기",
                            () => appController.go(context, NameScreen()),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 36),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
