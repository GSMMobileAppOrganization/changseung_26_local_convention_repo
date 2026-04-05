import 'package:daily_tarot_poc_app_14/app_controller.dart';
import 'package:daily_tarot_poc_app_14/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/b/home_screen.dart';

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
    onTap: () {
      appController.back(context, HomeScreen());
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 12, left: 24),
      child: back(26),
    ),
  ),
);

Widget listWheel(
  List<int> list,
  Function(int value) change,
  FixedExtentScrollController controller,
) => Stack(
  children: [
    Positioned.fill(
      child: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            Container(color: Colors.white30, width: 14, height: 1.2),
            SizedBox(height: 60),
            Container(color: Colors.white30, width: 14, height: 1.2),
          ],
        ),
      ),
    ),

    ListWheelScrollView.useDelegate(
      diameterRatio: 15,
      overAndUnderCenterOpacity: .6,
      controller: controller,
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
                  size: 22,
                  isF2: true,
                ),
              ),
            )
            .toList(),
      ),
    ),
  ],
);

Widget button1(VoidCallback tap, {String m = "시작하기", bool hasIcon = true}) =>
    GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [grad, purple],
            center: .topLeft,
            radius: 1.7,
          ),
          borderRadius: .circular(32),
          boxShadow: [
            BoxShadow(
              color: grad.withAlpha(80),
              offset: .new(0, 8),
              blurRadius: 16,
            ),
          ],
        ),
        alignment: .center,
        padding: .symmetric(vertical: 16),
        child: Row(
          spacing: 10,
          mainAxisSize: .min,
          children: [
            titleW(m, size: 17),
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
      color: Colors.white.withAlpha(16),
      borderRadius: .circular(32),
    ),
    alignment: .center,
    padding: .symmetric(vertical: 14),
    child: Row(
      spacing: 10,
      mainAxisSize: .min,
      children: [
        if (isBack && hasIcon) back(24),
        titleW(m, size: 15, isF2: true),
        if (!isBack && hasIcon) Transform.flip(flipX: true, child: back(24)),
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
    color: color ?? Colors.white,
    fontFamily: isF2 ? f2 : f1,
    fontSize: size,
    height: height,
    fontWeight: weight,
  ),
  textAlign: align,
);

Widget moon(double size) => SizedBox(
  height: size * .8,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: Image.asset("assets/images/moon.png", fit: .fitWidth, width: size),
  ),
);

Widget back(double size, {Color? color}) => SizedBox(
  width: size * .38,
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
      right: -8,
      bottom: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
  ],
);
