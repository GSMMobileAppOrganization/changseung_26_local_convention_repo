import 'package:daily_tarot_poc_app_14/app_controller.dart';
import 'package:daily_tarot_poc_app_14/main.dart';
import 'package:daily_tarot_poc_app_14/screens/b/soul_screen.dart';
import 'package:daily_tarot_poc_app_14/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_14/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_14/widgets/background.dart';
import 'package:daily_tarot_poc_app_14/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_14/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'moon_screen.dart';

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

            SizedBox(height: 32),

            LogoWidget(),

            SizedBox(height: 24),

            Column(
              spacing: 34,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: section(
                    "Daily Tarot Soul Card",
                    GestureDetector(
                      onTap: () {
                        appController.go(context, SoulScreen());
                      },
                      child: soulBox(),
                    ),
                  ),
                ),

                section(
                  pad: true,
                  "Daily Tarot List",
                  SingleChildScrollView(
                    padding: .symmetric(horizontal: 18),
                    scrollDirection: .horizontal,
                    child: Row(
                      spacing: 12,
                      children: [
                        GestureDetector(
                          onTap: () {
                            /*appController.showSnack(
                              context,
                              "현재 개발중인 서비스 입니다.",
                            );*/
                            appController.go(context, LoveScreen());
                          },
                          child: tarotBox(
                            "assets/images/love_tarot.png",
                            "인연",
                            "지금은 힘들지만 그래도,\n그 사람과 인연이 될 수 있을까?",
                            isBig: true,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            /*appController.showSnack(
                              context,
                              "현재 개발중인 서비스 입니다.",
                            );*/
                            appController.go(context, FruitScreen());
                          },
                          child: tarotBox(
                            "assets/images/fruit_tarot.png",
                            "열매",
                            "지금 생각하고 있는 일은\n어떤 결과로 이어질까?",
                            isBig: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: section(
                    "Daily Master",
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                          Uri.parse("https://ko.wikipedia.org/wiki/타로"),
                        );
                      },
                      child: masterBox(),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 98),
          ],
        ),
      ),
    );
  }

  Widget moonCount() => GestureDetector(
    onTap: () {
      appController.go(context, MoonScreen());
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 28, right: 18),
      child: Row(
        spacing: 4,
        mainAxisAlignment: .end,
        children: [
          moon(32),
          titleW(appController.moon.toString(), isF2: true, size: 18),
        ],
      ),
    ),
  );

  Widget soulBox() => Container(
    clipBehavior: .hardEdge,
    decoration: BoxDecoration(
      borderRadius: .circular(16),
      boxShadow: [BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16)],
    ),
    child: Stack(
      children: [
        Image.asset("assets/images/daily_tarot_soul_card.png", fit: .fitWidth),

        Positioned.fill(
          child: Align(
            alignment: .bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .end,
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
  );

  Widget masterBox() => Container(
    clipBehavior: .hardEdge,
    decoration: BoxDecoration(
      borderRadius: .circular(16),
      boxShadow: [BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16)],
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
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
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
  );

  Widget tarotBox(
    String path,
    String title,
    String content, {
    required bool isBig,
  }) => Container(
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
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: f2,
                        fontWeight: .bold,
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
  );

  Widget section(String m, Widget child, {bool pad = false}) => Column(
    crossAxisAlignment: .start,
    spacing: 12,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: pad ? 18 : 0),
        child: titleW(m, size: 22),
      ),
      child,
    ],
  );
}
