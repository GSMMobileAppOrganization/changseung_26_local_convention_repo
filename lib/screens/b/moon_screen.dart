import 'package:daily_tarot_poc_app_8/app_controller.dart';
import 'package:daily_tarot_poc_app_8/main.dart';
import 'package:daily_tarot_poc_app_8/widgets/background2.dart';
import 'package:daily_tarot_poc_app_8/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_8/widgets/widgets.dart';
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

          SizedBox(height: 24),

          LogoWidget(ver2: true, title: "달 충전"),

          SizedBox(height: 16),

          titleMW("현재 보유중인 달", font: f2),
          SizedBox(height: 6),
          moonCount(32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => moonItem(
                list[index].$1,
                list[index].$2,
                list[index].$3,
                index,
              ),
              separatorBuilder: (context, index) =>
                  Container(color: Colors.white54, height: 1.5),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget moonItem(int count, int discount, int price, int index) =>
      GestureDetector(
        onTap: () {
          appController.addMoon(count);
          appController.showSnack(context, "달 $count개가 충전되었습니다.");
          setState(() {});
        },
        child: ListTile(
          contentPadding: .zero,
          leading: index >= 2
              ? index >= 4
                    ? moon3(42)
                    : moon2(42)
              : moon(42),
          title: Column(
            crossAxisAlignment: .start,
            children: [
              titleMW(appController.numberFormat("달 #개", count), font: f2),
              titleSW(
                appController.numberFormat("약 #,###원 할인", discount),
                font: f2,
                color: yellow,
              ),
            ],
          ),
          trailing: titleMW(
            appController.numberFormat("#,###원", price),
            font: f2,
          ),
        ),
      );
}
