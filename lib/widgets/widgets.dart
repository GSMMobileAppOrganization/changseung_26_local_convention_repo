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
    child: Padding(padding: const EdgeInsets.all(16), child: back(24)),
  ),
);

Widget closeButton(BuildContext context) => GestureDetector(
  onTap: () => appController.back(context, HomeScreen()),
  child: Container(
    decoration: BoxDecoration(
      shape: .circle,
      border: .all(color: Colors.white54, width: 1.4),
    ),
    padding: EdgeInsets.all(6),
    child: Icon(Icons.close, color: Colors.white54, size: 36),
  ),
);

Widget moonCount(double size) => Row(
  mainAxisSize: .min,
  children: [
    moon(size * 1.4),
    Center(
      child: title14W("${appController.moon}", size: size * .7, font: f2),
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
  bool isSpace = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      border: .all(color: Colors.white54, width: 1.6),
      borderRadius: .circular(32),
    ),
    alignment: align,
    padding: .symmetric(horizontal: hasIcon && !isSpace ? 0 : 24, vertical: 12),
    child: Row(
      mainAxisAlignment: isSpace ? .spaceBetween : .center,
      mainAxisSize: isSpace ? .max : .min,
      spacing: 6,
      children: [
        title14W(m, font: f2, color: color ?? Colors.white70),
        if (hasIcon) Transform.flip(flipX: true, child: back(18, color: color)),
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
      child: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            Container(color: Colors.white54, height: 1.6, width: 14),
            SizedBox(height: 60),
            Container(color: Colors.white54, height: 1.6, width: 14),
          ],
        ),
      ),
    ),

    ListWheelScrollView.useDelegate(
      itemExtent: 60,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      diameterRatio: 15,
      overAndUnderCenterOpacity: .5,
      controller: FixedExtentScrollController(initialItem: initialValue),
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

Widget genderButton(
  bool isMale,
  VoidCallback tap, {
  double pad = 8,
  double size = 52,
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
    hint: title16W(size: 15, hint, font: f2, color: Colors.white54),
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
          color: grad.withAlpha(100),
          offset: .new(0, 8),
          blurRadius: 18,
        ),
      ],
    ),
    alignment: .center,
    padding: .symmetric(vertical: 16),
    child: Row(
      spacing: 6,
      mainAxisSize: .min,
      children: [
        if (hasMoon && hasIcon) moon(32),
        title18W(m, weight: .w800, size: 17),
        if (!hasMoon && hasIcon) Transform.flip(flipX: true, child: back(23)),
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
      spacing: 8,
      mainAxisSize: .min,
      children: [
        if (isBack && hasIcon) back(24),

        title16W(size: 16, m, font: f2),
        if (!isBack && hasIcon) Transform.flip(flipX: true, child: back(24)),
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
    boxShadow: [BoxShadow(color: grad.withAlpha(30), blurRadius: 8)],
  ),
  child: ClipRect(
    child: Image.asset("assets/images/moon.png", fit: .fitWidth, width: size),
  ),
);

Widget moon2(int moonCount) => Stack(
  children: [
    if (moonCount > 2)
      Positioned.fill(
        child: Align(alignment: .bottomRight, child: moon(12)),
      ),
    if (moonCount > 1)
      Positioned.fill(
        child: Align(alignment: .topRight, child: moon(26)),
      ),
    moon(42),
  ],
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
      right: -82,
      bottom: 24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
    Positioned(
      left: -24,
      bottom: -12,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
    ),
    Positioned(
      right: 0,
      bottom: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 230),
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
