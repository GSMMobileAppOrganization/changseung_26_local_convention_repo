import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/widgets/background.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
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
      down: true,
      child: Column(
        children: [
          backButton(context),

          SizedBox(height: 32),

          LogoWidget(ver2: true, title: "달 충전"),

          SizedBox(height: 24),

          titleW("현재 보유중인 달", isF2: true, size: 16),

          SizedBox(height: 6),

          moonCount(24),

          SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ListView.separated(
              shrinkWrap: true,
              padding: .zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => moonItem(
                index,
                list[index].$1,
                list[index].$2,
                list[index].$3,
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

  Widget moonItem(int index, int count, int discount, int price) => ListTile(
    contentPadding: .zero,
    onTap: () {
      appController.showSnack(context, "달 $count개가 충전되었씁니다.");
      appController.addMoon(count);
      setState(() {});
    },
    leading: moon2(index),
    title: Column(
      crossAxisAlignment: .start,
      children: [
        titleW(appController.numberFormat("달 #개", count), isF2: true, size: 16),
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
      size: 16,
    ),
  );
}
