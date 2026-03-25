import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/b/moon_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/b/soul_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/background.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
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
            Align(
              alignment: .topRight,
              child: GestureDetector(
                onTap: () {
                  appController.go(context, MoonScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 18,
                  ),
                  child: moonCount(22),
                ),
              ),
            ),

            Column(
              spacing: 24,
              children: [
                LogoWidget(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: section(
                    "Daily Tarot Soul Card",
                    GestureDetector(
                      onTap: () {
                        appController.go(context, SoulScreen());
                      },
                      child: _soulCard(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: section(
                    "Daily Tarot List",
                    SingleChildScrollView(
                      scrollDirection: .horizontal,
                      child: Row(
                        spacing: 12,
                        children: [
                          GestureDetector(
                            onTap: () {
                              /*appController.showSnack(
                                context,
                                "아직 개발중인 서비스 입니다.",
                              );*/
                              appController.go(context, LoveScreen());
                            },
                            child: _tarotCard(
                              "assets/images/love_tarot.png",
                              "인연 타로",
                              "지금은 힘들지만 그래도,\n그 사람과 인연이 될 수 있을까?",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              /*appController.showSnack(
                                context,
                                "아직 개발중인 서비스 입니다.",
                              );*/
                              appController.go(context, FruitScreen());
                            },
                            child: _tarotCard(
                              "assets/images/fruit_tarot.png",
                              "열매 타로",
                              "지금 생각하고 있는 일은\n어떤 결과로 이어질까?",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: section(
                    "Daily Master",
                    GestureDetector(
                      onTap: () {
                        appController.goUrl("https://ko.wikipedia.org/wiki/타로");
                      },
                      child: _dailyMaster(),
                    ),
                  ),
                ),

                SizedBox(height: 72),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _soulCard() => Container(
    clipBehavior: .hardEdge,
    decoration: BoxDecoration(
      borderRadius: .circular(8),
      boxShadow: [BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16)],
    ),
    child: Stack(
      children: [
        Image.asset("assets/images/daily_tarot_soul_card.png", fit: .fitWidth),
        Positioned.fill(
          child: Align(
            alignment: .bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                crossAxisAlignment: .end,
                mainAxisSize: .min,
                children: [
                  titleW("Soul Card", size: 18, align: .end),
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

  Widget _dailyMaster() => Container(
    clipBehavior: .hardEdge,
    decoration: BoxDecoration(
      borderRadius: .circular(8),
      boxShadow: [BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16)],
    ),
    child: Stack(
      children: [
        Image.asset(
          "assets/images/daily_master.png",
          fit: .fitWidth,
          width: .infinity,
        ),
        Positioned.fill(
          child: Align(
            alignment: .topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  titleW("당신만을 위한 상담", size: 21, align: .start),
                  titleW(
                    "당신을 위해 모인 ‘데일리마스터’와\n직접 이야기를 나누어 보세요.",
                    size: 17,
                    align: .start,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _tarotCard(String path, String title, String content) => Container(
    width: 210,
    height: 210,
    clipBehavior: .hardEdge,
    decoration: BoxDecoration(
      borderRadius: .circular(8),
      boxShadow: [BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16)],
    ),
    child: Stack(
      children: [
        Image.asset(path, fit: .fitWidth),
        Positioned.fill(
          child: Align(
            alignment: .bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  titleW(title, size: 18, align: .start, isF2: true),
                  titleW(content, size: 13, align: .start, isF2: true),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget section(String title, Widget child) => Column(
    crossAxisAlignment: .start,
    spacing: 12,
    children: [titleW(title, size: 22), child],
  );
}
