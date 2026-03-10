import 'dart:math';

import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/screens/birth_date_input_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/comfirm_info_screen.dart';

import 'package:daily_tarot_poc_app_2/widgets/base_input_page.dart';
import 'package:daily_tarot_poc_app_2/widgets/button_2.dart';
import 'package:flutter/material.dart';

class BirthTimeInputScreen extends StatefulWidget {
  const BirthTimeInputScreen({super.key});

  @override
  State<BirthTimeInputScreen> createState() => _BirthTimeInputScreenState();
}

class _BirthTimeInputScreenState extends State<BirthTimeInputScreen> {
  void submit() {
    int hour = time.hourOfPeriod;
    if (hour < 12 && isPm) hour += 12;
    if (hour == 12) hour = 0;
    appController.birthTime = TimeOfDay(hour: hour, minute: time.minute);
    appController.move(context, ConfirmInfoScreen());
  }

  TimeOfDay time = TimeOfDay(hour: 0, minute: 0);
  bool isPm = false;

  bool isMinuteMode = false;

  @override
  Widget build(BuildContext context) {
    return BaseInputPage(
      title: "태어난 시간을 입력해주세요.",
      prevPage: BirthDateInputScreen(),
      count: 5,
      expandButton: Button2(
        tap: () {
          appController.birthTime = null;
          appController.move(context, ConfirmInfoScreen());
        },
        text: "잘 모르겠어요",
      ),
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            spacing: 12,
            children: [
              _timeView(appController.timeFormat("hh", time), !isMinuteMode),
              Text(
                ":",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: .bold,
                ),
              ),
              _timeView(appController.timeFormat("mm", time), isMinuteMode),
              _timeToggle(),
            ],
          ),
          SizedBox(height: 24),
          _clock(),
        ],
      ),
    );
  }

  Widget _timeToggle() => Column(
    children: [
      GestureDetector(
        onTap: () {
          setState(() {
            isPm = false;
          });
        },
        child: Container(
          padding: .symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: .only(
              topRight: .circular(12),
              topLeft: .circular(12),
            ),
            border: .all(
              color: !isPm ? Colors.white : Colors.white.withAlpha(100),
            ),
          ),
          child: Text(
            "AM",
            style: TextStyle(
              color: !isPm ? Colors.white : Colors.white.withAlpha(100),
              fontWeight: .bold,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            isPm = true;
          });
        },
        child: Container(
          padding: .symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: .only(
              bottomLeft: .circular(12),
              bottomRight: .circular(12),
            ),
            border: .all(
              color: isPm ? Colors.white : Colors.white.withAlpha(100),
            ),
          ),
          child: Text(
            "PM",
            style: TextStyle(
              color: isPm ? Colors.white : Colors.white.withAlpha(100),
              fontWeight: .bold,
            ),
          ),
        ),
      ),
    ],
  );

  Widget _timeView(String time, bool isFocus) => Container(
    decoration: BoxDecoration(
      border: .all(color: isFocus ? Colors.white : Colors.transparent),
      borderRadius: .circular(16),
    ),
    padding: .symmetric(horizontal: 18, vertical: 10),
    child: Text(
      time,
      style: TextStyle(
        color: isFocus ? Colors.white : Colors.white.withAlpha(100),
        fontSize: 28,
        fontWeight: .bold,
      ),
    ),
  );

  Widget _clock() => SizedBox.square(
    dimension: 200,
    child: Container(
      decoration: BoxDecoration(
        shape: .circle,
        border: .all(color: Colors.white),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final center = Offset(
            constraints.maxWidth / 2,
            constraints.maxHeight / 2,
          );
          final radius = constraints.maxWidth / 2 - 15;

          return Stack(
            children: [
              ...List.generate(
                12,
                (index) => _timeItem(index + 1, index, center, radius, () {
                  if (!isMinuteMode) {
                    time = TimeOfDay(hour: index + 1, minute: time.minute);
                    isMinuteMode = true;
                  } else {
                    time = TimeOfDay(hour: time.hour, minute: index * 5);
                    submit();
                  }
                }),
              ),

              Positioned(
                top: center.dy - itemSize / 2,
                left: center.dx,
                child: IgnorePointer(
                  child: Transform.rotate(
                    angle: curAngle,
                    alignment: .centerLeft,
                    child: Row(
                      children: [
                        Container(
                          color: Colors.white,
                          height: 1,
                          width: radius - itemSize / 2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: .all(color: Colors.white),
                            shape: .circle,
                          ),
                          child: SizedBox.square(dimension: itemSize),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: Center(
                  child: CircleAvatar(backgroundColor: Colors.white, radius: 3),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );

  final double itemSize = 38;
  double curAngle = 0;

  Widget _timeItem(
    int value,
    int index,
    Offset center,
    double radius,
    VoidCallback tap,
  ) {
    final angle = (index * 30 + 30) * pi / 180 - pi / 2;

    final x = center.dx + radius * cos(angle);
    final y = center.dy + radius * sin(angle);

    return Positioned(
      top: y - itemSize / 2,
      left: x - itemSize / 2,
      child: GestureDetector(
        onTap: () {
          setState(() {
            curAngle = angle;
            tap.call();
          });
        },
        child: SizedBox.square(
          dimension: itemSize,
          child: Center(
            child: Text(
              "$value",
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
