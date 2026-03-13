import 'dart:math';
import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_6/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '4date_screen.dart';

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
      prevPage: DateScreen(),
      progress: 5,
      isForgot: true,
      child: Column(
        spacing: 28,
        children: [
          SizedBox.shrink(),

          Row(
            mainAxisAlignment: .center,
            spacing: 12,
            children: [
              timeView(appController.timeFormat("hh", time), !minuteMode),
              titleW(":"),
              timeView(appController.timeFormat("mm", time), minuteMode),
              timeToggle(),
            ],
          ),

          clock(),
        ],
      ),
    );
  }

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
        fontSize: 24,
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
            borderRadius: .only(topRight: .circular(8), topLeft: .circular(8)),
            border: .all(
              color: isAm ? Colors.white : Colors.white.withAlpha(100),
            ),
          ),
          padding: .symmetric(horizontal: 12, vertical: 2),
          child: Text(
            "AM",
            style: TextStyle(
              color: isAm ? Colors.white : Colors.white.withAlpha(100),
              fontSize: 14,
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
            borderRadius: .only(
              bottomRight: .circular(8),
              bottomLeft: .circular(8),
            ),
            border: .all(
              color: !isAm ? Colors.white : Colors.white.withAlpha(100),
            ),
          ),
          padding: .symmetric(horizontal: 12, vertical: 2),
          child: Text(
            "PM",
            style: TextStyle(
              color: !isAm ? Colors.white : Colors.white.withAlpha(100),
              fontSize: 14,
              fontWeight: .bold,
            ),
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
                left:
                    center.dx +
                    radius * cos((i * 30 - 90) * pi / 180) -
                    size / 2,
                top:
                    center.dy +
                    radius * sin((i * 30 - 90) * pi / 180) -
                    size / 2,
                child: GestureDetector(
                  onTap: () {
                    angle = ((i * 30 - 90) * pi / 180);
                    index = i;

                    if (!minuteMode) {
                      time = TimeOfDay(hour: i, minute: time.minute);
                      minuteMode = true;
                    } else {
                      time = TimeOfDay(
                        hour: time.hour + (isAm ? 0 : 12),
                        minute: i * 5 % 60,
                      );
                      minuteMode = false;
                      appController.time = time;
                      appController.move(context, CheckScreen());
                    }
                    setState(() {});
                  },
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      shape: .circle,
                      border: .all(
                        color: index == i ? Colors.white : Colors.transparent,
                      ),
                    ),
                    child: Center(child: titleSW("$i")),
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
