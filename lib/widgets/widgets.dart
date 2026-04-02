import 'package:daily_tarot_poc_app_10/app_controller.dart';
import 'package:daily_tarot_poc_app_10/main.dart';
import 'package:daily_tarot_poc_app_10/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget cardWidget(String path, double width) => Container(
  clipBehavior: .hardEdge,
  decoration: BoxDecoration(borderRadius: .circular(8)),
  child: Image.asset(path, width: width),
);

Widget backButton(BuildContext context) => Align(
  alignment: .topLeft,
  child: GestureDetector(
    onTap: () {
      appController.back(context, HomeScreen());
    },
    child: Padding(
      padding: .symmetric(horizontal: 18, vertical: 12),
      child: back(24),
    ),
  ),
);

Widget outButton(String m, VoidCallback tap) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      border: .all(color: Colors.white, width: 1.5),
    ),
    alignment: .centerStart,
    padding: .symmetric(horizontal: 24, vertical: 14),
    child: titleW(m, color: Colors.white, font: f2, weight: .w500),
  ),
);

Widget listWheel(
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
            Container(color: Colors.white30, width: 14, height: 1.2),
            SizedBox(height: 60),
            Container(color: Colors.white30, width: 14, height: 1.2),
          ],
        ),
      ),
    ),

    ListWheelScrollView.useDelegate(
      itemExtent: 60,
      diameterRatio: 15,
      overAndUnderCenterOpacity: .5,
      controller: FixedExtentScrollController(initialItem: initialValue),
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
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

Widget input({
  required String h,
  required Function(String m) submit,
  bool isNum = false,
  String? initialValue,
}) => TextField(
  keyboardType: isNum ? .number : null,
  inputFormatters: isNum ? [FilteringTextInputFormatter.digitsOnly] : null,
  decoration: InputDecoration(
    contentPadding: .symmetric(horizontal: 24, vertical: 14),
    enabledBorder: OutlineInputBorder(
      borderRadius: .circular(32),
      borderSide: BorderSide(color: Colors.white54, width: 1.6),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: .circular(32),
      borderSide: BorderSide(color: Colors.white, width: 1.6),
    ),
    hint: titleW(h, font: f2, color: Colors.white54),
  ),
  controller: TextEditingController(text: initialValue),
  style: TextStyle(color: Colors.white, fontWeight: .w500, fontFamily: f2),
  onSubmitted: submit,
);

Widget button1(String m, VoidCallback tap, {double radius = 2.2}) =>
    GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [grad, purple],
            radius: radius,
            center: .topLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: grad.withAlpha(160),
              offset: .new(0, 8),
              blurRadius: 16,
            ),
          ],
          borderRadius: .circular(32),
        ),
        alignment: .center,
        padding: .symmetric(vertical: 16),
        child: Row(
          spacing: 4,
          mainAxisSize: .min,
          children: [
            title18W(m, weight: .w800),
            Transform.flip(flipX: true, child: back(24)),
          ],
        ),
      ),
    );

Widget button2(String m, VoidCallback tap, {bool isBack = true}) =>
    GestureDetector(
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
            if (isBack) back(26),

            titleW(m, font: f2),

            if (!isBack) Transform.flip(flipX: true, child: back(26)),
          ],
        ),
      ),
    );

Widget genderButton(
  bool isMale,
  VoidCallback tap, {
  bool isCircle = false,
  double size = 52,
  double pad = 10,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(isCircle ? 99 : 18),
      border: .all(
        color: isCircle ? Colors.white : Colors.white.withAlpha(160),
        width: 1.6,
      ),
    ),
    padding: .all(pad),
    child: SvgPicture.asset(
      isMale ? "assets/icons/male.svg" : "assets/icons/female.svg",
      fit: .fitWidth,
      width: size,
    ),
  ),
);

Widget back(double size) => SizedBox(
  width: size * .6,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: SvgPicture.asset(
      "assets/icons/arrow_back.svg",
      fit: .fitHeight,
      height: size,
    ),
  ),
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

Widget moon(double size) => SizedBox(
  height: size * .8,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: Image.asset("assets/images/moon.png", fit: .fitWidth, width: size),
  ),
);

Widget moon2(int index) => Stack(
  children: [
    if (index >= 2)
      Positioned.fill(
        child: Align(alignment: .topRight, child: moon(28)),
      ),
    if (index >= 4)
      Positioned.fill(
        child: Align(alignment: .bottomRight, child: moon(12)),
      ),
    moon(44),
  ],
);

Widget cloud() => Stack(
  children: [
    Positioned(
      right: -12,
      bottom: 48,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -24,
      bottom: 36,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      right: -72,
      bottom: 24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      left: -12,
      bottom: -24,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
    Positioned(
      right: 0,
      bottom: -36,
      child: Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250),
    ),
  ],
);

Widget title28W(
  String m, {
  double size = 28,
  String? font,
  double? height,
  Color? color,
  FontWeight weight = .bold,
  TextAlign? align,
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

Widget title24W(
  String m, {
  double size = 24,
  String? font,
  double? height,
  Color? color,
  FontWeight weight = .bold,
  TextAlign? align,
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

Widget title20W(
  String m, {
  double size = 20,
  String? font,
  double? height,
  Color? color,
  FontWeight weight = .bold,
  TextAlign? align,
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

Widget title18W(
  String m, {
  double size = 18,
  String? font,
  double? height,
  Color? color,
  FontWeight weight = .bold,
  TextAlign? align,
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

Widget titleW(
  String m, {
  double size = 16,
  String? font,
  double? height,
  Color? color,
  FontWeight weight = .bold,
  TextAlign? align,
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
