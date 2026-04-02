import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/main.dart';
import 'package:daily_tarot_poc_app_11/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget cardWidget(String? path, double width) => Container(
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(borderRadius: .circular(8)),
  child: Image.asset(
    path ?? "assets/images/tarot_card_back.png",
    width: width,
    fit: .fitWidth,
  ),
);

Widget backButton(BuildContext context) => Align(
  alignment: .topLeft,
  child: GestureDetector(
    onTap: () {
      appController.back(context, HomeScreen());
    },
    child: Padding(padding: const EdgeInsets.all(12), child: back(28)),
  ),
);

Widget moonCount(double size) => Row(
  mainAxisSize: .min,
  spacing: 4,
  children: [
    moon(size * 1.4),
    titleW("${appController.moon}", size: size * .8, font: f2),
  ],
);

Widget outButton(
  String m,
  VoidCallback tap, {
  Alignment align = .centerLeft,
  bool white = true,
  bool hasIcon = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      border: .all(color: white ? Colors.white : Colors.white54, width: 1.6),
    ),
    alignment: align,
    padding: .symmetric(horizontal: 24, vertical: 14),
    child: Row(
      mainAxisAlignment: .spaceBetween,
      mainAxisSize: hasIcon ? .max : .min,
      children: [
        titleW(m, font: f2, color: white ? Colors.white : Colors.white54),
        Transform.flip(
          flipX: true,
          child: back(24, color: white ? Colors.white : Colors.white54),
        ),
      ],
    ),
  ),
);

Widget listWheel(
  List<int> list,
  Function(int value) change,
  int initialValue,
) => Stack(
  children: [
    Positioned.fill(
      top: 60,
      child: Center(
        child: Container(color: Colors.white, width: 24, height: 1.6),
      ),
    ),
    Positioned.fill(
      bottom: 60,
      child: Center(
        child: Container(color: Colors.white, width: 24, height: 1.6),
      ),
    ),

    ListWheelScrollView.useDelegate(
      itemExtent: 60,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      diameterRatio: 15,
      overAndUnderCenterOpacity: .6,
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
  double pad = 10,
  double size = 52,
  bool isCircle = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      border: .all(color: Colors.white70, width: 1.6),
      borderRadius: .circular(isCircle ? 99 : 16),
    ),
    padding: .all(pad),
    child: SvgPicture.asset(
      isMale
          ? "assets/icons/male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg"
          : "assets/icons/female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg",
      fit: .fitWidth,
      width: size,
    ),
  ),
);

Widget input({
  required String hint,
  required Function(String m) submit,
  required String initialValue,
  bool isN = false,
}) => TextField(
  keyboardType: isN ? .number : null,
  inputFormatters: isN ? [FilteringTextInputFormatter.digitsOnly] : null,
  decoration: InputDecoration(
    hint: titleW(hint, font: f2, color: Colors.white70),
    enabledBorder: OutlineInputBorder(
      borderRadius: .circular(36),
      borderSide: BorderSide(color: Colors.white70, width: 1.6),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: .circular(36),
      borderSide: BorderSide(color: Colors.white70, width: 2),
    ),
    contentPadding: .symmetric(horizontal: 24, vertical: 14),
  ),
  controller: TextEditingController(text: initialValue),
  style: TextStyle(color: Colors.white, fontFamily: f2),
  onSubmitted: submit,
);

Widget button1(
  String m,
  VoidCallback tap, {
  Alignment align = .center,
  bool hasMoon = false,
  bool hasIcon = true,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      gradient: RadialGradient(
        colors: [grad, accentPurple],
        center: .topLeft,
        radius: 1.6,
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
    alignment: align,
    child: Row(
      mainAxisSize: .min,
      spacing: 6,
      children: [
        if (hasMoon && hasIcon) moon(42),
        title18W(m, size: hasMoon ? 20 : 18),
        if (!hasMoon && hasIcon) Transform.flip(flipX: true, child: back(22)),
      ],
    ),
  ),
);

Widget button2(
  String m,
  VoidCallback tap, {
  Alignment align = .center,
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
    alignment: align,
    child: Row(
      mainAxisSize: .min,
      spacing: 6,
      children: [
        if (isBack && hasIcon) back(24),
        titleW(m, font: f2, size: 15),
        if (!isBack && hasIcon) Transform.flip(flipX: true, child: back(24)),
      ],
    ),
  ),
);

Widget back(double size, {Color? color}) => SizedBox(
  width: size * .383,
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
      bottom: 60,
      right: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: 36,
      left: -36,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: 24,
      right: -96,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: -24,
      left: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: -36,
      right: 0,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
  ],
);

Widget moon(double size) => Container(
  width: size * .89,
  height: size * .8,
  decoration: BoxDecoration(
    shape: .circle,
    boxShadow: [BoxShadow(color: grad.withAlpha(60), blurRadius: 6)],
  ),
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
      child: Align(alignment: .bottomRight, child: moon(size * .2)),
    ),
    Positioned.fill(
      child: Align(alignment: .topRight, child: moon(size * .6)),
    ),
    moon(size),
  ],
);

Widget title28W(
  String m, {
  Color? color,
  double size = 28,
  double? height,
  FontWeight weight = .bold,
  String? font,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: font,
    fontWeight: weight,
    fontSize: size,
  ),
  textAlign: align,
);

Widget title24W(
  String m, {
  Color? color,
  double size = 24,
  double? height,
  FontWeight weight = .bold,
  String? font,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: font,
    fontWeight: weight,
    fontSize: size,
  ),
  textAlign: align,
);

Widget title18W(
  String m, {
  Color? color,
  double size = 18,
  double? height,
  FontWeight weight = .bold,
  String? font,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: font,
    fontWeight: weight,
    fontSize: size,
  ),
  textAlign: align,
);

Widget titleW(
  String m, {
  Color? color,
  double size = 16,
  double? height,
  FontWeight weight = .bold,
  String? font,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: font,
    fontWeight: weight,
    fontSize: size,
  ),
  textAlign: align,
);

Widget title14W(
  String m, {
  Color? color,
  double size = 14,
  double? height,
  FontWeight weight = .bold,
  String? font,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: font,
    fontWeight: weight,
    fontSize: size,
  ),
  textAlign: align,
);

Widget title20W(
  String m, {
  Color? color,
  double size = 20,
  double? height,
  FontWeight weight = .bold,
  String? font,
  TextAlign align = .start,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: font,
    fontWeight: weight,
    fontSize: size,
  ),
  textAlign: align,
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
