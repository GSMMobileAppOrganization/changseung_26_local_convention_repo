import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:daily_tarot_poc_app_2/widgets/back_icon_button.dart';
import 'package:daily_tarot_poc_app_2/widgets/background.dart';
import 'package:daily_tarot_poc_app_2/widgets/background2.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_2/widgets/moon_view.dart';
import 'package:daily_tarot_poc_app_2/widgets/moon_widget.dart';
import 'package:flutter/material.dart';

class MoonChargeScreen extends StatefulWidget {
  const MoonChargeScreen({super.key});

  @override
  State<MoonChargeScreen> createState() => _MoonChargeScreenState();
}

class _MoonChargeScreenState extends State<MoonChargeScreen> {
  List<(int, int, int)> list = [
    (25, 750, 5500),
    (50, 2600, 9900),
    (75, 4750, 14000),
    (100, 8000, 17000),
    (200, 17000, 33000),
    (300, 32000, 55000),
  ];

  /*달 그래픽, “달 25개” 텍스트, “약 750원
  할인” 텍스트, “5,500원” 텍스트
  2) 달 그래픽, “달 50개” 텍스트, “약
  2,600원 할인” 텍스트, “9,900원” 텍스트
  3) 달 그래픽, “달 75개” 텍스트, “약
  4,750원 할인” 텍스트, “14,000원” 텍스트
  4) 달 그래픽, “달 100개” 텍스트, “약
  8,000원 할인” 텍스트, “17,000원” 텍스트
  5) 달 그래픽, “달 200개” 텍스트, “약
  17,000원 할인” 텍스트, “33,000원”
  텍스트
  6) 달 그래픽, “달 300개” 텍스트, “약
  32,000원 할인” 텍스트, “55,000원”*/

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          BackIconButton(),
          LogoWidget(ver2: true, title: "달 출전"),

          _countView(),

          Expanded(
            child: Padding(
              padding: .symmetric(horizontal: 12),
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    _item(list[index].$1, list[index].$2, list[index].$3),
                separatorBuilder: (context, index) =>
                    Divider(height: 1, thickness: 1, color: Colors.white),
                itemCount: list.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _countView() => Column(
    mainAxisSize: .min,
    children: [_text("현재 보유중인 달"), MoonView(isBig: true)],
  );

  Widget _text(String m) => Text(
    m,
    style: TextStyle(
      fontFamily: font2,
      fontWeight: .bold,
      color: Colors.white,
      fontSize: 18,
    ),
  );

  Widget _item(int count, int discount, int price) => ListTile(
    onTap: () {
      setState(() {
        appController.addMoonCount(count);
        appController.showSnack(context, "달 $count개가 구입되었습니다.");
      });
    },
    contentPadding: .zero,
    leading: MoonWidget(size: 42),
    title: Column(
      crossAxisAlignment: .start,
      children: [
        _text("달 $count개"),
        Text(
          appController.numberFormat("약 #,###원 할인", discount),
          style: TextStyle(
            color: yellow,
            fontSize: 14,
            fontWeight: .bold,
            fontFamily: font2,
          ),
        ),
      ],
    ),
    trailing: _text(appController.numberFormat("#,###원", price)),
  );
}
