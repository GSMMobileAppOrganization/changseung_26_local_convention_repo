import 'package:daily_tarot_poc_app_10/app_controller.dart';
import 'package:daily_tarot_poc_app_10/main.dart';
import 'package:daily_tarot_poc_app_10/screens/b/moon_screen.dart';
import 'package:daily_tarot_poc_app_10/screens/b/soul_screen.dart';
import 'package:daily_tarot_poc_app_10/widgets/background1.dart';
import 'package:daily_tarot_poc_app_10/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_10/widgets/widgets.dart';
import 'package:flutter/material.dart';

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

            SizedBox(height: 14),

            Column(
              spacing: 34,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: section("Daily Tarot Soul Card", _soulBox()),
                ),
                section(
                  "Daily Tarot List",
                  SingleChildScrollView(
                    padding: .symmetric(horizontal: 18),
                    scrollDirection: .horizontal,
                    child: Row(
                      spacing: 12,
                      children: [
                        GestureDetector(
                          onTap: () {
                            appController.showSnack(
                              context,
                              "현재 개발중인 서비스 입니다.",
                            );
                          },
                          child: _tarotBox(
                            "assets/images/love_tarot.png",
                            "인연",
                            "지금은 힘들지만 그래도,\n그 사람과 인연이 될 수 있을까?",
                            titleBig: true,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            appController.showSnack(
                              context,
                              "현재 개발중인 서비스 입니다.",
                            );
                          },
                          child: _tarotBox(
                            "assets/images/fruit_tarot.png",
                            "열매",
                            "지금 생각하고 있는 일은\n어떤 결과로 이어질까?",
                          ),
                        ),
                      ],
                    ),
                  ),
                  true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: section("Daily Master", _masterBox()),
                ),
              ],
            ),

            SizedBox(height: 96),
          ],
        ),
      ),
    );
  }

  Widget _soulBox() => GestureDetector(
    onTap: () {
      appController.go(context, SoulScreen());
    },
    child: Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(
        borderRadius: .circular(12),
        boxShadow: [
          BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16),
        ],
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
                  horizontal: 24,
                  vertical: 18,
                ),
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
    ),
  );

  Widget _masterBox() => GestureDetector(
    onTap: () {
      appController.goUrl("https://ko.wikipedia.org/wiki/타로");
    },
    child: Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(
        borderRadius: .circular(12),
        boxShadow: [
          BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16),
        ],
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
                  horizontal: 18,
                  vertical: 22,
                ),
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    titleW("당신만을 위한 상담", size: 22, align: .start),
                    titleW(
                      "당신을 위해 모인 ‘데일리마스터’와\n직접 이야기를 나누어 보세요.",
                      size: 18,
                      color: Colors.white70,
                      align: .start,
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

  Widget _tarotBox(
    String path,
    String title,
    String content, {
    bool titleBig = false,
  }) => Container(
    width: 210,
    height: 210,
    clipBehavior: .hardEdge,
    decoration: BoxDecoration(borderRadius: .circular(12)),
    child: Stack(
      children: [
        Image.asset(path, fit: .fitWidth),

        Positioned.fill(
          child: Align(
            alignment: .bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 18),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Text.rich(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: f2,
                      fontWeight: .bold,
                      fontSize: titleBig ? 22 : 20,
                    ),
                    textAlign: .start,
                    TextSpan(
                      text: title,
                      children: [
                        TextSpan(text: " 타로", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),

                  titleW(content, size: 13, align: .start, font: f2),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget moonCount() => Align(
    alignment: .topRight,
    child: GestureDetector(
      onTap: () {
        appController.go(context, MoonScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
        child: Row(
          mainAxisSize: .min,
          spacing: 2,
          children: [
            moon(36),
            title18W(appController.moon.toString(), font: f2),
          ],
        ),
      ),
    ),
  );

  Widget section(String title, Widget child, [bool pad = false]) => Column(
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
