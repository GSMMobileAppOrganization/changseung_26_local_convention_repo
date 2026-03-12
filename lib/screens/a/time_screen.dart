import 'dart:math';

import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/screens/a/age_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/date_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/gender_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/a/onboarding_screen.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
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
      isForgot: true,
      title: "태어난 시간을 입력해주세요",
      progress: 5,
      prevPage: DateScreen(),
      child: Column(
        children: [
          SizedBox(height: 32),

          Row(
            mainAxisAlignment: .center,
            spacing: 12,
            children: [
              timeView(appController.timeFormat("hh", time), !minuteMode),
              Text(
                ":",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: .bold,
                ),
              ),
              timeView(appController.timeFormat("mm", time), minuteMode),

              timeToggle(),
            ],
          ),
          SizedBox(height: 32),

          clock(),
        ],
      ),
    );
  }

  final double size = 32;
  double angle = -pi / 2;
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
        final center = Offset(cst.maxWidth / 2, cst.maxWidth / 2);
        final radius = cst.maxWidth / 2 - 15;

        return Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: CircleAvatar(radius: 3, backgroundColor: Colors.white),
              ),
            ),

            Positioned(
              left: center.dx,
              top: center.dy,
              child: Transform.rotate(
                angle: angle,
                alignment: .centerLeft,
                child: Container(
                  color: Colors.white,
                  height: 1,
                  width: radius - size / 2,
                ),
              ),
            ),

            for (var i = 1; i <= 12; i++) ...{
              Positioned(
                top:
                    center.dy +
                    radius * sin((i * 30 - 90) * pi / 180) -
                    (size / 2),
                left:
                    center.dx +
                    radius * cos((i * 30 - 90) * pi / 180) -
                    (size / 2),
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
                        minute: i * 5 % 60,
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
                      shape: .circle,
                      border: index == i ? .all(color: Colors.white) : null,
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

  Widget timeView(String m, bool isColor) => Container(
    decoration: BoxDecoration(
      borderRadius: .circular(12),
      border: .all(color: isColor ? Colors.white : Colors.white.withAlpha(100)),
    ),
    padding: .symmetric(horizontal: 16, vertical: 8),
    child: Text(
      m,
      style: TextStyle(
        color: isColor ? Colors.white : Colors.white.withAlpha(100),
        fontSize: 26,
        fontWeight: .bold,
      ),
    ),
  );

  Widget timeToggle() => Column(
    children: [
      GestureDetector(
        onTap: () {
          isAm = true;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            border: .all(
              color: isAm ? Colors.white : Colors.white.withAlpha(100),
            ),
            borderRadius: .only(
              topRight: .circular(12),
              topLeft: .circular(12),
            ),
          ),
          padding: .symmetric(horizontal: 10, vertical: 2),
          child: Text(
            "AM",
            style: TextStyle(
              color: isAm ? Colors.white : Colors.white.withAlpha(100),
              fontWeight: .bold,
              fontSize: 14,
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
              bottomRight: .circular(12),
              bottomLeft: .circular(12),
            ),
          ),
          padding: .symmetric(horizontal: 10, vertical: 2),
          child: Text(
            "PM",
            style: TextStyle(
              color: !isAm ? Colors.white : Colors.white.withAlpha(100),
              fontWeight: .bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ],
  );
}
