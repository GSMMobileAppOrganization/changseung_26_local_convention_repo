import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:daily_tarot_poc_app_4/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/*Widget () =>*/

Widget closeButton(BuildContext context) => GestureDetector(
  onTap: () => appController.moveReset(context, HomeScreen()),
  child: Container(
    decoration: BoxDecoration(
      shape: .circle,
      border: .all(color: Colors.white, width: .6),
    ),
    padding: .all(8),
    child: Icon(Icons.close, color: Colors.white, size: 42),
  ),
);

Widget cardWidget(String path, double width, {double radius = 16}) => Container(
  width: width,
  height: width * 1.5,
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(borderRadius: .circular(radius)),
  child: Image.asset(path, fit: .fitWidth),
);

Widget backButton(BuildContext context) => Align(
  alignment: .topLeft,
  child: GestureDetector(
    onTap: () => appController.moveReset(context, HomeScreen()),
    child: Padding(padding: .all(12), child: back(28)),
  ),
);

Widget moonCount(double size) => Row(
  mainAxisSize: .min,
  spacing: 6,
  children: [
    moon(size * 1.6),
    Text(
      "${appController.moon}",
      style: TextStyle(
        color: Colors.white,
        fontFamily: f2,
        fontWeight: .bold,
        fontSize: size,
      ),
    ),
  ],
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
      border: .all(color: Colors.white),
    ),
    padding: .symmetric(horizontal: 22, vertical: 16),
    alignment: align,
    child: Row(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Text(
          m,
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontFamily: f2,
          ),
        ),
        if (hasIcon) Transform.flip(flipX: true, child: back(18)),
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
          (e) => Container(
            decoration: BoxDecoration(
              border: .symmetric(
                horizontal: curValue != null && e == curValue
                    ? BorderSide(color: Colors.white)
                    : .none,
              ),
            ),
            padding: .symmetric(vertical: 18),
            child: Text(
              format != null ? appController.numberFormat(format, e) : "$e",
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontSize: 20,
                fontFamily: f2,
              ),
            ),
          ),
        )
        .toList(),
  ),
);

Widget genderButton(
  bool isMale,
  VoidCallback tap, {
  double width = 24,
  bool iconBig = false,
  bool isCircle = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(isCircle ? 99 : 12),
      border: .all(color: Colors.white),
    ),
    padding: .all(iconBig ? 6 : 12),
    child: SvgPicture.asset(
      fit: .fitWidth,
      width: width,
      isMale
          ? "assets/icons/male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg"
          : "assets/icons/female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg",
    ),
  ),
);

Widget cloud() => Stack(
  fit: .loose,
  children: [
    Positioned(
      bottom: 48,
      right: 0,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: 24,
      left: -46,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: 12,
      right: -48,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: -8,
      left: -28,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: -22,
      right: 0,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
  ],
);

Widget input(String hint, Function(String m) submit) => TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: .circular(32),
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: .circular(32),
      borderSide: BorderSide(color: Colors.white),
    ),
    hintText: hint,
    hintStyle: TextStyle(color: Colors.white, fontFamily: f2),
    contentPadding: .symmetric(horizontal: 24, vertical: 18),
  ),
  style: TextStyle(color: Colors.white),
  onSubmitted: submit,
);

Widget moon(double size) => SizedBox(
  height: size * 0.8,
  child: ClipRect(
    child: Image.asset("assets/images/moon.png", fit: .fitWidth, width: size),
  ),
);

Widget button1(
  String m,
  VoidCallback tap, {
  double radius = 2,
  bool hasIcon = true,
  bool isMoon = false,
  bool isBack = true,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [gradY, purpleAccent],
        radius: radius,
        center: .topLeft,
      ),
      borderRadius: .circular(32),
      boxShadow: [BoxShadow(color: gradY, blurRadius: 6, offset: Offset(1, 3))],
    ),
    alignment: .center,
    padding: .symmetric(horizontal: 24, vertical: 16),
    child: Row(
      mainAxisSize: .min,
      spacing: 6,
      children: [
        if (isBack && !isMoon && hasIcon) back(24),
        if (isMoon && hasIcon) moon(38),

        Text(
          m,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: .bold,
          ),
        ),

        if (!isBack && !isMoon && hasIcon) Transform.flip(flipX: !isBack, child: back(24)),
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
      color: Colors.white.withAlpha(10),
      borderRadius: .circular(32),
    ),
    alignment: .center,
    padding: .symmetric(horizontal: 20, vertical: 16),
    child: Row(
      mainAxisSize: .min,
      children: [
        if (isBack && hasIcon) back(24),

        Text(
          m,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: .bold,
          ),
        ),

        if (!isBack && hasIcon) Transform.flip(flipX: !isBack, child: back(24)),
      ],
    ),
  ),
);

Widget back(double size) => SvgPicture.asset(
  "assets/icons/arrow_back.svg",
  fit: .fitWidth,
  width: size,
);
