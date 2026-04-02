import 'dart:async';

import 'package:daily_tarot_poc_app_12/app_controller.dart';
import 'package:daily_tarot_poc_app_12/main.dart';
import 'package:daily_tarot_poc_app_12/screens/b/moon_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/b/soul_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_12/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_12/widgets/background.dart';
import 'package:daily_tarot_poc_app_12/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_12/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Background2(
      child: SingleChildScrollView(
        child: Column(
          children: [
            moonCount(),

            LogoWidget(),

            SizedBox(height: 24),

            Column(
              spacing: 32,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: section("Daily Tarot Soul Card", soulBox()),
                ),

                section(
                  pad: true,
                  "Daily Tarot List",
                  SingleChildScrollView(
                    scrollDirection: .horizontal,
                    padding: .symmetric(horizontal: 18),
                    child: Row(
                      spacing: 12,
                      children: [
                        tarotBox(
                          "assets/images/love_tarot.png",
                          "인연",
                          "지금은 힘들지만 그래도,\n그 사람과 인연이 될 수 있을까?",
                          () {
                            /*  appController.showSnack(context, "현재 개발중인 서비스입니다.");
                          */
                            appController.go(context, LoveScreen());
                          },
                          isBig: true,
                        ),
                        tarotBox(
                          "assets/images/fruit_tarot.png",
                          "열매",
                          "지금 생각하고 있는 일은\n어떤 결과로 이어질까?",
                          () {
                            /*  appController.showSnack(context, "현재 개발중인 서비스입니다.");
                          */
                            appController.go(context, FruitScreen());
                          },
                          isBig: false,
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: section("Daily Master", masterBox()),
                ),
              ],
            ),
            SizedBox(height: 98),
          ],
        ),
      ),
    );
  }

  Widget moonCount() {
    return GestureDetector(
      onTap: () async {
        appController.prevMoon = appController.moon;
        appController.go(context, MoonScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
        child: TweenAnimationBuilder(
          tween: IntTween(
            begin: appController.prevMoon,
            end: appController.moon,
          ),
          duration: Duration(milliseconds: 600),
          builder: (context, value, child) => Row(
            mainAxisAlignment: .end,
            spacing: 4,
            children: [
              if (appController.moon <= 0)
                titleW(
                  "달이 부족해요!\n충전하러 가기",
                  isF2: true,
                  size: 10,
                  color: Colors.grey,
                  align: .end,
                ),
              moon(32),
              titleW(
                "$value",
                isF2: true,
                size: 18,
                color: appController.moon <= 0 ? Colors.grey : null,
                weight: appController.moon > 50 ? .w900 : .bold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget soulBox() => GestureDetector(
    onTap: () {
      appController.go(context, SoulScreen());
    },
    child: Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16),
        ],
        borderRadius: .circular(16),
      ),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/daily_tarot_soul_card.png",
            fit: .fitWidth,
          ),
          Positioned.fill(
            child: Align(
              alignment: .bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: .end,
                  mainAxisSize: .min,
                  children: [
                    titleW("Soul Card", size: 20, align: .end),
                    titleW(
                      "운명적인 나만의 데일리 카드!\n매일 하루를 카운셀링 받으세요.",
                      size: 14,
                      align: .end,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget masterBox() => GestureDetector(
    onTap: () {
      launchUrl(Uri.parse("https://ko.wikipedia.org/wiki/타로"));
    },
    child: Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16),
        ],
        borderRadius: .circular(16),
      ),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/daily_master.png",
            fit: .fitWidth,
            width: MediaQuery.widthOf(context),
          ),
          Positioned.fill(
            child: Align(
              alignment: .topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    titleW("당신만을 위한 상담", size: 22, align: .start),
                    titleW(
                      "당신을 위해 모인 ‘데일리마스터’와\n직접 이야기를 나누어 보세요.",
                      size: 17,
                      align: .start,
                      color: Colors.white.withAlpha(180),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget tarotBox(
    String path,
    String title,
    String content,
    VoidCallback tap, {
    required bool isBig,
  }) => GestureDetector(
    onTap: tap,
    child: Container(
      width: 210,
      height: 210,
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(borderRadius: .circular(16)),
      child: Stack(
        children: [
          Image.asset(path, fit: .fitWidth),
          Positioned.fill(
            child: Align(
              alignment: .bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 18),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: .bold,
                          fontFamily: f2,
                          fontSize: isBig ? 21 : 20,
                        ),
                        text: title,
                        children: [
                          TextSpan(text: " 타로", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    titleW(content, size: 13, align: .start, isF2: true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget section(String title, Widget child, {bool pad = false}) => Column(
    crossAxisAlignment: .start,
    spacing: 12,
    children: [
      Padding(
        padding: EdgeInsets.only(left: pad ? 18 : 0),
        child: titleW(title, size: 22),
      ),
      child,
    ],
  );
}
