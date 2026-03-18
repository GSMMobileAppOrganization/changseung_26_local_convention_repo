import 'dart:math';

import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/date_screen.dart';
import 'package:daily_tarot_poc_app_8/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
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
      title: "태어난 시간을 입력해주세요.",
      prevPage: DateScreen(),
      progress: 5,
      child: Column(
        children: [
          SizedBox(height: 32),

          Row(
            spacing: 12,
            mainAxisAlignment: .center,
            children: [
              timeView(appController.timeFormat("hh", time), !minuteMode),
              titleW(":"),
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
              topLeft: .circular(12),
              topRight: .circular(12),
            ),
          ),
          padding: .symmetric(horizontal: 8, vertical: 2),
          child: titleSW(
            "AM",
            color: isAm ? Colors.white : Colors.white.withAlpha(100),
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
          padding: .symmetric(horizontal: 8, vertical: 2),
          child: titleSW(
            "PM",
            color: !isAm ? Colors.white : Colors.white.withAlpha(100),
          ),
        ),
      ),
    ],
  );

  double angle = -pi / 2;
  int index = 12;
  final double size = 32;

  Widget clock() => Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      shape: .circle,
      border: .all(color: Colors.white),
    ),
    child: LayoutBuilder(
      builder: (context, cst) {
        final center = Offset(cst.maxWidth / 2, cst.maxHeight / 2);
        final radius = cst.maxWidth / 2 - 15;

        return Stack(
          children: [
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
                  color: Colors.white,
                  height: 2,
                  width: radius - size / 2,
                ),
              ),
            ),

            for (int i = 1; i <= 12; i++) ...{
              Positioned(
                top:
                    center.dy +
                    radius * sin((i * 30 - 90) * pi / 180) -
                    size / 2,
                left:
                    center.dx +
                    radius * cos((i * 30 - 90) * pi / 180) -
                    size / 2,
                child: Center(
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
                        appController.go(context, CheckScreen());
                      }
                      setState(() {});
                    },
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: .circle,
                        border: .all(
                          color: index == i ? Colors.white : Colors.transparent,
                        ),
                      ),
                      alignment: .center,
                      child: titleMW("$i"),
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
    child: titleW(
      m,
      color: isColor ? Colors.white : Colors.white.withAlpha(100),
    ),
  );
}
