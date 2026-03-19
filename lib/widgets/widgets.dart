import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/main.dart';
import 'package:daily_tarot_poc_app_7/screesn/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    onTap: () => appController.back(context, HomeScreen()),
    child: Padding(padding: const EdgeInsets.all(16), child: back(28)),
  ),
);

Widget closeButton(BuildContext context) => GestureDetector(
  onTap: () => appController.back(context, HomeScreen()),
  child: Container(
    decoration: BoxDecoration(
      shape: .circle,
      border: .all(color: Colors.white54, width: 1.6),
    ),
    padding: EdgeInsets.all(6),
    child: Icon(Icons.close, color: Colors.white54, size: 36),
  ),
);

Widget moonCount(double size) => Row(
  mainAxisSize: .min,
  children: [
    moon(size * 1.4),
    SizedBox(
      width: size,
      child: Center(
        child: title14W("${appController.moon}", size: size * .7, font: f2),
      ),
    ),
  ],
);

Widget title24W(
  String m, {
  Color? color,
  FontWeight? weight,
  double? height,
  TextAlign? align,
  String? font,
  double size = 24,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontWeight: weight ?? .bold,
    fontSize: size,
    height: height,
    fontFamily: font,
  ),
  textAlign: align,
);

Widget title20W(
  String m, {
  Color? color,
  FontWeight? weight,
  double? height,
  TextAlign? align,
  String? font,
  double size = 20,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontWeight: weight ?? .bold,
    fontSize: size,
    height: height,
    fontFamily: font,
  ),
  textAlign: align,
);

Widget title16W(
  String m, {
  Color? color,
  FontWeight? weight,
  double? height,
  TextAlign? align,
  String? font,
  double size = 16,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontWeight: weight ?? .bold,
    fontSize: size,
    height: height,
    fontFamily: font,
  ),
  textAlign: align,
);

Widget title12W(
  String m, {
  Color? color,
  FontWeight? weight,
  double? height,
  TextAlign? align,
  String? font,
  double size = 12,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontWeight: weight ?? .bold,
    fontSize: size,
    height: height,
    fontFamily: font,
  ),
  textAlign: align,
);

Widget title14W(
  String m, {
  Color? color,
  FontWeight? weight,
  double? height,
  TextAlign? align,
  String? font,
  double size = 14,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontWeight: weight ?? .bold,
    fontSize: size,
    height: height,
    fontFamily: font,
  ),
  textAlign: align,
);

Widget title18W(
  String m, {
  Color? color,
  FontWeight? weight,
  double? height,
  TextAlign? align,
  String? font,
  double size = 18,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    fontWeight: weight ?? .bold,
    fontSize: size,
    height: height,
    fontFamily: font,
  ),
  textAlign: align,
);

Widget outButton(
  String m,
  VoidCallback tap, {
  Alignment align = .centerLeft,
  Color? color,
  bool hasIcon = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      border: .all(color: Colors.white54, width: 1.6),
      borderRadius: .circular(32),
    ),
    alignment: align,
    padding: .symmetric(horizontal: 24, vertical: 14),
    child: Row(
      spacing: 6,
      mainAxisSize: .min,
      children: [
        title16W(m, font: f2, color: color),
        if (hasIcon) Transform.flip(flipX: true, child: back(22, color: color)),
      ],
    ),
  ),
);

Widget wheelList(
  List<int> list,
  Function(int value) change,
  int initialValue,
) => Stack(
  children: [
    Positioned.fill(
      top: 60,
      child: Center(
        child: Container(color: Colors.white, height: 1.6, width: 20),
      ),
    ),
    Positioned.fill(
      bottom: 60,
      child: Center(
        child: Container(color: Colors.white, height: 1.6, width: 20),
      ),
    ),

    ListWheelScrollView.useDelegate(
      itemExtent: 60,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      controller: FixedExtentScrollController(initialItem: initialValue),
      childDelegate: ListWheelChildLoopingListDelegate(
        children: list
            .map(
              (e) => Center(
                child: title24W(appController.numberFormat("00", e), font: f2),
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
  double pad = 8,
  double size = 60,
  isCircle = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(isCircle ? 99 : 16),
      border: .all(color: Colors.white54, width: 1.6),
    ),
    padding: .all(pad),
    child: SvgPicture.asset(
      isMale ? "assets/icons/male.svg" : "assets/icons/female.svg",
      fit: .fitWidth,
      width: size,
    ),
  ),
);

Widget input(
  String hint,
  Function(String m) submit, {
  bool isNumber = false,
  String? initialValue,
}) => TextField(
  keyboardType: isNumber ? .number : null,
  decoration: InputDecoration(
    hint: title16W(hint, font: f2, color: Colors.white54),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white54, width: 1.6),
      borderRadius: .circular(32),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: .circular(32),
    ),
    contentPadding: .symmetric(horizontal: 24, vertical: 14),
  ),
  style: TextStyle(color: Colors.white, fontWeight: .bold, fontFamily: f2),
  onSubmitted: submit,
  controller: TextEditingController(text: initialValue),
);

Widget button1(
  String m,
  VoidCallback tap, {
  double radius = 2.2,
  bool hasMoon = false,
  bool hasIcon = true,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [grad, purpleAccent],
        center: .topLeft,
        radius: radius,
      ),
      borderRadius: .circular(32),
      boxShadow: [
        BoxShadow(
          color: grad.withAlpha(160),
          offset: .new(0, 8),
          blurRadius: 12,
        ),
      ],
    ),
    alignment: .center,
    padding: .symmetric(vertical: 16),
    child: Row(
      spacing: 6,
      mainAxisSize: .min,
      children: [
        if (hasMoon && hasIcon) moon(42),
        title18W(m, weight: .w800, size: 18),
        if (!hasMoon && hasIcon) Transform.flip(flipX: true, child: back(22)),
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
      color: Colors.white.withAlpha(20),
      borderRadius: .circular(32),
    ),
    alignment: .center,
    padding: .symmetric(vertical: 14),
    child: Row(
      mainAxisSize: .min,
      children: [
        if (isBack && hasIcon) back(26),

        title18W(m, font: f2),
        if (!isBack && hasIcon) Transform.flip(flipX: true, child: back(26)),
      ],
    ),
  ),
);

Widget back(double size, {Color? color}) => SizedBox(
  width: size * .7,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: SvgPicture.asset(
      "assets/icons/arrow_back.svg",
      fit: .fitHeight,
      height: size,
      color: color,
    ),
  ),
);

Widget moon(double size) => Container(
  height: size * .8,
  decoration: BoxDecoration(
    shape: .circle,
    boxShadow: [BoxShadow(color: grad.withAlpha(160), blurRadius: 8)],
  ),
  child: ClipRect(
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
      right: -12,
      bottom: 42,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -38,
      bottom: 34,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      right: -64,
      bottom: 24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -18,
      bottom: -8,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      right: -12,
      bottom: -12,
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
