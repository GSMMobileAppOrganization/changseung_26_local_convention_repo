import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/main.dart';
import 'package:daily_tarot_poc_app_12/screens/b/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget cardWidget(String? path, double width) => Container(
  decoration: BoxDecoration(borderRadius: .circular(8)),
  clipBehavior: .hardEdge,
  child: Image.asset(
    path ?? "assets/images/tarot_card_back.png",
    fit: .fitWidth,
    width: width,
  ),
);

Widget backButton(BuildContext context) => Align(
  alignment: .topLeft,
  child: GestureDetector(
    onTap: () {
      appController.back(context, HomeScreen());
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 24, top: 12),
      child: back(24),
    ),
  ),
);

Widget listWheel(
  List<int> list,
  Function(int value) change,
  FixedExtentScrollController controller,
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
      overAndUnderCenterOpacity: .6,
      onSelectedItemChanged: (value) {
        change.call(list[value]);
      },
      controller: controller,
      childDelegate: ListWheelChildLoopingListDelegate(
        children: list
            .map(
              (e) => Center(
                child: title20W(
                  appController.numberFormat("00", e),
                  isF2: true,
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
  bool isCircle = false,
  double size = 52,
  double pad = 8,
  bool? initialValue,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      border: .all(
        color: initialValue == isMale ? Colors.white : Colors.white54,
        width: initialValue == isMale ? 2.0 : 1.6,
      ),
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

Widget outButton(String m, VoidCallback tap) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      border: .all(color: Colors.white54, width: 1.6),
      borderRadius: .circular(32),
    ),
    alignment: .centerLeft,
    padding: .symmetric(vertical: 14, horizontal: 24),
    child: titleW(m, isF2: true),
  ),
);

Widget input(
  String h,
  Function(String m) submit,
  String initialValue, {
  bool isN = false,
}) => TextField(
  decoration: InputDecoration(
    contentPadding: .symmetric(horizontal: 24, vertical: 14),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white54, width: 1.6),
      borderRadius: .circular(32),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: .circular(32),
    ),
    hint: titleW(h, isF2: true, align: .start, color: Colors.white54),
  ),
  keyboardType: isN ? .number : null,
  inputFormatters: isN ? [FilteringTextInputFormatter.digitsOnly] : null,
  onSubmitted: submit,
  controller: TextEditingController(text: initialValue),
  style: TextStyle(color: Colors.white, fontFamily: f2, fontWeight: .w500),
);

Widget button1(
  String m,
  VoidCallback tap, {
  bool hasIcon = true,
  Alignment align = .center,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [grad, accentPurple],
        center: .topLeft,
        radius: 2.2,
      ),
      boxShadow: [
        BoxShadow(
          color: grad.withAlpha(100),
          offset: .new(0, 8),
          blurRadius: 12,
        ),
      ],
      borderRadius: .circular(32),
    ),
    padding: .symmetric(vertical: 16),
    alignment: align,
    child: Row(
      spacing: 6,
      mainAxisSize: .min,
      children: [
        titleW(m),
        if(hasIcon)
        Transform.flip(flipX: true, child: back(22)),
      ],
    ),
  ),
);

Widget button2(
  String m,
  VoidCallback tap, {
  bool isBack = true,
  Alignment align = .center,
  bool hasIcon = true,
}) => GestureDetector(
  onTap: tap,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: .circular(32),
      color: Colors.white.withAlpha(20),
    ),
    padding: .symmetric(vertical: 14),
    alignment: align,
    child: Row(
      spacing: 6,
      mainAxisSize: .min,
      children: [
        if (isBack && hasIcon) back(26),
        titleW(m, isF2: true),
        if (!isBack && hasIcon) Transform.flip(flipX: true, child: back(26)),
      ],
    ),
  ),
);

Widget back(double size, {Color? color}) => SizedBox(
  width: size * .382,
  child: SvgPicture.asset(
    "assets/icons/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg",
    fit: .fitHeight,
    height: size,
    color: color,
  ),
);

Widget moon(double size) => SizedBox(
  height: size * .7,
  child: ClipRect(
    clipBehavior: .hardEdge,
    child: Image.asset("assets/images/moon.png", fit: .fitWidth, width: size),
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

Widget title28W(
  String m, {
  double size = 28,
  Color? color,
  double? height,
  FontWeight weight = .bold,
  TextAlign align = .center,
  bool isF2 = false,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: isF2 ? f2 : null,
    fontSize: size,
    fontWeight: weight,
  ),
  textAlign: align,
);

Widget title24W(
  String m, {
  double size = 24,
  Color? color,
  double? height,
  FontWeight weight = .bold,
  TextAlign align = .center,
  bool isF2 = false,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: isF2 ? f2 : null,
    fontSize: size,
    fontWeight: weight,
  ),
  textAlign: align,
);

Widget title20W(
  String m, {
  double size = 20,
  Color? color,
  double? height,
  FontWeight weight = .bold,
  TextAlign align = .center,
  bool isF2 = false,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: isF2 ? f2 : null,
    fontSize: size,
    fontWeight: weight,
  ),
  textAlign: align,
);

Widget title18W(
  String m, {
  double size = 18,
  Color? color,
  double? height,
  FontWeight weight = .bold,
  TextAlign align = .center,
  bool isF2 = false,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: isF2 ? f2 : null,
    fontSize: size,
    fontWeight: weight,
  ),
  textAlign: align,
);

Widget titleW(
  String m, {
  double size = 16,
  Color? color,
  double? height,
  FontWeight weight = .bold,
  TextAlign align = .center,
  bool isF2 = false,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: isF2 ? f2 : null,
    fontSize: size,
    fontWeight: weight,
  ),
  textAlign: align,
);

Widget title14W(
  String m, {
  double size = 14,
  Color? color,
  double? height,
  FontWeight weight = .bold,
  TextAlign align = .center,
  bool isF2 = false,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: isF2 ? f2 : null,
    fontSize: size,
    fontWeight: weight,
  ),
  textAlign: align,
);

Widget title22W(
  String m, {
  double size = 22,
  Color? color,
  double? height,
  FontWeight weight = .bold,
  TextAlign align = .center,
  bool isF2 = false,
}) => Text(
  m,
  style: TextStyle(
    color: color ?? Colors.white,
    height: height,
    fontFamily: isF2 ? f2 : null,
    fontSize: size,
    fontWeight: weight,
  ),
  textAlign: align,
);

Widget background({required Widget child, bool isClip = false}) => Container(
  clipBehavior: .hardEdge,
  padding: isClip ? .symmetric(vertical: 24) : null,
  decoration: BoxDecoration(
    borderRadius: isClip ? .circular(12) : null,
    gradient: LinearGradient(
      colors: [purple, deepPurple],
      begin: .topCenter,
      end: .bottomCenter,
    ),
  ),
  child: child,
);
