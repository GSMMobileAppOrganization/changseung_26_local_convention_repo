import 'dart:math';

import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_11/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  TimeOfDay time = appController.time ?? TimeOfDay(hour: 9, minute: 0);

  bool isMinute = false;

  final double size = 36;
  double angle = ((appController.time?.hourOfPeriod ?? 9) * 30 - 90) * pi / 180;
  int index = (appController.time?.hourOfPeriod ?? 9);

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      isForgot: true,
      title: "태어난 시간을 입력해주세요.",
      prevPage: GenderScreen(),
      count: 5,
      child: Column(
        children: [
          SizedBox(height: 28),

          Row(
            mainAxisAlignment: .center,
            spacing: 12,
            children: [
              timeView(appController.timeFormat("hh", time), !isMinute),
              title28W(":"),
              timeView(appController.timeFormat("mm", time), isMinute),
              timeToggle(),
            ],
          ),

          SizedBox(height: 32),

          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: .circle,
              border: .all(color: Colors.white, width: 1.6),
            ),
            child: LayoutBuilder(
              builder: (context, cst) {
                final center = cst.maxWidth / 2;
                final radius = center - 15;

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
                      left: center,
                      top: center,
                      child: Transform.rotate(
                        angle: angle,
                        alignment: .centerLeft,
                        child: Container(
                          color: Colors.white,
                          width: radius - size / 2,
                          height: 1.6,
                        ),
                      ),
                    ),

                    for (int i = 1; i <= 12; i++) ...{
                      Positioned(
                        left:
                            center +
                            radius * cos((i * 30 - 90) * pi / 180) -
                            size / 2,
                        top:
                            center +
                            radius * sin((i * 30 - 90) * pi / 180) -
                            size / 2,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              index = i;
                              angle = (i * 30 - 90) * pi / 180;

                              if (!isMinute) {
                                time = TimeOfDay(hour: i, minute: time.minute);
                                isMinute = true;
                              } else {
                                appController.saveTime(
                                  TimeOfDay(
                                    hour:
                                        time.hour +
                                        (appController.isAm ? 0 : 12),
                                    minute: i * 5 % 60,
                                  ),
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
                                  color: index == i
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 1.6,
                                ),
                              ),
                              alignment: .center,
                              child: titleW("$i"),
                            ),
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
          appController.isAm = true;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            border: .all(
              color: appController.isAm ? Colors.white : Colors.white54,
            ),
            borderRadius: .only(
              topLeft: .circular(16),
              topRight: .circular(16),
            ),
          ),
          padding: .symmetric(horizontal: 9, vertical: 3),
          child: title14W(
            "AM",
            color: appController.isAm ? Colors.white : Colors.white54,
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
              color: !appController.isAm ? Colors.white : Colors.white54,
            ),
            borderRadius: .only(
              bottomRight: .circular(16),
              bottomLeft: .circular(16),
            ),
          ),
          padding: .symmetric(horizontal: 9, vertical: 3),
          child: title14W(
            "PM",
            color: !appController.isAm ? Colors.white : Colors.white54,
          ),
        ),
      ),
    ],
  );

  Widget timeView(String m, bool isColor) => Container(
    decoration: BoxDecoration(
      borderRadius: .circular(16),
      border: .all(
        color: isColor ? Colors.white54 : Colors.transparent,
        width: 1.6,
      ),
    ),
    padding: .symmetric(vertical: 6, horizontal: 16),
    child: title28W(m, color: isColor ? Colors.white : Colors.white54),
  );
}
