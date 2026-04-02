import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/main.dart';
import 'package:daily_tarot_poc_app_12/widgets/background.dart';
import 'package:daily_tarot_poc_app_12/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
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

  List listB = ["가장 인기", "최고 혜택", "가장 인기", "최고 혜택", "가장 인기", "최고 혜택"];

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          backButton(context),

          SizedBox(height: 48),

          LogoWidget(title: "달 충전", ver2: true),

          SizedBox(height: 22),

          titleW("현재 보유중인 달", isF2: true, size: 17),
          SizedBox(height: 8),

          moonCount(),

          SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
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

  Widget moonItem(int count, int disCount, int price, int index) => Badge(
    label: titleW(listB[index], isF2: true, size: 12),
    offset: .new(-30, 0),
    child: ListTile(
      leading: moon2(index),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: purple,
            contentPadding: .all(16),
            title: Container(
              decoration: BoxDecoration(
                border: .symmetric(
                  horizontal: BorderSide(color: Colors.white, width: 1.2),
                ),
              ),
              margin: .symmetric(vertical: 12),
              padding: .symmetric(vertical: 12),
              child: titleW("달 $count개를\n충전하시겠습니까?", isF2: true, size: 20),
            ),
            actionsAlignment: .spaceEvenly,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: titleW("취소", isF2: true),
              ),
              GestureDetector(
                onTap: () {
                  appController.moon = appController.save<int>(
                    appController.moon + count,
                    appController.moonKey,
                  )!;
                  setState(() {});
                  appController.changeMoon = true;
                  Navigator.pop(context);
                },
                child: titleW("확인", isF2: true),
              ),
            ],
          ),
        );
      },
      contentPadding: .zero,
      title: Column(
        crossAxisAlignment: .start,
        children: [
          titleW(
            appController.numberFormat("달 #개", count),
            isF2: true,
            size: 17,
          ),
          titleW(
            appController.numberFormat("약 #,###원 할인", disCount),
            color: yellow,
            isF2: true,
            size: 13,
          ),
        ],
      ),
      trailing: titleW(
        appController.numberFormat("#,###원", price),
        isF2: true,
        size: 17,
      ),
    ),
  );

  Widget moon2(int index) => Stack(
    children: [
      if (index >= 2) Positioned(top: -2, right: -2, child: moon(28)),
      if (index >= 4) Positioned(bottom: 0, right: 0, child: moon(12)),
      moon(42),
    ],
  );

  Widget moonCount() => Row(
    mainAxisAlignment: .center,
    spacing: 4,
    children: [
      moon(34),
      titleW(appController.moon.toString(), isF2: true, size: 20),
    ],
  );
}
