import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/main.dart';
import 'package:daily_tarot_poc_app_7/widgets/background.dart';
import 'package:daily_tarot_poc_app_7/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
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


          LogoWidget(ver2: true, title: "달 충전"),

          SizedBox(height: 24),

          title18W("현재 보유중인 달", font: f2),

          SizedBox(height: 12),
          moonCount(32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: ListView.separated(
              padding: .zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => moonItem(
                list[index].$1,
                list[index].$2,
                list[index].$3,
                index,
              ),
              separatorBuilder: (context, index) =>
                  Container(color: Colors.white10, height: 1.6),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }

  final double moonSize = 52;

  Widget moonItem(int count, int discount, int price, int index) => ListTile(
    onTap: () {
      appController.addMoon(count);
      appController.showSnack(context, "달 $count개가 충전되었습니다.");
      setState(() {});
    },
    contentPadding: .zero,
    leading: index >= 2
        ? index >= 4
              ? moon3(moonSize)
              : moon2(moonSize)
        : moon(moonSize),
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
    trailing: title18W(
      appController.numberFormat("#,###원", discount),
      font: f2,
    ),
  );
}
