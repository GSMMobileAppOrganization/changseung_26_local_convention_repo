import 'dart:math';

import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:daily_tarot_poc_app_4/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/date_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/name_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/background1.dart';
import 'package:daily_tarot_poc_app_4/widgets/input_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  TimeOfDay time = TimeOfDay(hour: 12, minute: 0);

  bool isAm = true;
  bool minuteMode = false;

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "태어난 시간을 입력해주세요.",
      progress: 5,
      prevPage: DateScreen(),
      isForgot: true,
      child: Column(
        children: [
          SizedBox(height: 34),

          Row(
            mainAxisAlignment: .center,
            spacing: 12,
            children: [
              timeView(appController.timeFormat("hh", time), !minuteMode),
              Text(
                ":",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .bold,
                  fontSize: 24,
                ),
              ),
              timeView(appController.timeFormat("mm", time), minuteMode),

              timeToggle(),
            ],
          ),

          SizedBox(height: 38),

          clock(),
        ],
      ),
    );
  }

  Widget timeToggle() => Column(
    children: [
      GestureDetector(
        onTap: () {
          isAm = false;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            border: .all(
              color: isAm ? Colors.white : Colors.white.withAlpha(100),
            ),
            borderRadius: .only(
              topRight: .circular(16),
              topLeft: .circular(16),
            ),
          ),
          padding: .symmetric(horizontal: 10, vertical: 2),
          child: Text(
            "AM",
            style: TextStyle(
              color: isAm ? Colors.white : Colors.white.withAlpha(100),
              fontWeight: .bold,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          isAm = false;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            border: .all(
              color: !isAm ? Colors.white : Colors.white.withAlpha(100),
            ),
            borderRadius: .only(
              bottomRight: .circular(16),
              bottomLeft: .circular(16),
            ),
          ),
          padding: .symmetric(horizontal: 10, vertical: 2),
          child: Text(
            "PM",
            style: TextStyle(
              color: !isAm ? Colors.white : Colors.white.withAlpha(100),
              fontWeight: .bold,
            ),
          ),
        ),
      ),
    ],
  );

  Widget timeView(String m, bool isColor) => Container(
    decoration: BoxDecoration(
      border: .all(color: isColor ? Colors.white : Colors.white.withAlpha(100)),
      borderRadius: .circular(12),
    ),
    padding: .symmetric(horizontal: 16, vertical: 10),
    child: Text(
      m,
      style: TextStyle(
        color: isColor ? Colors.white : Colors.white.withAlpha(100),
        fontWeight: .bold,
        fontSize: 24,
      ),
    ),
  );

  double angle = -pi / 2;
  final double size = 32;
  int index = 12;

  Widget clock() => Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      border: .all(color: Colors.white),
      shape: .circle,
    ),
    child: LayoutBuilder(
      builder: (context, cst) {
        final Offset center = Offset(cst.maxWidth / 2, cst.maxHeight / 2);
        final radius = cst.maxWidth / 2 - 15;

        return Stack(
          children: [
            for (var i = 1; i <= 12; i++) ...{
              Positioned.fill(
                child: Center(
                  child: CircleAvatar(backgroundColor: Colors.white, radius: 3),
                ),
              ),

              Positioned(
                top: center.dy,
                left: center.dx,
                child: Transform.rotate(
                  angle: angle,
                  alignment: .centerLeft,
                  child: Container(
                    height: 1,
                    color: Colors.white,
                    width: radius - size / 2,
                  ),
                ),
              ),

              Positioned(
                top:
                    center.dy +
                    radius * sin((i * 30 - 90) * pi / 180) -
                    size / 2,
                left:
                    center.dx +
                    radius * cos((i * 30 - 90) * pi / 180) -
                    size / 2,
                child: GestureDetector(
                  onTap: () {
                    angle = (i * 30 - 90) * pi / 180;
                    index = i;

                    if (!minuteMode) {
                      time = TimeOfDay(hour: i, minute: time.minute);
                      minuteMode = true;
                    } else {
                      appController.time = TimeOfDay(
                        hour: time.hour + (isAm ? 0 : 12),
                        minute: time.minute,
                      );
                      minuteMode = false;
                      appController.move(context, CheckScreen());
                    }

                    setState(() {});
                  },
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      border: i == index ? .all(color: Colors.white) : null,
                      shape: .circle,
                    ),
                    child: Center(
                      child: Text(
                        "$i",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: .bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            },
          ],
        );
      },
    ),
  );
}
