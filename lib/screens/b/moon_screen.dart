import 'package:daily_tarot_poc_app_10/app_controller.dart';
import 'package:daily_tarot_poc_app_10/main.dart';
import 'package:daily_tarot_poc_app_10/widgets/background1.dart';
import 'package:daily_tarot_poc_app_10/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_10/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MoonScreen extends StatefulWidget {
  const MoonScreen({super.key});

  @override
  State<MoonScreen> createState() => _MoonScreenState();
}

class _MoonScreenState extends State<MoonScreen> {
  List list = [
    (25, 750, 5500),
    (50, 2600, 9900),
    (75, 4750, 14000),
    (100, 8000, 17000),
    (200, 17000, 33000),
    (300, 32000, 55000),
  ];

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          backButton(context),

          SizedBox(height: 12),

          LogoWidget(ver2: true, title: "달 충전"),

          SizedBox(height: 24),

          titleW("현재 보유중인 달", font: f2, size: 18),
          SizedBox(height: 8),
          moonCount(),
          SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: .zero,
              shrinkWrap: true,
              itemBuilder: (context, index) => moonItem(
                list[index].$1,
                list[index].$2,
                list[index].$3,
                index,
              ),
              separatorBuilder: (context, index) =>
                  Container(height: 1.2, color: Colors.white30),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget moonItem(int count, int discount, int price, int index) => ListTile(
    onTap: () {
      appController.showSnack(context, "달 $count개가 충전 되었습니다.");
      appController.addMoon(count);
      setState(() {});
    },
    leading: moon2(index),
    contentPadding: .zero,
    title: Column(
      crossAxisAlignment: .start,
      children: [
        titleW(
          appController.numberFormat("달 #개", count),
          size: 17,
          font: f2,
          weight: .w500,
        ),
        titleW(
          appController.numberFormat("약 #,###원 할인", discount),
          size: 13,
          font: f2,
          color: yellow,
          weight: .w500,
        ),
      ],
    ),
    trailing: titleW(
      appController.numberFormat("#,###원", price),
      size: 17,
      font: f2,
    ),
  );

  Widget moonCount() => Row(
    mainAxisSize: .min,
    spacing: 4,
    children: [
      moon(34),
      titleW(appController.moon.toString(), font: f2, size: 22),
    ],
  );
}
