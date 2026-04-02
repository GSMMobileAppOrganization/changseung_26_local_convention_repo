import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/screens/a/1name_screen.dart';
import 'package:daily_tarot_poc_app_12/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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

    ani1 = CurvedAnimation(parent: _controller, curve: Interval(.0, .3));
    ani2 = CurvedAnimation(parent: _controller, curve: Interval(.4, .5));
    ani3 = CurvedAnimation(parent: _controller, curve: Interval(.6, .8));
    ani4 = CurvedAnimation(parent: _controller, curve: Interval(.9, 1.0));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 200));
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
              ScaleTransition(scale: ani1, child: moon(140)),
              FadeTransition(
                opacity: ani2,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: .new(0, .4),
                    end: .zero,
                  ).animate(ani2),
                  child: cloud(),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Spacer(flex: 3),

                    FadeTransition(
                      opacity: ani3,
                      child: RotationTransition(
                        turns: Tween(begin: .98, end: 1.0).animate(ani3),
                        child: LogoWidget(title: "운명을 엿볼 시간이에요."),
                      ),
                    ),

                    Spacer(flex: 2),
                    FadeTransition(
                      opacity: ani4,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: .new(-.4, 0),
                          end: .zero,
                        ).animate(ani4),
                        child: SizedBox(
                          width: 180,
                          child: button1("시작하기", () {
                            appController.go(context, NameScreen());
                          }),
                        ),
                      ),
                    ),

                    Spacer(flex: 4),
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
