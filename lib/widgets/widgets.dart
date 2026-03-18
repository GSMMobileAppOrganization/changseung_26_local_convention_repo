import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/main.dart';
import 'package:daily_tarot_poc_app_9/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    onTap: () => appController.goReset(context, HomeScreen()),
    child: Padding(padding: .all(12), child: back(24)),
  ),
);

Widget closeButton(BuildContext context) => GestureDetector(
  onTap: () => appController.goReset(context, HomeScreen()),
  child: Container(
    decoration: BoxDecoration(
      border: .all(color: Colors.white54, width: 1.6),
      shape: .circle,
    ),
    padding: .all(12),
    child: Icon(Icons.close, color: Colors.white54, size: 36),
  ),
);

Widget moonCount(double size) => Row(
  spacing: 6,
  mainAxisSize: .min,
  children: [
    moon(size * 1.4),
    title18W("${appController.moon}", size: size * .7, font: f2),
  ],
);

Widget outButton(
  String m,
  VoidCallback tap, {
  double pad = 12,
  int alpha = 255,
  Alignment align = .centerLeft,
  bool hasBack = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      border: .all(color: Colors.white.withAlpha(alpha), width: 1.5),
    ),
    alignment: align,
    padding: .symmetric(vertical: 14, horizontal: 24),
    child: Row(
      mainAxisSize: .min,
      spacing: 6,
      children: [
        title16W(m, font: f2, weight: .bold),
        if (hasBack) Transform.flip(flipX: true, child: back(22)),
      ],
    ),
  ),
);

Widget listWheel(
  List<int> list,
  Function(int value) change,
  int initialIndex,
) => Stack(
  children: [
    Positioned.fill(
      child: Align(
        alignment: Alignment(0, .4),
        child: Container(color: Colors.white54, height: 2, width: 18),
      ),
    ),
    Positioned.fill(
      child: Align(
        alignment: Alignment(0, -.4),
        child: Container(color: Colors.white54, height: 2, width: 18),
      ),
    ),

    ListWheelScrollView.useDelegate(
      itemExtent: 60,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      overAndUnderCenterOpacity: .6,
      diameterRatio: 20,
      controller: FixedExtentScrollController(initialItem: initialIndex),
      childDelegate: ListWheelChildLoopingListDelegate(
        children: list
            .map(
              (e) => Center(
                child: title20W(
                  size: 22,
                  appController.numberFormat("00", e),
                  font: f2,
                  weight: .w500,
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
  double pad = 12,
  double width = 36,
  double rad = 12,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(rad),
      border: .all(color: Colors.white.withAlpha(160), width: 1.5),
    ),
    padding: .all(pad),
    child: SvgPicture.asset(
      isMale ? "assets/icons/male.svg" : "assets/icons/female.svg",
      fit: .fitWidth,
      width: width,
    ),
  ),
);

Widget input({required String h, required Function(String m) submit}) =>
    TextField(
      decoration: InputDecoration(
        hint: title18W(h, color: Colors.white.withAlpha(160), font: f2),
        contentPadding: .symmetric(horizontal: 24, vertical: 14),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(32),
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(32),
          borderSide: BorderSide(
            color: Colors.white.withAlpha(160),
            width: 1.5,
          ),
        ),
      ),
      style: TextStyle(color: Colors.white, fontWeight: .bold, fontFamily: f2),
      onSubmitted: submit,
    );

Widget button1(
  String m,
  VoidCallback tap, {
  double rad = 2.2,
  bool isMoon = false,
  bool hasIcon = true,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      gradient: RadialGradient(
        colors: [grad, purple],
        center: .topLeft,
        radius: rad,
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
      children: [
        if (isMoon && hasIcon) moon(36),
        title16W(m, weight: .w800, size: isMoon ? 20 : 16),
        if (!isMoon && hasIcon) Transform.flip(flipX: true, child: back(24)),
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
      children: [
        if (isBack && hasIcon) back(24),

        title16W(m, font: f2, weight: .bold),
        if (!isBack && hasIcon) Transform.flip(flipX: true, child: back(24)),
      ],
    ),
  ),
);

Widget back(double size) => SizedBox(
  height: size * .8,
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
  FontWeight weight = .bold,
  String? font,
  double? height,
  TextAlign? align,
  Color? color,
}) => Text(
  m,
  style: TextStyle(
    fontFamily: font,
    height: height,
    fontSize: size,
    fontWeight: weight,
    color: color ?? Colors.white,
  ),
  textAlign: align,
);

Widget title20W(
  String m, {
  double size = 20,
  FontWeight weight = .bold,
  String? font,
  double? height,
  TextAlign? align,
  Color? color,
}) => Text(
  m,
  style: TextStyle(
    fontFamily: font,
    height: height,
    fontSize: size,
    fontWeight: weight,
    color: color ?? Colors.white,
  ),
  textAlign: align,
);

Widget title18W(
  String m, {
  double size = 18,
  FontWeight weight = .bold,
  String? font,
  double? height,
  TextAlign? align,
  Color? color,
}) => Text(
  m,
  style: TextStyle(
    fontFamily: font,
    height: height,
    fontSize: size,
    fontWeight: weight,
    color: color ?? Colors.white,
  ),
  textAlign: align,
);

Widget title16W(
  String m, {
  double size = 16,
  FontWeight weight = .bold,
  String? font,
  double? height,
  TextAlign? align,
  Color? color,
}) => Text(
  m,
  style: TextStyle(
    fontFamily: font,
    height: height,
    fontSize: size,
    fontWeight: weight,
    color: color ?? Colors.white,
  ),
  softWrap: true,
  textAlign: align,
);

Widget title14W(
  String m, {
  double size = 14,
  FontWeight weight = .bold,
  String? font,
  double? height,
  TextAlign? align,
  Color? color,
}) => Text(
  m,
  style: TextStyle(
    fontFamily: font,
    height: height,
    fontSize: size,
    fontWeight: weight,
    color: color ?? Colors.white,
  ),
  textAlign: align,
);

Widget title12W(
  String m, {
  double size = 12,
  FontWeight weight = .bold,
  String? font,
  double? height,
  TextAlign? align,
  Color? color,
}) => Text(
  m,
  style: TextStyle(
    fontFamily: font,
    height: height,
    fontSize: size,
    fontWeight: weight,
    color: color ?? Colors.white,
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

Widget moon2(double size) => Stack(
  children: [
    Positioned.fill(
      child: Align(alignment: .topRight, child: moon(size * .6)),
    ),
    moon(size),
  ],
);

Widget moon3(double size) => Stack(
  children: [
    Positioned.fill(
      child: Align(alignment: .topRight, child: moon(size * .6)),
    ),
    Positioned.fill(
      child: Align(alignment: .bottomRight, child: moon(size * .3)),
    ),
    moon(size),
  ],
);

Widget cloud() => Stack(
  children: [
    Positioned(
      bottom: 48,
      right: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: 36,
      left: -32,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: 24,
      right: -72,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -24,
      bottom: -12,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: -36,
      right: 0,
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
