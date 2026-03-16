import 'dart:math';

import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/a/4date_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
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

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      isForgot: true,
      title: "태어난 시간을 입력해주세요.",
      pro: 5,
      prevPage: DateScreen(),
      child: Column(
        children: [
          SizedBox(height: 36),

          Row(
            mainAxisAlignment: .center,
            spacing: 12,
            children: [
              timeView(appController.timeFormat("hh", time), !isMinute),
              title24W(":"),
              timeView(appController.timeFormat("mm", time), isMinute),
              timeToggle(),
            ],
          ),

          SizedBox(height: 32),

          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: .all(color: Colors.white),
              shape: .circle,
            ),
            child: LayoutBuilder(
              builder: (context, cst) {
                final center = Offset(cst.maxWidth / 2, cst.maxHeight / 2);
                final radius = cst.maxHeight / 2 - 15;

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
                            decoration: BoxDecoration(
                              shape: .circle,
                              border: index == i
                                  ? .all(color: Colors.white)
                                  : null,
                            ),
                            child: Center(child: title18W("$i")),
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
            border: .all(
              color: isAm ? Colors.white : Colors.white.withAlpha(100),
            ),
            borderRadius: .only(
              topRight: .circular(16),
              topLeft: .circular(16),
            ),
          ),
          padding: .symmetric(horizontal: 8, vertical: 2),
          child: title16W(
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
              bottomRight: .circular(16),
              bottomLeft: .circular(16),
            ),
          ),
          padding: .symmetric(horizontal: 8, vertical: 2),
          child: title16W(
            "PM",
            color: !isAm ? Colors.white : Colors.white.withAlpha(100),
          ),
        ),
      ),
    ],
  );

  final double size = 32;
  int index = 12;
  double angle = -pi / 2;

  Widget timeView(String m, bool isColor) => Container(
    decoration: BoxDecoration(
      borderRadius: .circular(8),
      border: .all(
        color: isColor ? Colors.white.withAlpha(100) : Colors.transparent,
      ),
    ),
    padding: .symmetric(horizontal: 12, vertical: 4),
    child: title24W(
      size: 28,
      m,
      color: isColor ? Colors.white : Colors.white.withAlpha(100),
    ),
  );
}
