import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/main.dart';
import 'package:daily_tarot_poc_app_8/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget titleW(
  String m, {
  FontWeight weight = .bold,
  double size = 24,
  Color? color,
  String? font,
  double? height,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontFamily: font,
    height: height,
    fontWeight: weight,
    fontSize: size,
  ),
  textAlign: align,
);

Widget titleMW(
  String m, {
  FontWeight weight = .w600,
  Color? color,
  String? font,
  double? height,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontFamily: font,
    height: height,
    fontWeight: weight,
    fontSize: 18,
  ),
  textAlign: align,
);

Widget titleSW(
  String m, {
  FontWeight weight = .bold,
  Color? color,
  String? font,
  double? height,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontFamily: font,
    height: height,
    fontWeight: weight,
    fontSize: 16,
  ),
  textAlign: align,
);

Widget titleSSSW(
  String m, {
  FontWeight weight = .bold,
  Color? color,
  String? font,
  double? height,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontFamily: font,
    height: height,
    fontWeight: weight,
    fontSize: 12,
  ),
  textAlign: align,
);

Widget titleSSW(
  String m, {
  FontWeight weight = .bold,
  Color? color,
  String? font,
  double? height,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontFamily: font,
    height: height,
    fontWeight: weight,
    fontSize: 14,
  ),
  textAlign: align,
);

Widget cardWidget(String? path, double width, {double radius = 8}) => Container(
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(borderRadius: .circular(radius)),
  child: Image.asset(
    path ?? "assets/images/tarot_card_back.png",
    fit: .fitWidth,
    width: width,
  ),
);

Widget backButton(BuildContext context) => Align(
  alignment: .topLeft,
  child: GestureDetector(
    onTap: () => appController.goReset(context, HomeScreen()),
    child: Padding(padding: .all(8), child: back(size: 28)),
  ),
);

Widget closeButton(BuildContext context) => GestureDetector(
  onTap: () => appController.goReset(context, HomeScreen()),
  child: Container(
    decoration: BoxDecoration(
      shape: .circle,
      border: .all(color: Colors.white),
    ),
    padding: .all(8),
    child: Icon(Icons.close, color: Colors.white, size: 32),
  ),
);

Widget moonCount(double size) => Row(
  spacing: 6,
  mainAxisSize: .min,
  children: [
    moon(size),
    titleW("${appController.moon}", size: size * .7, font: f2),
  ],
);

Widget wheelList(List<int> list, Function(int value) change, {int? curValue}) =>
    ListWheelScrollView.useDelegate(
      itemExtent: 72,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      overAndUnderCenterOpacity: 0.5,
      diameterRatio: 15,
      childDelegate: ListWheelChildLoopingListDelegate(
        children: list
            .map(
              (e) => Column(
                mainAxisAlignment: .spaceAround,
                children: [
                  if (curValue == e)
                    Container(color: Colors.white, height: 1, width: 18),
                  titleW(appController.numberFormat("00", e), font: f2),
                  if (curValue == e)
                    Container(color: Colors.white, height: 1, width: 18),
                ],
              ),
            )
            .toList(),
      ),
    );

Widget genderButton(
  bool isMale,
  VoidCallback tap, {
  bool isCircle = false,
  double pad = 12,
  double size = 64,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(isCircle ? 99 : 18),
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

Widget outButton(
  String m,
  VoidCallback tap, {
  Alignment align = .centerLeft,
  bool hasIcon = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      border: .all(color: Colors.white, width: 1.5),
    ),
    alignment: align,
    padding: .symmetric(vertical: 18, horizontal: 24),
    child: Row(
      mainAxisSize: .min,
      children: [
        titleMW(m, font: f2),

        if (hasIcon) Transform.flip(flipX: true, child: back(size: 24)),
      ],
    ),
  ),
);

Widget input(String h, Function(String m) sub) => TextField(
  decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: .circular(32),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white.withAlpha(160), width: 2),
      borderRadius: .circular(32),
    ),
    contentPadding: .symmetric(horizontal: 24, vertical: 18),
    hint: titleMW(h, font: f2, color: Colors.white.withAlpha(160)),
  ),
  onSubmitted: sub,
  style: TextStyle(color: Colors.white, fontFamily: f2, fontWeight: .w500),
);

Widget button1(
  String m,
  VoidCallback tap, {
  double radius = 2,
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
          offset: .new(0, 8),
          blurRadius: 18,
        ),
      ],
    ),
    alignment: .center,
    padding: .symmetric(vertical: 18),
    child: Row(
      spacing: 2,
      mainAxisSize: .min,
      children: [
        if (hasMoon && hasIcon) moon(42),
        titleMW(m),
        if (!hasMoon && hasIcon) Transform.flip(flipX: true, child: back()),
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
    alignment: .center,
    padding: .symmetric(vertical: 14),
    child: Row(
      spacing: 6,
      mainAxisSize: .min,
      children: [
        if (isBack && hasIcon) back(size: 26),
        titleW(m, font: f2, size: 16),
        if (!isBack && hasIcon)
          Transform.flip(flipX: true, child: back(size: 26)),
      ],
    ),
  ),
);

Widget back({double size = 24}) => SvgPicture.asset(
  "assets/icons/arrow_back.svg",
  fit: .fitWidth,
  width: size,
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

Widget cloud() => Stack(
  children: [
    Positioned(
      right: -18,
      bottom: 48,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -24,
      bottom: 32,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      right: -72,
      bottom: 24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -12,
      bottom: -8,
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

Widget moon2(double size) => Stack(
  children: [
    moon(size),
    Positioned.fill(
      child: Align(alignment: .topRight, child: moon(size * .6)),
    ),
  ],
);

Widget moon3(double size) => Stack(
  children: [
    moon(size),
    Positioned.fill(
      child: Align(alignment: .topRight, child: moon(size * .6)),
    ),
    Positioned.fill(
      child: Align(alignment: .bottomRight, child: moon(size * .3)),
    ),
  ],
);
