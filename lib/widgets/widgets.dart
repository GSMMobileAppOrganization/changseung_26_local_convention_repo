import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/*Widget () =>*/

Widget outButton(String m, VoidCallback tap, {Alignment align = .centerLeft}) =>
    GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(32),
          border: .all(color: Colors.white),
        ),
        padding: .symmetric(horizontal: 22, vertical: 16),
        alignment: align,
        child: Text(
          m,
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontFamily: f2,
          ),
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
            alignment: .center,
            child: Text(
              format != null ? appController.numberFormat(format, e) : "$e",
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontSize: 18,
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
      children: [
        if (isBack) back(24),

        Text(
          m,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: .bold,
          ),
        ),

        if (!isBack) Transform.flip(flipX: !isBack, child: back(24)),
      ],
    ),
  ),
);

Widget button2(String m, VoidCallback tap, {bool isBack = true}) =>
    GestureDetector(
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
            if (isBack) back(24),

            Text(
              m,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),

            if (!isBack) Transform.flip(flipX: !isBack, child: back(24)),
          ],
        ),
      ),
    );

Widget back(double size) => SvgPicture.asset(
  "assets/icons/arrow_back.svg",
  fit: .fitWidth,
  width: size,
);
