import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget cardWidget(String? path, double size) => Container(
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(borderRadius: .circular(8)),
  child: Image.asset(
    path ?? "assets/images/tarot_card_back.png",
    fit: .fitWidth,
    width: size,
  ),
);

Widget backButton(BuildContext context) => Align(
  alignment: .topLeft,
  child: GestureDetector(
    onTap: () {
      appController.back(context, HomeScreen());
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: back(24),
    ),
  ),
);

Widget moonCount(double size) => Row(
  mainAxisSize: .min,
  spacing: 4,
  children: [
    moon(size * 1.4),
    titleW("${appController.moon}", size: size, isF2: true),
  ],
);

Widget outlineButton(String m, VoidCallback tap) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      border: .all(color: Colors.white54, width: 1.2),
    ),
    alignment: .centerLeft,
    padding: .symmetric(vertical: 13, horizontal: 24),
    child: titleW(size: 15, m, isF2: true, color: Colors.white.withAlpha(240)),
  ),
);

Widget listWheel(List<int> list, Function(int value) change, int init) => Stack(
  children: [
    Positioned.fill(
      top: 60,
      child: Center(
        child: Container(color: Colors.white, width: 24, height: 1.6),
      ),
    ),
    Positioned.fill(
      bottom: 60,
      child: Center(
        child: Container(color: Colors.white, width: 24, height: 1.6),
      ),
    ),

    ListWheelScrollView.useDelegate(
      itemExtent: 60,
      controller: FixedExtentScrollController(initialItem: init),
      diameterRatio: 15,
      overAndUnderCenterOpacity: .6,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      childDelegate: ListWheelChildLoopingListDelegate(
        children: list
            .map(
              (e) => Center(
                child: titleW(
                  appController.numberFormat("00", e),
                  size: 22,
                  color: Colors.white,
                ),
              ),
            )
            .toList(),
      ),
    ),
  ],
);

Widget genderButton(
  bool isMale,
  VoidCallback tap, {
  bool isCircle = false,
  double pad = 8,
  double size = 52,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(isCircle ? 99 : 16),
      border: .all(color: Colors.white54, width: 1.6),
    ),
    padding: .all(pad),
    child: SvgPicture.asset(
      isMale
          ? "assets/icons/male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg"
          : "assets/icons/female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg",
      fit: .fitWidth,
      width: size,
    ),
  ),
);

Widget background({required Widget child}) => Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [purple, deepPurple],
      begin: .topCenter,
      end: .bottomCenter,
    ),
  ),
  child: child,
);

Widget button1(String m, VoidCallback tap, {bool hasIcon = true}) =>
    GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(32),
          gradient: RadialGradient(
            colors: [grad, purple],
            center: .topLeft,
            radius: 2.2,
          ),
          boxShadow: [
            BoxShadow(
              color: grad.withAlpha(100),
              offset: .new(0, 8),
              blurRadius: 16,
            ),
          ],
        ),
        padding: .symmetric(vertical: 16),
        alignment: .center,
        child: Row(
          mainAxisSize: .min,
          spacing: 4,
          children: [
            titleW(m),
            if (hasIcon) Transform.flip(flipX: true, child: back(22)),
          ],
        ),
      ),
    );

Widget button2(
  String m,
  VoidCallback tap, {
  bool isBack = true,
  bool hasIcon = true,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      color: Colors.white.withAlpha(20),
    ),
    padding: .symmetric(vertical: 14),
    alignment: .center,
    child: Row(
      mainAxisSize: .min,
      spacing: 4,
      children: [
        if (isBack && hasIcon) back(26),
        titleW(m, isF2: true),
        if (!isBack && hasIcon) Transform.flip(flipX: true, child: back(22)),
      ],
    ),
  ),
);

Widget back(double size) => SizedBox.square(
  dimension: size,
  child: SvgPicture.asset(
    "assets/icons/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg",
    fit: .cover,
  ),
);

Widget titleW(
  String m, {
  double size = 16,
  FontWeight weight = .bold,
  Color? color,
  double? height,
  bool isF2 = false,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: isF2 ? f2 : null,
    fontWeight: weight,
    fontSize: size,
  ),
  textAlign: align,
);

Widget moon(double size) => SizedBox(
  height: size * .7,
  width: size,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: Image.asset("assets/images/moon.png", fit: .fitWidth),
  ),
);

Widget moon2(int index) => Stack(
  children: [
    if (index >= 2)
      Positioned.fill(
        child: Align(alignment: .topRight, child: moon(26)),
      ),
    if (index >= 4)
      Positioned.fill(
        child: Align(alignment: .bottomRight, child: moon(12)),
      ),
    moon(46),
  ],
);

Widget cloud() => Stack(
  children: [
    Positioned(
      right: -24,
      bottom: 72,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -36,
      bottom: 36,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      right: -96,
      bottom: 24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -24,
      bottom: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      right: 0,
      bottom: -36,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
  ],
);
