import 'dart:math';

import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/screens/birth_date_input_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/base_input_page.dart';
import 'package:daily_tarot_poc_app_1/screens/confrim_info_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthTimeInputScreen extends StatefulWidget {
  const BirthTimeInputScreen({super.key});

  @override
  State<BirthTimeInputScreen> createState() => _BirthTimeInputScreenState();
}

class _BirthTimeInputScreenState extends State<BirthTimeInputScreen> {
  bool isMinuteMode = false;

  TimeOfDay time = appController.birthTime == null
      ? .now()
      : appController.birthTime!;

  bool isAm =
      appController.birthTime == null || appController.birthTime!.hour <= 12;

  void _submit() {
    int hour = time.hourOfPeriod;
    if (hour < 12 && !isAm) hour += 12;
    if (hour == 12) hour = 0;

    appController.birthTime = TimeOfDay(hour: hour, minute: time.minute);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfirmInfoScreen()),
    );
    isMinuteMode = false;
  }

  @override
  Widget build(BuildContext context) {
    return BaseInputPage(
      prevPage: BirthDateInputScreen(),
      title: "태어난 시간을 입력해주세요.",
      count: 5,
      expandButton: Button2(
        text: "잘 모르겠어요",
        reverse: true,
        tap: () {
          appController.birthTime = null;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConfirmInfoScreen()),
          );
        },
      ),
      child: Column(
        children: [
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: .center,
            spacing: 16,
            children: [
              _timeView("hh", !isMinuteMode),
              Text(":", style: TextStyle(color: Colors.white, fontSize: 24)),
              _timeView("mm", isMinuteMode),
              _toggleButton(),
            ],
          ),

          SizedBox(height: 32),

          _clock(),
        ],
      ),
    );
  }

  Widget _toggleButton() => Column(
    children: [
      GestureDetector(
        onTap: () {
          setState(() {
            isAm = true;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: .all(
              color: isAm ? Colors.white : Colors.white.withAlpha(100),
            ),
            borderRadius: .only(
              topRight: .circular(12),
              topLeft: .circular(12),
            ),
          ),
          padding: .symmetric(horizontal: 10, vertical: 4),
          child: Text(
            "AM",
            style: TextStyle(
              color: isAm ? Colors.white : Colors.white.withAlpha(100),
              fontWeight: .bold,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            isAm = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: .only(
              bottomLeft: .circular(12),
              bottomRight: .circular(12),
            ),
            border: .all(
              color: !isAm ? Colors.white : Colors.white.withAlpha(100),
            ),
          ),
          padding: .symmetric(horizontal: 10, vertical: 4),
          child: Text(
            "PM",
            style: TextStyle(
              color: !isAm ? Colors.white : Colors.white.withAlpha(100),
              fontWeight: .bold,
            ),
          ),
        ),
      ),
    ],
  );

  Widget _timeView(String format, bool isColor) => Container(
    decoration: BoxDecoration(
      borderRadius: .circular(12),
      border: .all(color: isColor ? Colors.white : Colors.white.withAlpha(100)),
    ),
    alignment: .center,
    padding: .symmetric(horizontal: 16, vertical: 8),
    child: Text(
      DateFormat(format).format(DateTime(0, 0, 0, time.hour, time.minute)),
      style: TextStyle(
        color: isColor ? Colors.white : Colors.white.withAlpha(100),
        fontSize: 24,
      ),
    ),
  );

  final double itemSize = 30;
  double curAngle = 0;

  Widget _clock() => SizedBox.square(
    dimension: 200,
    child: Container(
      decoration: BoxDecoration(
        shape: .circle,
        border: .all(color: Colors.white),
      ),
      alignment: .center,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final center = Offset(
            constraints.maxWidth / 2,
            constraints.maxHeight / 2,
          );
          final radius = constraints.maxWidth / 2 - 15;
          return Stack(
            children: [
              ...!isMinuteMode
                  ? List.generate(
                      12,
                      (index) =>
                          _timeItem(index + 1, index, center, radius, () {
                            time = TimeOfDay(
                              hour: index + 1,
                              minute: time.minute,
                            );
                            isMinuteMode = true;
                          }),
                    )
                  : List.generate(
                      12,
                      (index) => _timeItem(
                        index * 5,
                        index,
                        center,
                        radius,
                        () {
                          time = TimeOfDay(hour: time.hour, minute: index * 5);
                          _submit();
                        },
                      ),
                    ),

              Positioned(
                left: center.dx,
                top: center.dy - itemSize / 2,
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
                      IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: .circle,
                            border: .all(color: Colors.white),
                          ),
                          child: SizedBox.square(dimension: itemSize),
                        ),
                      ),
                    ],
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

  Widget _timeItem(
    int value,
    int index,
    Offset center,
    double radius,
    VoidCallback tap,
  ) {
    final angle = (index * 30 + 30) * (pi / 180) - pi / 2;

    final x = center.dx + radius * cos(angle);
    final y = center.dy + radius * sin(angle);

    return Positioned(
      left: x - itemSize / 2,
      top: y - itemSize / 2,
      child: GestureDetector(
        onTap: () => setState(() {
          curAngle = angle;
          tap.call();
        }),
        child: SizedBox.square(
          dimension: itemSize,
          child: Center(
            child: Text(
              "$value",
              style: TextStyle(
                fontWeight: .bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
