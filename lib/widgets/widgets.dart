import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/screens/module_b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget closeButton(BuildContext context) => GestureDetector(
  onTap: () => appController.moveRemove(context, HomeScreen()),
  child: Container(
    decoration: BoxDecoration(
      shape: .circle,
      border: .all(color: Colors.white),
    ),
    padding: .all(12),
    child: Icon(Icons.close, size: 36, color: Colors.white),
  ),
);

Widget cardWidget(String path, double width) => Container(
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(borderRadius: .circular(8)),
  child: Image.asset(path, fit: .fitWidth, width: width),
);

Widget backButton(BuildContext context) => GestureDetector(
  onTap: () => appController.moveRemove(context, HomeScreen()),
  child: Padding(
    padding: .all(12),
    child: SvgPicture.asset(
      "assets/icons/arrow_back.svg",
      fit: .fitHeight,
      height: 24,
    ),
  ),
);

Widget moonCount(double size, int count) => Row(
  spacing: 8,
  mainAxisSize: .min,
  children: [
    moon(size * 1.5),
    Text(
      "$count",
      style: TextStyle(
        color: Colors.white,
        fontWeight: .bold,
        fontSize: size,
        fontFamily: f2,
      ),
    ),
  ],
);

Widget moon(double size) =>
    Image.asset("assets/images/moon.png", fit: .fitWidth, width: size);

Widget wheelList(
  List<int> list,
  Function(int value) change, {
  String? format,
  int? curValue,
}) {
  return ListWheelScrollView.useDelegate(
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
                  horizontal: curValue != null && curValue == e
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
                  fontFamily: f2,
                  fontSize: 18,
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}

Widget outButton(String m, VoidCallback tap, {bool hasIcon = false}) =>
    GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(323),
          border: .all(color: Colors.white),
        ),
        padding: .all(16),
        alignment: hasIcon ? .center : .centerLeft,
        child: Row(
          mainAxisSize: .min,
          children: [
            Text(
              m,
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontSize: 18,
              ),
            ),

            if (hasIcon)
              Transform.flip(
                flipX: true,
                child: SvgPicture.asset(
                  "assets/icons/arrow_back.svg",
                  fit: .fitHeight,
                  height: 20,
                ),
              ),
          ],
        ),
      ),
    );

Widget genderButton(
  String path,
  VoidCallback tap, {
  double size = 52,
  bool isCircle = false,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      shape: isCircle ? .circle : .rectangle,
      borderRadius: isCircle ? null : .circular(20),
      border: .all(color: Colors.white),
    ),
    padding: .all(isCircle ? 8 : 16),
    child: SvgPicture.asset(path, fit: .fitWidth, width: size),
  ),
);

Widget input(
  String m,
  Function(String m) submit, {
  TextEditingController? controller,
}) => TextField(
  style: TextStyle(color: Colors.white),
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: .all(.circular(32)),
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: .all(.circular(32)),
      borderSide: BorderSide(color: Colors.white),
    ),
    contentPadding: .symmetric(horizontal: 24, vertical: 16),
    hintText: m,
    hintStyle: TextStyle(fontFamily: f2, color: Colors.white),
  ),
  onSubmitted: submit,
  controller: controller,
);

Widget button1(
  String m,
  VoidCallback tap, {
  double radius = 1.5,
  bool isBack = false,
  bool hasMoon = false,
  bool hasIcon = true,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      gradient: RadialGradient(
        colors: [gradY, purpleAccent],
        center: .topLeft,
        radius: radius,
      ),
      boxShadow: [BoxShadow(color: gradY, blurRadius: 6, offset: Offset(1, 1))],
    ),
    alignment: .center,
    padding: .symmetric(vertical: 16),
    child: Row(
      mainAxisSize: .min,
      children: [
        if (hasMoon && hasIcon) ...{moon(32), SizedBox(width: 8)},

        Text(
          m,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: .bold,
          ),
        ),

        if (isBack && hasIcon) ...{
          Transform.flip(
            flipX: true,
            child: SvgPicture.asset(
              "assets/icons/arrow_back.svg",
              fit: .fitWidth,
              width: 24,
            ),
          ),
        },
      ],
    ),
  ),
);

Widget button2(
  String m,
  VoidCallback tap, {
  bool isBack = true,
  bool hasIcon = true,
  Alignment? align,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      color: Colors.white.withAlpha(20),
    ),
    alignment: align,
    padding: .symmetric(vertical: 16, horizontal: 24),
    child: Row(
      spacing: 12,
      mainAxisSize: .min,
      children: [
        if (isBack && hasIcon) ...{
          SizedBox(
            width: 16,
            child: ClipRect(
              clipBehavior: .hardEdge,
              child: Transform.flip(
                flipX: !isBack,
                child: SvgPicture.asset(
                  "assets/icons/arrow_back.svg",
                  fit: .fitHeight,
                  height: 24,
                ),
              ),
            ),
          ),
        },

        Text(
          m,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: .bold,
            fontFamily: f2,
          ),
        ),

        if (!isBack && hasIcon) ...{
          SizedBox(
            width: 16,
            child: ClipRect(
              clipBehavior: .hardEdge,
              child: Transform.flip(
                flipX: true,
                child: SvgPicture.asset(
                  "assets/icons/arrow_back.svg",
                  fit: .fitHeight,
                  height: 24,
                ),
              ),
            ),
          ),
        },
      ],
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
      bottom: 36,
      left: -12,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: 24,
      right: -36,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: -12,
      left: -12,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      bottom: -24,
      right: 12,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
  ],
);
