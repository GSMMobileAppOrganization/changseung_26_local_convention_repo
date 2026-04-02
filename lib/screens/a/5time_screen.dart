import 'dart:math';

import 'package:daily_tarot_poc_app_10/app_controller.dart';
import 'package:daily_tarot_poc_app_10/screens/a/3gender_screen.dart';
import 'package:daily_tarot_poc_app_10/screens/a/check_screen.dart';
import 'package:daily_tarot_poc_app_10/screens/a/input_screen.dart';
import 'package:daily_tarot_poc_app_10/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  TimeOfDay time = TimeOfDay(hour: 9, minute: 0);

  int index = 9;
  double angle = -pi;

  bool isAm = false;
  bool isMinute = false;
  final double size = 36;

  @override
  Widget build(BuildContext context) {
    return InputScreen(
      title: "태어난 시간을 입력해주세요.",
      isForgot: true,
      prevPage: GenderScreen(),
      count: 5,
      child: Column(
        children: [
          SizedBox(height: 28),

          Row(
            spacing: 10,
            mainAxisAlignment: .center,
            children: [
              timeView(appController.timeFormat("hh", time), !isMinute),
              title28W(":"),
              timeView(appController.timeFormat("mm", time), isMinute),
              timeToggle(),
            ],
          ),

          SizedBox(height: 26),

          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: .circle,
              border: .all(color: Colors.white, width: 1.6),
            ),
            child: LayoutBuilder(
              builder: (context, cst) {
                final center = Offset(cst.maxWidth / 2, cst.maxHeight / 2);
                final rad = cst.maxWidth / 2 - 15;

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
                          height: 1.6,
                          width: rad - size / 2,
                        ),
                      ),
                    ),

                    for (int i = 1; i <= 12; i++) ...{
                      Positioned(
                        top:
                            center.dy +
                            rad * sin((i * 30 - 90) * pi / 180) -
                            size / 2,
                        left:
                            center.dx +
                            rad * cos((i * 30 - 90) * pi / 180) -
                            size / 2,
                        child: GestureDetector(
                          onTap: () {
                            index = i;
                            angle = (i * 30 - 90) * pi / 180;

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
              color: isAm ? Colors.white : Colors.white54,
              width: 1.5,
            ),
            borderRadius: .only(
              topLeft: .circular(16),
              topRight: .circular(16),
            ),
          ),
          padding: .symmetric(horizontal: 9, vertical: 2),
          child: title18W(
            size: 17,
            "AM",
            color: isAm ? Colors.white : Colors.white54,
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
            border: .fromLTRB(
              left: BorderSide(
                color: !isAm ? Colors.white : Colors.white54,
                width: 1.5,
              ),
              bottom: BorderSide(
                color: !isAm ? Colors.white : Colors.white54,
                width: 1.5,
              ),
              right: BorderSide(
                color: !isAm ? Colors.white : Colors.white54,
                width: 1.5,
              ),
            ),
            borderRadius: .only(
              bottomLeft: .circular(16),
              bottomRight: .circular(16),
            ),
          ),
          padding: .symmetric(horizontal: 9, vertical: 2),
          child: title18W(
            size: 17,
            "PM",
            color: !isAm ? Colors.white : Colors.white54,
          ),
        ),
      ),
    ],
  );

  Widget timeView(String m, bool isColor) => Container(
    decoration: BoxDecoration(
      borderRadius: .circular(12),
      border: .all(
        color: isColor ? Colors.white54 : Colors.transparent,
        width: 1.6,
      ),
    ),
    padding: .symmetric(horizontal: 16, vertical: 6),
    child: title28W(m, color: isColor ? Colors.white : Colors.white54),
  );
}
