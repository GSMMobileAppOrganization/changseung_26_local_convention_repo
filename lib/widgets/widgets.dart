import 'package:daily_tarot_poc_app_5/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget outButton(String m, VoidCallback tap) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      border: .all(color: Colors.white),
    ),
    alignment: .centerLeft,
    padding: .symmetric(horizontal: 24, vertical: 16),
    child: Text(
      m,
      style: TextStyle(color: Colors.white, fontWeight: .bold, fontSize: 16),
    ),
  ),
);

Widget wheelList(List<int> list, Function(int value) change) =>
    ListWheelScrollView.useDelegate(
      itemExtent: 72,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      childDelegate: ListWheelChildLoopingListDelegate(
        children: list
            .map(
              (e) => Text(
                "$e",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .bold,
                  fontSize: 18,
                ),
              ),
            )
            .toList(),
      ),
    );

Widget genderButton(
  bool isMale,
  VoidCallback tap, {
  double size = 52,
  bool isCircle = false,
  double padding = 12,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(isCircle ? 99 : 12),
      border: .all(color: Colors.white),
    ),
    padding: .all(padding),
    child: SvgPicture.asset(
      isMale ? "assets/icons/male.svg" : "assets/icons/female.svg",
      fit: .fitWidth,
      width: size,
    ),
  ),
);

Widget input(String hint, Function(String m) submit) => TextField(
  decoration: InputDecoration(
    contentPadding: .symmetric(horizontal: 24, vertical: 16),
    hintText: hint,
    hintStyle: TextStyle(color: Colors.white.withAlpha(160), fontFamily: f2),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: .circular(32),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: .circular(32),
    ),
  ),
  onSubmitted: submit,
  style: TextStyle(color: Colors.white.withAlpha(160), fontFamily: f2),
);

Widget button2(String m, VoidCallback tap, {bool isBack = false}) =>
    GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(32),
          color: Colors.white.withAlpha(20),
        ),
        alignment: .center,
        padding: .symmetric(horizontal: 18, vertical: 16),
        child: Row(
          spacing: 6,
          mainAxisSize: .min,
          children: [
            if (isBack) back(24),

            Text(
              m,
              style: TextStyle(
                fontSize: 18,
                fontWeight: .bold,
                color: Colors.white,
                fontFamily: f2,
              ),
            ),

            if (!isBack) Transform.flip(flipX: true, child: back(24)),
          ],
        ),
      ),
    );

Widget button1(
  String m,
  VoidCallback tap, {
  bool isBack = false,
  double radius = 2,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [gradY, purple],
        center: .topLeft,
        radius: radius,
      ),
      borderRadius: .circular(32),
    ),
    alignment: .center,
    padding: .symmetric(horizontal: 26, vertical: 16),
    child: Row(
      spacing: 6,
      mainAxisSize: .min,
      children: [
        Text(
          m,
          style: TextStyle(
            fontSize: 18,
            fontWeight: .bold,
            color: Colors.white,
          ),
        ),

        if (!isBack) Transform.flip(flipX: true, child: back(24)),
      ],
    ),
  ),
);

Widget back(double size) => SizedBox(
  width: size * .8,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: SvgPicture.asset(
      "assets/icons/arrow_back.svg",
      fit: .fitHeight,
      height: size,
    ),
  ),
);

Widget cloud() => Stack(
  children: [
    Positioned(
      right: 0,
      bottom: 0,
      child: Image.asset("assets/images/cloud.png", width: 250, fit: .fitWidth),
    ),
    Positioned(
      right: -18,
      bottom: 64,
      child: Image.asset("assets/images/cloud.png", width: 250, fit: .fitWidth),
    ),
    Positioned(
      left: -24,
      bottom: 42,
      child: Image.asset("assets/images/cloud.png", width: 250, fit: .fitWidth),
    ),
    Positioned(
      right: -82,
      bottom: 26,
      child: Image.asset("assets/images/cloud.png", width: 250, fit: .fitWidth),
    ),
    Positioned(
      left: -18,
      bottom: -12,
      child: Image.asset("assets/images/cloud.png", width: 250, fit: .fitWidth),
    ),
    Positioned(
      right: 0,
      bottom: -24,
      child: Image.asset("assets/images/cloud.png", width: 250, fit: .fitWidth),
    ),
  ],
);

Widget background(Widget child, {double? width, double? height}) => Container(
  width: width ?? .infinity,
  height: height ?? .infinity,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [purple, deepPurple],
      begin: .topLeft,
      end: .bottomRight,
    ),
  ),
  child: child,
);

Widget moon(double size) => SizedBox(
  height: size * .7,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: Image.asset("assets/images/moon.png", fit: .fitWidth, width: size),
  ),
);
