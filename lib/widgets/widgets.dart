import 'package:daily_tarot_poc_app_13/app_controller.dart';
import 'package:daily_tarot_poc_app_13/main.dart';
import 'package:daily_tarot_poc_app_13/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget cardWidget(String? path, double width) => Container(
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(borderRadius: .circular(8)),
  child: Image.asset(
    path ?? "assets/images/tarot_card_back.png",
    fit: .fitWidth,
    width: width,
  ),
);

Widget backButton(BuildContext context) => Align(
  alignment: .topLeft,
  child: GestureDetector(
    onTap: () => appController.back(context, HomeScreen()),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      child: back(28),
    ),
  ),
);

Widget listWheel(List<int> list, Function(int value) change, int init) => Stack(
  children: [
    Positioned.fill(
      child: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            Container(color: Colors.white30, height: 1.6, width: 14),
            SizedBox(height: 60),
            Container(color: Colors.white30, height: 1.6, width: 14),
          ],
        ),
      ),
    ),
    ListWheelScrollView.useDelegate(
      controller: FixedExtentScrollController(initialItem: init),
      diameterRatio: 15,
      overAndUnderCenterOpacity: .5,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      itemExtent: 60,
      childDelegate: ListWheelChildLoopingListDelegate(
        children: list
            .map(
              (e) => Center(
                child: titleW(
                  appController.numberFormat("00", e),
                  size: 20,
                  isF2: true,
                ),
              ),
            )
            .toList(),
      ),
    ),
  ],
);

Widget button(
  String m,
  VoidCallback tap, {
  bool isBack = true,
  bool hasIcon = true,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      color: Colors.white.withAlpha(16),
    ),
    padding: .symmetric(vertical: 12),
    child: Row(
      mainAxisAlignment: .center,
      spacing: 9,
      children: [
        if (isBack && hasIcon) back(24),
        titleW(m, size: 15, isF2: true),
        if (!isBack && hasIcon) Transform.flip(flipX: true, child: back(24)),
      ],
    ),
  ),
);

Widget startButton(VoidCallback tap) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [grad, accentPurple],
        radius: 2.2,
        center: .topLeft,
      ),
      borderRadius: .circular(32),
      boxShadow: [
        BoxShadow(
          color: grad.withAlpha(60),
          offset: .new(0, 8),
          blurRadius: 16,
        ),
      ],
    ),
    padding: .symmetric(vertical: 16),
    child: Row(
      mainAxisAlignment: .center,
      spacing: 9,
      children: [
        titleW("시작하기", size: 17),
        Transform.flip(flipX: true, child: back(22)),
      ],
    ),
  ),
);

Widget titleW(
  String m, {
  double size = 16,
  FontWeight weight = .bold,
  double? height,
  bool isF2 = false,
  TextAlign align = .start,
  Color? color,
}) => Text(
  m,
  style: TextStyle(
    height: height,
    color: color ?? Colors.white,
    fontFamily: isF2 ? f2 : f1,
    fontSize: size,
    fontWeight: weight,
  ),
  textAlign: align,
);

Widget back(double size, {Color? color}) => SizedBox(
  width: size * .36,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: SvgPicture.asset(
      "assets/icons/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg",
      fit: .fitHeight,
      height: size,
      color: color,
    ),
  ),
);

Widget moon(double size) => SizedBox(
  height: size * .8,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: Image.asset("assets/images/moon.png", fit: .fitWidth, width: size),
  ),
);

Widget cloud() => Stack(
  children: [
    Positioned(
      right: -24,
      bottom: 60,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
    Positioned(
      left: -24,
      bottom: 36,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
    Positioned(
      right: -60,
      bottom: 24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
    Positioned(
      left: -24,
      bottom: -12,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
    Positioned(
      right: 8,
      bottom: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
  ],
);
