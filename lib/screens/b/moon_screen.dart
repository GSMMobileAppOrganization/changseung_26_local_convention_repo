import 'package:daily_tarot_poc_app_15/main.dart';
import 'package:daily_tarot_poc_app_15/widgets/background.dart';
import 'package:daily_tarot_poc_app_15/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_15/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../app_controller.dart';

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

          SizedBox(height: 28),

          LogoWidget(ver2: true, title: "달 충전"),

          SizedBox(height: 24),

          titleW("현재 보유중인 달", isF2: true, size: 17),

          SizedBox(height: 8),

          moonCount(),

          SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: .zero,
              itemBuilder: (context, index) => moonItem(
                list[index].$1,
                list[index].$2,
                list[index].$3,
                index,
              ),
              separatorBuilder: (context, index) =>
                  Container(color: Colors.white30, height: 1.2),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget moonItem(int count, int discount, int price, int index) => ListTile(
    leading: moon2(index),
    contentPadding: .zero,
    onTap: () {
      appController.showSnack(context, "달 $count개가 충전되었습니다.");
      appController.addMoon(count);
      setState(() {});
    },
    title: Column(
      crossAxisAlignment: .start,
      children: [
        titleW(appController.numberFormat("달 #개", count), isF2: true, size: 17),
        titleW(
          appController.numberFormat("약 #,###원 할인", discount),
          isF2: true,
          size: 13,
          color: yellow,
        ),
      ],
    ),
    trailing: titleW(
      appController.numberFormat("#,###원", price),
      isF2: true,
      size: 17,
    ),
  );

  Widget moon2(int index) => Stack(
    children: [
      if (index >= 2) Positioned(right: -2, top: -2, child: moon(38)),

      if (index >= 4) Positioned(bottom: 0, right: 0, child: moon(12)),

      moon(52),
    ],
  );

  Widget moonCount() => Row(
    mainAxisAlignment: .center,
    spacing: 6,
    children: [
      moon(36),
      titleW(appController.moon.toString(), isF2: true, size: 20),
    ],
  );
}
