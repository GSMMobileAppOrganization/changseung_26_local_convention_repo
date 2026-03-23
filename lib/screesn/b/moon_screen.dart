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
  List list = [
    (1, 25, 750, 5500),
    (1, 50, 2600, 9900),
    (2, 75, 4750, 14000),
    (2, 100, 8000, 17000),
    (3, 200, 17000, 33000),
    (3, 350, 32500, 55000),
  ];

  @override
  Widget build(BuildContext context) {
    return Background2(
      down: true,
      child: Column(
        children: [
          backButton(context),

          LogoWidget(ver2: true, title: "달 충전"),

          SizedBox(height: 24),

          title16W(size: 16, "현재 보유중인 달", font: f2),

          SizedBox(height: 12),
          moonCount(24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: ListView.separated(
              padding: .zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => moonItem(
                list[index].$1,
                list[index].$2,
                list[index].$3,
                list[index].$4,
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

  final double moonSize = 48;

  Widget moonItem(
    int moonCount,
    int count,
    int discount,
    int price,
    int index,
  ) => ListTile(
    onTap: () {
      appController.addMoon(count);
      appController.showSnack(context, "달 $count개가 충전되었습니다.");
      setState(() {});
    },
    contentPadding: .zero,
    leading: moon2(moonCount),
    title: Column(
      crossAxisAlignment: .start,
      children: [
        title16W(appController.numberFormat("달 #개", count), font: f2),
        title14W(
          size: 12,
          appController.numberFormat("약 #,###원 할인", discount),
          font: f2,
          color: yellow,
        ),
      ],
    ),

    trailing: title16W(
      appController.numberFormat("#,###원", price),
      font: f2,
    ),
  );
}
