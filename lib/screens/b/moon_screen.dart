import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/main.dart';
import 'package:daily_tarot_poc_app_5/widgets/background2.dart';
import 'package:daily_tarot_poc_app_5/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
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
      child: Center(
        child: Column(
          children: [
            backButton(context),

            SizedBox(height: 24),

            LogoWidget(ver2: true, title: "달 충전"),

            SizedBox(height: 24),

            Text(
              "현재 보유중인 달",
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontFamily: f2,
                fontSize: 16,
              ),
            ),

            moonCount(32),
            SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    moonItem(list[index].$1, list[index].$2, list[index].$3),
                separatorBuilder: (context, index) =>
                    Container(color: Colors.white, height: .5),
                itemCount: list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget moonItem(int count, int discount, int price) => GestureDetector(
    onTap: () {
      appController.addMoon(count);
      setState(() {});
      appController.showSnack(context, "달 $count개가 충전되었습니다.");
    },
    child: ListTile(
      contentPadding: .zero,
      leading: moon(52),
      title: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            appController.numberFormat("달 #개", count),
            style: TextStyle(
              color: Colors.white,
              fontWeight: .bold,
              fontFamily: f2,
              fontSize: 16,
            ),
          ),

          Text(
            appController.numberFormat("약 #,###원 할인", discount),
            style: TextStyle(
              color: yellow,
              fontWeight: .bold,
              fontFamily: f2,
              fontSize: 14,
            ),
          ),
        ],
      ),
      trailing: Text(
        appController.numberFormat("#,###원", price),
        style: TextStyle(
          color: Colors.white,
          fontWeight: .bold,
          fontFamily: f2,
          fontSize: 16,
        ),
      ),
    ),
  );
}
