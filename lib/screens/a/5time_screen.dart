import 'dart:math';

import 'package:daily_tarot_poc_app_13/app_controller.dart';
import 'package:daily_tarot_poc_app_13/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_13/screens/a/confirm_screen.dart';
import 'package:daily_tarot_poc_app_13/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  TimeOfDay time = appController.time ?? TimeOfDay(hour: 9, minute: 0);

  bool isAm = (appController.time?.hour ?? 9) <= 12;
  bool isMinute = false;
  int value = appController.time?.hourOfPeriod ?? 9;
  final double size = 34;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "태어난 시간을 입력해주세요.",
      prevPage: GenderScreen(),
      count: 5,
      child: Column(
        children: [
          SizedBox(height: 28),

          Row(
            mainAxisAlignment: .center,
            spacing: 10,
            children: [
              timeView(appController.timeFormat("hh", time), !isMinute),
              titleW(":", size: 28),
              timeView(appController.timeFormat("mm", time), isMinute),
              timeToggle(),
            ],
          ),

          SizedBox(height: 32),

          Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: .circle,
              border: .all(color: Colors.white, width: 1.6),
            ),
            child: Stack(
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
                  top: 85,
                  left: 85,
                  child: Transform.rotate(
                    angle: (value * 30 - 90) * pi / 180,
                    alignment: .centerLeft,
                    child: Container(
                      color: Colors.white,
                      width: 85 - size,
                      height: 1.2,
                    ),
                  ),
                ),

                for (int i = 1; i <= 12; i++) ...{
                  Positioned(
                    left:
                        85 +
                        (85 - size / 2) * cos((i * 30 - 90) * pi / 180) -
                        size / 2,
                    top:
                        85 +
                        (85 - size / 2) * sin((i * 30 - 90) * pi / 180) -
                        size / 2,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          value = i;

                          if (!isMinute) {
                            time = TimeOfDay(hour: i, minute: time.minute);
                            isMinute = true;
                          } else {
                            appController.time = TimeOfDay(
                              hour: time.hour + (isAm ? 0 : 12),
                              minute: i * 5 % 60,
                            );
                            appController.go(context, ConfirmScreen());
                          }

                          setState(() {});
                        },
                        child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: .circle,
                            border: .all(
                              color: value == i
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                          ),
                          alignment: .center,
                          child: titleW("$i", size: 18),
                        ),
                      ),
                    ),
                  ),
                },
              ],
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
            border: .all(color: isAm ? Colors.white : Colors.white54),
            borderRadius: .only(
              topRight: .circular(14),
              topLeft: .circular(14),
            ),
          ),
          padding: .symmetric(vertical: 2, horizontal: 7),
          child: titleW(
            "AM",
            color: isAm ? Colors.white : Colors.white54,
            size: 14,
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
            border: .all(color: !isAm ? Colors.white : Colors.white54),
            borderRadius: .only(
              bottomRight: .circular(14),
              bottomLeft: .circular(14),
            ),
          ),
          padding: .symmetric(vertical: 2, horizontal: 7),
          child: titleW(
            "PM",
            color: !isAm ? Colors.white : Colors.white54,
            size: 14,
          ),
        ),
      ),
    ],
  );

  Widget timeView(String m, bool isColor) => Container(
    decoration: BoxDecoration(
      border: .all(
        color: isColor ? Colors.white54 : Colors.transparent,
        width: 1.2,
      ),
      borderRadius: .circular(14),
    ),
    padding: .symmetric(horizontal: 13, vertical: 4),
    child: titleW(m, size: 28),
  );
}
