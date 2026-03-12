import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/main.dart';
import 'package:daily_tarot_poc_app_5/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget cardWidget(String path, double width, {double radius = 8}) => Container(
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(borderRadius: .circular(radius)),
  child: Image.asset(path, fit: .fitWidth, width: width),
);

Widget backButton(BuildContext context) => Align(
  alignment: .topLeft,
  child: GestureDetector(
    onTap: () => appController.back(context, HomeScreen()),
    child: Padding(padding: .all(12), child: back(28)),
  ),
);

Widget closeButton(BuildContext context) => GestureDetector(
  onTap: () => appController.back(context, HomeScreen()),
  child: Container(
    decoration: BoxDecoration(
      border: .all(color: Colors.white, width: .5),
      shape: .circle,
    ),
    padding: .all(12),
    child: Icon(Icons.close, color: Colors.white, size: 38,),
  ),
);

Widget moonCount(double size) => Row(
  mainAxisSize: .min,
  spacing: 6,
  children: [
    moon(size),
    Text(
      "${appController.moon}",
      style: TextStyle(
        color: Colors.white,
        fontFamily: f2,
        fontWeight: .bold,
        fontSize: size * .6,
      ),
    ),
  ],
);

Widget outButton(
  String m,
  VoidCallback tap, {
  Alignment algin = .centerLeft,
  bool hasIcon = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      border: .all(color: Colors.white),
    ),
    alignment: algin,
    padding: .symmetric(horizontal: 24, vertical: 16),
    child: Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Text(
          m,
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontSize: 16,
          ),
        ),

        if (hasIcon) Transform.flip(flipX: true, child: back(20)),
      ],
    ),
  ),
);

Widget wheelList(
  List<int> list,
  Function(int value) change, {
  String? format,
  int? curValue,
}) => ListWheelScrollView.useDelegate(
  itemExtent: 72,
  onSelectedItemChanged: (value) {
    change.call(list[value]);
  },
  childDelegate: ListWheelChildLoopingListDelegate(
    children: list
        .map(
          (e) => Column(
            mainAxisSize: .min,
            mainAxisAlignment: .spaceAround,
            children: [
              if (curValue != null && curValue == e)
                Container(color: Colors.white, height: 1, width: 20),

              Text(
                "$e",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .bold,
                  fontSize: 20,
                  fontFamily: f2,
                ),
              ),

              if (curValue != null && curValue == e)
                Container(color: Colors.white, height: 1, width: 20),
            ],
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

Widget button2(String m, VoidCallback tap, {bool isBack = false, bool hasIcon = true}) =>
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
            if (isBack && hasIcon) back(24),

            Text(
              m,
              style: TextStyle(
                fontSize: 18,
                fontWeight: .bold,
                color: Colors.white,
                fontFamily: f2,
              ),
            ),

            if (!isBack && hasIcon) Transform.flip(flipX: true, child: back(24)),
          ],
        ),
      ),
    );

Widget button1(
  String m,
  VoidCallback tap, {
  bool isBack = false,
  double radius = 2,
  bool hasMoon = false,
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
        if (hasMoon) moon(32),

        Text(
          m,
          style: TextStyle(
            fontSize: 18,
            fontWeight: .bold,
            color: Colors.white,
          ),
        ),

        if (!isBack && !hasMoon) Transform.flip(flipX: true, child: back(24)),
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

Widget background(
  Widget child, {
  double? width,
  double? height,
  double radius = 0,
}) => Container(
  clipBehavior: .hardEdge,
  width: width ?? .infinity,
  height: height ?? .infinity,
  decoration: BoxDecoration(
    borderRadius: .circular(radius),
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
