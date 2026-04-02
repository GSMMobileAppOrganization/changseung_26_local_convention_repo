import 'dart:math';

import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/base_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  TimeOfDay time = appController.time ?? TimeOfDay(hour: 9, minute: 0);
  bool isAm = appController.isAm;
  bool isMinuteMode = false;
  double angle = ((appController.time?.hourOfPeriod ?? 9) * 30 - 90) * pi / 180;
  int index = appController.time?.hourOfPeriod ?? 9;
  final double size = 36;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      isForgot: true,
      title: "태어난 시간을 입력해주세요.",
      prevPage: GenderScreen(),
      count: 5,
      child: Column(
        children: [
          SizedBox(height: 36),

          Row(
            mainAxisAlignment: .center,
            spacing: 12,
            children: [
              timeView(appController.timeFormat("hh", time), !isMinuteMode),
              title28W(":"),
              timeView(appController.timeFormat("mm", time), isMinuteMode),

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
              builder: (context, constraints) {
                final center = constraints.maxWidth / 2;
                final radius = constraints.maxWidth / 2 - 16;

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
                      top: center,
                      left: center,
                      child: Transform.rotate(
                        alignment: .centerLeft,
                        angle: angle,
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

                              if (!isMinuteMode) {
                                time = TimeOfDay(hour: i, minute: time.minute);
                                isMinuteMode = true;
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
                              child: title18W("$i"),
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
          appController.saveIsAm(true);
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
          padding: .symmetric(horizontal: 10, vertical: 3),
          child: title14W(
            "AM",
            color: appController.isAm ? Colors.white : Colors.white54,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          appController.saveIsAm(false);
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
          padding: .symmetric(horizontal: 10, vertical: 3),
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
    padding: .symmetric(horizontal: 16, vertical: 6),
    child: title28W(m, color: isColor ? Colors.white : Colors.white54),
  );
}
