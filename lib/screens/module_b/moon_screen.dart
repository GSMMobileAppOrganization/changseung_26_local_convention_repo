import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/widgets/background2.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MoonScreen extends StatefulWidget {
  const MoonScreen({super.key});

  @override
  State<MoonScreen> createState() => _MoonScreenState();
}

class _MoonScreenState extends State<MoonScreen> {
  final List<(int, int, int)> list = [
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
          Align(alignment: .topLeft, child: backButton(context)),

          SizedBox(height: 28),

          LogoWidget(ver2: true, title: "달 충전"),
          SizedBox(height: 24),

          Text(
            "현재 보유중인 달",
            style: TextStyle(
              color: Colors.white,
              fontWeight: .bold,
              fontSize: 18,
            ),
          ),
          moonCount(24, appController.moon),

          SizedBox(height: 12),

          Padding(
            padding: .symmetric(horizontal: 24),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  moonItem(list[index].$1, list[index].$2, list[index].$3),
              separatorBuilder: (context, index) =>
                  Container(height: 0.5, color: Colors.white),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget moonItem(int count, int discount, int price) => GestureDetector(
    onTap: () {
      appController.addMoon(count);
      appController.showSnack(context, "달 $count개가 충전되었습니다.");
      setState(() {});
    },
    child: ListTile(
      contentPadding: .zero,
      leading: moon(48),
      title: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            "달 $count개",
            style: TextStyle(
              fontWeight: .bold,
              color: Colors.white,
              fontSize: 18,
              fontFamily: f2,
            ),
          ),
          Text(
            appController.numberFormat("약 #,###원 할인", discount),
            style: TextStyle(
              fontWeight: .bold,
              color: yellow,
              fontSize: 14,
              fontFamily: f2,
            ),
          ),
        ],
      ),
      trailing: Text(
        appController.numberFormat("#,###원", price),
        style: TextStyle(
          fontWeight: .bold,
          color: Colors.white,
          fontSize: 18,
          fontFamily: f2,
        ),
      ),
    ),
  );
}
