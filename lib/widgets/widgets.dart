import 'package:daily_tarot_poc_app_15/app_controller.dart';
import 'package:daily_tarot_poc_app_15/main.dart';
import 'package:daily_tarot_poc_app_15/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget backButton(BuildContext context) => Align(
  alignment: .topLeft,
  child: GestureDetector(
    onTap: () => appController.back(context, HomeScreen()),
    child: Padding(
      padding: const EdgeInsets.only(left: 24, top: 18),
      child: back(28),
    ),
  ),
);

Widget cardWidget(String? path, double width) => Container(
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(borderRadius: .circular(8)),
  child: Image.asset(
    path ?? "assets/images/tarot_card_back.png",
    fit: .fitWidth,
    width: width,
  ),
);

Widget listWheel(List<int> list, Function(int value) change, int init) => Stack(
  children: [
    Positioned.fill(
      child: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            Container(color: Colors.white30, height: 1.2, width: 14),
            SizedBox(height: 60),
            Container(color: Colors.white30, height: 1.2, width: 14),
          ],
        ),
      ),
    ),
    ListWheelScrollView.useDelegate(
      itemExtent: 60,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      diameterRatio: 20,
      overAndUnderCenterOpacity: .5,
      controller: FixedExtentScrollController(initialItem: init),
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

Widget button1(VoidCallback tap, {String m = "시작하기", bool hasIcon = true}) =>
    GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(32),
          gradient: RadialGradient(
            colors: [grad, purple],
            radius: 1.6,
            center: .topLeft,
          ),

          boxShadow: [
            BoxShadow(
              color: grad.withAlpha(80),
              offset: .new(0, 8),
              blurRadius: 16,
            ),
          ],
        ),
        padding: .symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 8,
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
      borderRadius: .circular(32),
      color: Colors.white.withAlpha(16),
    ),
    padding: .symmetric(vertical: 14),
    child: Row(
      mainAxisAlignment: .center,
      spacing: 6,
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
  double? height,
  FontWeight weight = .bold,
  bool isF2 = false,
  TextAlign align = .start,
  Color? color,
}) => Text(
  m,
  textAlign: align,
  style: TextStyle(
    color: color ?? Colors.white,
    fontFamily: isF2 ? f2 : f1,
    height: height,
    fontSize: size,
    fontWeight: weight,
  ),
);

Widget cloud() => Stack(
  children: [
    Positioned(
      bottom: 60,
      right: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
    Positioned(
      bottom: 36,
      left: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
    Positioned(
      bottom: 24,
      right: -64,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
    Positioned(
      bottom: -12,
      left: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
    Positioned(
      bottom: -24,
      right: 0,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
  ],
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
