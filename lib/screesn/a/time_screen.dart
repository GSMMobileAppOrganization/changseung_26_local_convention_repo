import 'dart:math';

import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/age_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/check_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/date_screen.dart';
import 'package:daily_tarot_poc_app_7/screesn/a/input_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  TimeOfDay time = appController.time ?? TimeOfDay(hour: 9, minute: 0);

  bool minuteMode = false;
  final double size = 32;
  int angle = appController.time?.hourOfPeriod ?? 9;

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "태어난 시간을 입력해주세요.",
      prevPage: DateScreen(),
      progress: 5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              spacing: 18,
              mainAxisAlignment: .center,
              children: [
                timeView(appController.timeFormat("hh", time), !minuteMode),
                timeView(appController.timeFormat("mm", time), minuteMode),
                timeToggle(),
              ],
            ),
          ),

          clock(),
        ],
      ),
    );
  }

  Widget timeToggle() => Column(
    children: [
      GestureDetector(
        onTap: () {
          appController.isAm = true;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            border: .all(
              color: appController.isAm
                  ? Colors.white
                  : Colors.white.withAlpha(100),
            ),
            borderRadius: .only(
              topLeft: .circular(16),
              topRight: .circular(16),
            ),
          ),
          padding: .symmetric(horizontal: 9, vertical: 2),
          child: title14W(
            "AM",
            size: 15,
            color: appController.isAm
                ? Colors.white
                : Colors.white.withAlpha(100),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          appController.isAm = false;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            border: .all(
              color: !appController.isAm
                  ? Colors.white
                  : Colors.white.withAlpha(100),
            ),
            borderRadius: .only(
              bottomLeft: .circular(16),
              bottomRight: .circular(16),
            ),
          ),
          padding: .symmetric(horizontal: 9, vertical: 2),
          child: title14W(
            "PM",
            size: 15,
            color: !appController.isAm
                ? Colors.white
                : Colors.white.withAlpha(100),
          ),
        ),
      ),
    ],
  );

  Widget clock() {
    final radius = (80 - size / 2);

    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: .circle,
        border: .all(color: Colors.white, width: 1.5),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: CircleAvatar(backgroundColor: Colors.white, radius: 3),
            ),
          ),

          Align(
            alignment: .topCenter,
            child: Transform.rotate(
              angle: (angle * 30) * pi / 180,
              alignment: .bottomCenter,
              child: Container(
                margin: .only(top: 30),
                height: radius - size / 2,
                color: Colors.white,
                width: 2,
              ),
            ),
          ),

          for (int i = 1; i <= 12; i++) ...{
            Positioned(
              top: 80 + radius * sin((i * 30 - 90) * pi / 180) - size / 2,
              left: 80 + radius * cos((i * 30 - 90) * pi / 180) - size / 2,
              child: GestureDetector(
                onTap: () {
                  angle = i;
                  if (!minuteMode) {
                    time = TimeOfDay(hour: i, minute: time.minute);
                    minuteMode = true;
                  } else {
                    appController.time = TimeOfDay(
                      hour: time.hour + (appController.isAm ? 0 : 12),
                      minute: i * 5 % 60,
                    );
                    appController.go(context, CheckScreen());
                  }
                  setState(() {});
                },
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    border: .all(
                      color: angle == i ? Colors.white : Colors.transparent,
                    ),
                    shape: .circle,
                  ),
                  child: Center(child: title16W("$i")),
                ),
              ),
            ),
          },
        ],
      ),
    );
  }

  Widget timeView(String m, bool isColor) => Container(
    decoration: BoxDecoration(
      border: .all(
        color: isColor ? Colors.white54 : Colors.transparent,
        width: 1.2,
      ),
      borderRadius: .circular(12),
    ),
    padding: .symmetric(horizontal: 14, vertical: 4),
    child: title24W(
      m,
      size: 28,
      color: isColor ? Colors.white : Colors.white.withAlpha(100),
    ),
  );
}
