import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/main.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/name_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/background.dart';
import 'package:daily_tarot_poc_app_7/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
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
  late final Animation<double> ani4;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800),
    );

    ani1 = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.0, .4)));

    ani2 = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(.2, .8)));

    ani3 = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(.4, .6)));

    ani4 = Tween(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(.8, 1.0)));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await precacheImage(AssetImage("assets/images/moon.png"), context);
      await precacheImage(AssetImage("assets/images/cloud.png"), context);

      await Future.delayed(Duration(milliseconds: 100));
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(
        child: Stack(
          children: [
            ScaleTransition(scale: ani1, child: moon(140)),

            FadeTransition(
              opacity: ani2,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: .new(0, .2),
                  end: .zero,
                ).animate(ani2),
                child: cloud(),
              ),
            ),

            Center(
              child: Column(
                children: [
                  Spacer(flex: 2),

                  FadeTransition(
                    opacity: ani3,
                    child: RotationTransition(
                      turns: Tween(begin: .05, end: 0.0).animate(ani3),
                      child: LogoWidget(title: "운명을 엿볼 시간이에요."),
                    ),
                  ),

                  Spacer(),

                  FadeTransition(
                    opacity: ani4,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: .new(-.4, 0),
                        end: .zero,
                      ).animate(ani4),
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
    );
  }
}
