import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/main.dart';
import 'package:daily_tarot_poc_app_9/widgets/background2.dart';
import 'package:daily_tarot_poc_app_9/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MoonScreen extends StatefulWidget {
  const MoonScreen({super.key});

  @override
  State<MoonScreen> createState() => _MoonScreenState();
}

class _MoonScreenState extends State<MoonScreen> {
  List<(int, int, int)> list = [
    (25, 750, 5500),
    (50, 2600, 9900),
    (75, 4750, 14000),
    (100, 8000, 17000),
    (200, 17000, 33000),
    (350, 32500, 55000),
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

          title18W("현재 보유중인 달", font: f2),
          SizedBox(height: 8),
          moonCount(26),

          SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => moonItem(
                list[index].$1,
                list[index].$2,
                list[index].$3,
                index,
              ),
              separatorBuilder: (context, index) =>
                  Container(height: 1.2, color: Colors.white.withAlpha(80)),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget moonItem(int count, int discount, int price, int index) => ListTile(
    onTap: () {
      appController.addMoon(count);
      appController.showSnack(context, "달 $count개가 충전되었습니다.");
      setState(() {});
    },
    contentPadding: .zero,
    leading: index >= 2
        ? index >= 4
              ? moon3(48)
              : moon2(48)
        : moon(48),
    title: Column(
      crossAxisAlignment: .start,
      children: [
        title18W(appController.numberFormat("달 #개", count), font: f2),
        title14W(
          appController.numberFormat("약 #,###원 할인", discount),
          font: f2,
          color: yellow,
        ),
      ],
    ),
    trailing: title18W(appController.numberFormat("#,###원", price), font: f2),
  );
}
