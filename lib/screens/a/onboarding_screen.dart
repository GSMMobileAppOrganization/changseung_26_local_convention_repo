import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/widgets.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 150));
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
                child: Padding(padding: .only(top: 12), child: moon(140)),
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
                          begin: .new(0, .4),
                          end: .zero,
                        ).animate(ani2),
                        child: LogoWidget(title: "운명을 엿볼 시간이에요."),
                      ),
                    ),

                    SizedBox(height: 12),

                    Spacer(),

                    FadeTransition(
                      opacity: ani3,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: .new(0, -.4),
                          end: .zero,
                        ).animate(ani3),
                        child: SizedBox(
                          width: 180,
                          child: button1(
                            "시작하기",
                            () => appController.go(context, NameScreen()),
                          ),
                        ),
                      ),
                    ),

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
