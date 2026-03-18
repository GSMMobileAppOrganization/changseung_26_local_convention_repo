import 'dart:math';

import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  TimeOfDay time = TimeOfDay(hour: 12, minute: 0);
  bool isAm = true;
  bool isMinute = false;

  double angle = -pi / 2;
  int index = 12;
  final double size = 32;

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      isForgot: true,
      prevPage: DateScreen(),
      progress: 5,
      title: "태어난 시간을 입력해주세요.",
      child: Column(
        children: [
          SizedBox(height: 36),

          Row(
            spacing: 12,
            mainAxisAlignment: .center,
            children: [
              timeView(appController.timeFormat("hh", time), !isMinute),
              title24W(":", size: 28, weight: .bold),
              timeView(appController.timeFormat("mm", time), isMinute),
              timeToggle(),
            ],
          ),

          SizedBox(height: 32),

          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              shape: .circle,
              border: .all(color: Colors.white, width: 1.5),
            ),
            child: LayoutBuilder(
              builder: (context, cst) {
                final center = Offset(cst.maxWidth / 2, cst.maxHeight / 2);
                final radius = cst.maxWidth / 2 - 15;

                return Stack(
                  children: [
                    Positioned.fill(
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 4,
                        ),
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
                          height: 1.5,
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
                            center.dy +
                            radius * cos((i * 30 - 90) * pi / 180) -
                            size / 2,
                        child: GestureDetector(
                          onTap: () {
                            angle = (i * 30 - 90) * pi / 180;
                            index = i;

                            if (!isMinute) {
                              time = TimeOfDay(hour: i, minute: time.minute);
                              isMinute = true;
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
                            alignment: .center,
                            decoration: BoxDecoration(
                              shape: .circle,
                              border: .all(
                                color: index == i
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: title18W("$i", weight: .bold),
                          ),
                        ),
                      ),
                    },
                  ],
                );
              },
            ),
          ),
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
            borderRadius: .only(
              topLeft: .circular(12),
              topRight: .circular(12),
            ),
            border: .all(
              color: isAm ? Colors.white : Colors.white54,
              width: 1.5,
            ),
          ),
          padding: .symmetric(horizontal: 10, vertical: 2),
          child: title16W(
            "AM",
            color: isAm ? Colors.white : Colors.white54,
            weight: .bold,
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
              bottomLeft: .circular(12),
              bottomRight: .circular(12),
            ),
            border: .all(
              color: !isAm ? Colors.white : Colors.white54,
              width: 1.5,
            ),
          ),
          padding: .symmetric(horizontal: 10, vertical: 2),
          child: title16W(
            "PM",
            color: !isAm ? Colors.white : Colors.white54,
            weight: .bold,
          ),
        ),
      ),
    ],
  );

  Widget timeView(String m, bool isColor) => Container(
    decoration: BoxDecoration(
      border: .all(
        color: isColor ? Colors.white54 : Colors.transparent,
        width: 1.5,
      ),
      borderRadius: .circular(12),
    ),
    padding: .symmetric(horizontal: 12, vertical: 6),
    child: title24W(
      m,
      size: 28,
      color: isColor ? Colors.white : Colors.white54,
    ),
  );
}
