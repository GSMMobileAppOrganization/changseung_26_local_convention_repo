import 'dart:math';

import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/base_input_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/check_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/date_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_a/gender_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  TimeOfDay time = TimeOfDay(hour: 12, minute: 0);

  bool isAm = false;
  bool minuteMode = false;

  @override
  Widget build(BuildContext context) {
    return BaseInputScreen(
      isForgot: true,
      title: "태어난 시간을 입력해주세요.",
      progress: 4,
      prevPage: DateScreen(),
      child: Column(
        children: [
          Row(
            spacing: 12,
            mainAxisAlignment: .center,
            children: [
              timeView(appController.timeFormat("hh", time), !minuteMode),
              Text(
                ":",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: .bold,
                ),
              ),
              timeView(appController.timeFormat("mm", time), minuteMode),

              toggle(),
            ],
          ),

          SizedBox(height: 32),

          clock(),
        ],
      ),
    );
  }

  Widget toggle() => Column(
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
          padding: .symmetric(horizontal: 12, vertical: 4),
          child: Text(
            "AM",
            style: TextStyle(
              color: isAm ? Colors.white : Colors.white.withAlpha(100),
              fontWeight: .bold,
              fontSize: 16,
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
          padding: .symmetric(horizontal: 12, vertical: 4),
          child: Text(
            "PM",
            style: TextStyle(
              color: !isAm ? Colors.white : Colors.white.withAlpha(100),
              fontWeight: .bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ],
  );

  final double size = 32;
  double angle = -pi / 2;
  int index = 12;

  Widget clock() => Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      shape: .circle,
      border: .all(color: Colors.white),
    ),
    child: LayoutBuilder(
      builder: (context, cst) {
        final Offset center = Offset(cst.maxWidth / 2, cst.maxHeight / 2);
        final radius = cst.maxWidth / 2 - 15;
        return Stack(
          children: [
            Positioned.fill(
              left: center.dx - size,
              child: Center(
                child: Transform.rotate(
                  angle: angle,
                  alignment: .centerLeft,
                  child: Container(
                    color: Colors.white,
                    width: radius - size / 2,
                    height: 1,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: CircleAvatar(backgroundColor: Colors.white, radius: 3),
              ),
            ),

            for (int i = 1; i <= 12; i++) ...{
              Positioned(
                left:
                    center.dx +
                    radius * cos((i * 30 - 90) * (pi / 180)) -
                    size / 2,
                top:
                    center.dy +
                    radius * sin((i * 30 - 90) * (pi / 180)) -
                    size / 2,
                child: GestureDetector(
                  onTap: () {
                    angle = (i * 30 - 90) * (pi / 180);
                    index = i;

                    if (!minuteMode) {
                      time = TimeOfDay(hour: i, minute: time.minute);
                      minuteMode = true;
                    } else {
                      time = TimeOfDay(hour: time.hour + (isAm ? 0 : 12), minute: i * 5 % 60);
                      minuteMode = false;
                      appController.birthTime = time;
                      appController.move(context, CheckScreen());
                    }

                    setState(() {});
                  },
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      border: .all(
                        color: index == i ? Colors.white : Colors.transparent,
                      ),
                      shape: .circle,
                    ),
                    child: Center(
                      child: Text(
                        "$i",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: .bold,
                          fontSize: 18,
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
      border: .all(color: isColor ? Colors.white : Colors.white.withAlpha(100)),
      borderRadius: .circular(18),
    ),
    padding: .symmetric(horizontal: 18, vertical: 12),
    child: Text(
      m,
      style: TextStyle(
        color: isColor ? Colors.white : Colors.white.withAlpha(100),
        fontSize: 24,
        fontWeight: .bold,
      ),
    ),
  );
}
