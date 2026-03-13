import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/main.dart';
import 'package:daily_tarot_poc_app_6/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget titleW(String m, {String font = f1, Color? color}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontSize: 24,
    fontWeight: .bold,
    fontFamily: font,
  ),
);

Widget titleMW(
  String m, {
  String font = f1,
  Color? color,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontSize: 18,
    fontWeight: .bold,
    fontFamily: font,
  ),
  textAlign: align,
);

Widget titleSW(
  String m, {
  String font = f1,
  Color? color,
  TextAlign align = .start,
  double? height,
  FontWeight weight = .bold,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontSize: 16,
    fontWeight: weight,
    fontFamily: font,
    height: height,
  ),
  textAlign: align,
);

Widget titleSSW(
  String m, {
  String font = f1,
  Color? color,
  FontWeight weight = .w400,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontSize: 12,
    fontFamily: font,
    fontWeight: weight,
  ),
  textAlign: .center,
);

Widget cardWidget(String path, double width, {double radius = 8}) => Container(
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(borderRadius: .circular(radius)),
  child: Image.asset(path, fit: .fitWidth, width: width),
);

Widget backButton(BuildContext context) => Align(
  alignment: .topLeft,
  child: GestureDetector(
    onTap: () => appController.back(context, HomeScreen()),
    child: Padding(padding: const EdgeInsets.all(8.0), child: back(24)),
  ),
);

Widget closeButton(BuildContext context) => GestureDetector(
  onTap: () => appController.back(context, HomeScreen()),
  child: Container(
    decoration: BoxDecoration(
      border: .all(color: Colors.white),
      shape: .circle,
    ),
    padding: EdgeInsets.all(12),
    child: Icon(Icons.close, color: Colors.white, size: 32),
  ),
);

Widget moonCount(double size) => Row(
  mainAxisSize: .min,
  spacing: 8,
  children: [
    moon(size),
    Text(
      "${appController.moon}",
      style: TextStyle(
        color: Colors.white,
        fontSize: size * .7,
        fontWeight: .bold,
        fontFamily: f2,
      ),
    ),
  ],
);

Widget wheelList(List<int> list, Function(int value) change, {int? curValue}) =>
    ListWheelScrollView.useDelegate(
      itemExtent: 72,
      onSelectedItemChanged: (index) {
        change.call(list[index]);
      },
      childDelegate: ListWheelChildLoopingListDelegate(
        children: list
            .map(
              (e) => Column(
                crossAxisAlignment: .center,
                mainAxisAlignment: .spaceEvenly,
                children: [
                  if (curValue != null && curValue == e)
                    Container(color: Colors.white, height: 1, width: 18),

                  titleW(appController.numberFormat("00", e), font: f2),

                  if (curValue != null && curValue == e)
                    Container(color: Colors.white, height: 1, width: 18),
                ],
              ),
            )
            .toList(),
      ),
    );

Widget genderButton(
  bool isMale,
  double size,
  VoidCallback tap, {
  bool isCircle = false,
  double pad = 12,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(isCircle ? 99 : 12),
      border: .all(color: Colors.white, width: 1.5),
    ),
    padding: .all(pad),
    child: SvgPicture.asset(
      isMale ? "assets/icons/male.svg" : "assets/icons/female.svg",
      fit: .fitWidth,
      width: size,
    ),
  ),
);

Widget input(String m, Function(String m) submit) => TextField(
  decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: .circular(32),
      borderSide: BorderSide(color: Colors.white.withAlpha(100), width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: .circular(32),
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    hintText: m,
    contentPadding: .symmetric(horizontal: 24, vertical: 18),
    hintStyle: TextStyle(
      color: Colors.white.withAlpha(160),
      fontFamily: f2,
      fontWeight: .w500,
    ),
  ),
  onSubmitted: submit,
  style: TextStyle(color: Colors.white, fontWeight: .bold, fontFamily: f2),
);

Widget outButton(
  String m,
  VoidCallback tap, {
  Alignment align = .centerLeft,
  bool hasIcon = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      border: .all(color: Colors.white, width: 1.6),
      borderRadius: .circular(32),
    ),
    alignment: align,
    padding: .symmetric(vertical: 16, horizontal: 24),
    child: Row(
      spacing: 8,
      mainAxisSize: .min,
      children: [
        titleMW(m, font: f2),
        if (hasIcon) Transform.flip(flipX: true, child: back(18)),
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
      color: Colors.white.withAlpha(18),
      borderRadius: .circular(32),
    ),
    alignment: .center,
    padding: .symmetric(vertical: 18),
    child: Row(
      spacing: 8,
      mainAxisSize: .min,
      children: [
        if (isBack && hasIcon) back(22),
        titleMW(m, font: f2),
        if (!isBack && hasIcon) Transform.flip(flipX: true, child: back(22)),
      ],
    ),
  ),
);

Widget button1(
  String m,
  VoidCallback tap, {
  double radius = 2.5,
  bool hasMoon = false,
  bool hasIcon = true,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      gradient: RadialGradient(
        colors: [grad, purpleAccent],
        radius: radius,
        center: .topLeft,
      ),
      boxShadow: [
        BoxShadow(
          color: grad.withAlpha(100),
          offset: .new(2, 8),
          blurRadius: 12,
        ),
      ],
    ),
    alignment: .center,
    padding: .symmetric(vertical: 16),
    child: Row(
      spacing: 8,
      mainAxisSize: .min,
      children: [
        if (hasMoon && hasIcon) moon(42),

        titleMW(m),

        if (!hasMoon && hasIcon) Transform.flip(flipX: true, child: back(22)),
      ],
    ),
  ),
);

Widget back(double size) => SvgPicture.asset(
  "assets/icons/arrow_back.svg",
  fit: .fitWidth,
  width: size,
);

Widget background(
  Widget child, {
  double? height,
  double? width,
  double radius = 0,
}) => Container(
  width: width,
  height: height,
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(
    borderRadius: .circular(radius),
    gradient: LinearGradient(
      colors: [purple, deepPurple],
      begin: .topCenter,
      end: .bottomCenter,
    ),
  ),
  child: child,
);

Widget cloud() => Stack(
  children: [
    Positioned(
      right: 16,
      bottom: 43,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -22,
      bottom: 32,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      right: -64,
      bottom: 22,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -22,
      bottom: -12,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      right: 0,
      bottom: -12,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
  ],
);

Widget moon(double size) => SizedBox(
  height: size * .7,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: Image.asset("assets/images/moon.png", fit: .fitWidth, width: size),
  ),
);

Widget moon2(double size) => SizedBox.square(
  dimension: size,
  child: Stack(
    children: [
      Positioned.fill(child: Center(child: moon(size))),
      Positioned.fill(
        child: Align(alignment: .topRight, child: moon(size * .7)),
      ),
    ],
  ),
);

Widget moon3(double size) => SizedBox.square(
  dimension: size,
  child: Stack(
    children: [
      Positioned.fill(child: Center(child: moon(size))),
      Positioned.fill(
        child: Align(alignment: .topRight, child: moon(size * .7)),
      ),
      Positioned.fill(
        child: Align(alignment: .bottomRight, child: moon(size * .3)),
      ),
    ],
  ),
);
