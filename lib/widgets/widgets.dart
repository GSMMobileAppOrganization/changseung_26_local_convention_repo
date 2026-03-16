import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget moonCount(double size) => Row(
  mainAxisSize: .min,
  spacing: 4,
  children: [
    moon(size),
    title16W("${appController.moon}", size: size * .7, font: f2),
  ],
);

Widget outButton(String m, VoidCallback tap) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      border: .all(color: Colors.white),
    ),
    alignment: .centerLeft,
    padding: .symmetric(vertical: 14, horizontal: 24),
    child: title16W(m, font: f2),
  ),
);

Widget listWheel(List<int> list, Function(int value) change) => Stack(
  children: [
    Positioned.fill(
      child: Align(
        alignment: Alignment(0, -.2),
        child: Container(color: Colors.white, height: 1, width: 14),
      ),
    ),
    Positioned.fill(
      child: Align(
        alignment: Alignment(0, .2),
        child: Container(color: Colors.white, height: 1, width: 14),
      ),
    ),

    ListWheelScrollView.useDelegate(
      itemExtent: 72,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      childDelegate: ListWheelChildLoopingListDelegate(
        children: list
            .map(
              (e) => Center(
                child: title20W(appController.numberFormat("00", e), font: f2),
              ),
            )
            .toList(),
      ),
    ),
  ],
);

Widget genderButton(bool isMale, VoidCallback tap, {bool isCircle = false}) =>
    GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(isCircle ? 99 : 16),
          border: .all(color: Colors.white),
        ),
        alignment: .center,
        padding: .all(isCircle ? 8 : 12),
        child: SvgPicture.asset(
          isMale ? "assets/icons/male.svg" : "assets/icons/female.svg",
        ),
      ),
    );

Widget input(String m, Function(String m) sub) => TextField(
  decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.5),
      borderRadius: .circular(32),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white.withAlpha(160), width: 1.5),
      borderRadius: .circular(32),
    ),
    contentPadding: .symmetric(horizontal: 24, vertical: 14),
    hint: title16W(
      m,
      font: f2,
      weight: .w500,
      color: Colors.white.withAlpha(160),
    ),
  ),
  style: TextStyle(color: Colors.white, fontFamily: f2, fontWeight: .w500),
  onSubmitted: sub,
);

Widget button1(String m, VoidCallback tap, {double radius = 2}) =>
    GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [grad, purple],
            center: .topLeft,
            radius: radius,
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
          mainAxisSize: .min,
          spacing: 6,
          children: [
            title16W(m),
            Transform.flip(flipX: true, child: back(24)),
          ],
        ),
      ),
    );

Widget button2(String m, VoidCallback tap, {bool isBack = true}) =>
    GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(32),
          color: Colors.white.withAlpha(12),
        ),
        alignment: .center,
        padding: .symmetric(vertical: 14),
        child: Row(
          spacing: 6,
          mainAxisSize: .min,
          children: [
            if (isBack) back(24),

            title16W(m, font: f2),

            if (!isBack) Transform.flip(flipX: true, child: back(24)),
          ],
        ),
      ),
    );

Widget back(double size) => SizedBox(
  height: size * .7,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: SvgPicture.asset(
      "assets/icons/arrow_back.svg",
      fit: .fitWidth,
      width: size,
    ),
  ),
);

Widget title24W(
  String m, {
  double size = 24,
  FontWeight weight = .w600,
  Color? color,
  String? font,
  double? height,
  TextAlign? align,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontWeight: weight,
    fontSize: size,
    fontFamily: font,
  ),
  textAlign: align,
);

Widget title20W(
  String m, {
  double size = 20,
  FontWeight weight = .w600,
  Color? color,
  String? font,
  double? height,
  TextAlign? align,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontWeight: weight,
    fontSize: size,
    fontFamily: font,
  ),
  textAlign: align,
);

Widget title18W(
  String m, {
  double size = 18,
  FontWeight weight = .w600,
  Color? color,
  String? font,
  double? height,
  TextAlign? align,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontWeight: weight,
    fontSize: size,
    fontFamily: font,
  ),
  textAlign: align,
);

Widget title16W(
  String m, {
  double size = 16,
  FontWeight weight = .w600,
  Color? color,
  String? font,
  double? height,
  TextAlign? align,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontWeight: weight,
    fontSize: size,
    fontFamily: font,
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

Widget cloud() => Stack(
  children: [
    Positioned(
      right: -24,
      bottom: 60,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -36,
      bottom: 36,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      right: -72,
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
