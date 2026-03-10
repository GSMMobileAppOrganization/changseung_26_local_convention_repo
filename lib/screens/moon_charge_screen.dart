import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/widgets/back_icon_button.dart';
import 'package:daily_tarot_poc_app_1/widgets/background_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/moon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MoonChargeScreen extends StatefulWidget {
  const MoonChargeScreen({super.key});

  @override
  State<MoonChargeScreen> createState() => _MoonChargeScreenState();
}

class _MoonChargeScreenState extends State<MoonChargeScreen> {
  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          BackIconButton(),

          LogoWidget2(text: "달 충전"),

          SizedBox(height: 24),

          Text(
            "현재 보유중인 달",
            style: TextStyle(
              color: Colors.white,
              fontWeight: .bold,
              fontFamily: font2,
              fontSize: 18,
            ),
          ),
          Row(
            spacing: 8,
            mainAxisAlignment: .center,
            children: [
              MoonWidget(size: 36),
              Text(
                "${appController.moonCount}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .bold,
                  fontFamily: font2,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          Expanded(child: _chargeList()),
        ],
      ),
    );
  }

  final List<(int, int, int)> list = [
    (25, 750, 5500),
    (50, 2600, 9900),
    (75, 4750, 14000),
    (100, 8000, 17000),
    (200, 17000, 33000),
    (350, 32500, 55000),
  ];

  Widget _chargeList() => Padding(
    padding: .symmetric(horizontal: 24),
    child: ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          _chargeItem(list[index].$1, list[index].$2, list[index].$3),
      itemCount: list.length,
      separatorBuilder: (context, index) =>
          Divider(thickness: 1, color: Colors.white, height: 1),
    ),
  );

  Widget _chargeItem(int count, int disCount, int price) => ListTile(
    onTap: () {
      setState(() {
        appController.addMoon(count);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: purpleAccent,
            content: Text(
              "달 ${count}개가 충전되었습니다.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontFamily: font2,
                fontSize: 18,
              ),
            ),
          ),
        );
      });
    },
    contentPadding: .zero,
    leading: MoonWidget(size: 52),
    title: Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          "달 $count개",
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontFamily: font2,
            fontSize: 18,
          ),
        ),

        Text(
          "약 ${NumberFormat("#,###").format(disCount)}원 할인",
          style: TextStyle(color: yellow, fontFamily: font2, fontSize: 14),
        ),
      ],
    ),

    trailing: Text(
      "${NumberFormat("#,###").format(price)}원",
      style: TextStyle(
        color: Colors.white,
        fontWeight: .bold,
        fontFamily: font2,
        fontSize: 18,
      ),
    ),
  );
}
