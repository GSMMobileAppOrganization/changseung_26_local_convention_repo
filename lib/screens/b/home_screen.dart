import 'package:daily_tarot_poc_app_15/app_controller.dart';
import 'package:daily_tarot_poc_app_15/main.dart';
import 'package:daily_tarot_poc_app_15/screens/b/moon_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/b/soul_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_15/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_15/widgets/background.dart';
import 'package:daily_tarot_poc_app_15/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_15/widgets/widgets.dart';
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
            SizedBox(height: 8),

            LogoWidget(),

            SizedBox(height: 22),

            Column(
              spacing: 32,
              children: [
                toDayTarot(),

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
                  "Daily Tarot Soul Card",
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  pad: true,
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

  Widget toDayTarot() {
    final card = appController.getToDayCard();

    return Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [purple, deepPurple],
          begin: .topLeft,
          end: .bottomRight,
        ),
        borderRadius: .circular(16),
        boxShadow: [
          BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        spacing: 12,
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          titleW("오늘의 타로", size: 28, isF2: true),
          Flexible(
            child: Row(
              children: [
                cardWidget(appController.cardPath(card), 80),

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        titleW(
                          appController.dateFormat("y.MM.dd", DateTime.now()),
                        ),

                        SizedBox(height: 24),

                        SizedBox(
                          width: 200,
                          child: titleW(
                            card.storytelling.substring(
                              0,
                              card.storytelling.indexOf("."),
                            ),
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget moonCount() => GestureDetector(
    onTap: () {
      appController.go(context, MoonScreen());
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
      child: Row(
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
      boxShadow: [BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16)],
      borderRadius: .circular(16),
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
                mainAxisSize: .min,
                crossAxisAlignment: .end,
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

  Widget masterBox() => Container(
    clipBehavior: .hardEdge,
    decoration: BoxDecoration(
      boxShadow: [BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16)],
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  titleW("당신만을 위한 상담", size: 22, align: .start),
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

  Widget tarotBox(
    String path,
    String title,
    String content, {
    bool isBig = false,
  }) => Container(
    width: 220,
    height: 220,
    clipBehavior: .hardEdge,
    decoration: BoxDecoration(
      boxShadow: [BoxShadow(color: Colors.white.withAlpha(60), blurRadius: 16)],
      borderRadius: .circular(16),
    ),
    child: Stack(
      children: [
        Image.asset(path, fit: .fitWidth),
        Positioned.fill(
          child: Align(
            alignment: .bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontFamily: f2,
                        fontSize: isBig ? 20 : 18,
                      ),
                      text: title,
                      children: [
                        TextSpan(text: " 타로", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),

                  titleW(
                    content,
                    size: 14,
                    isF2: true,
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

  Widget section(String title, Widget child, {bool pad = false}) => Column(
    crossAxisAlignment: .start,
    spacing: 12,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: pad ? 18 : 0),
        child: titleW(title, size: 22),
      ),
      child,
    ],
  );
}
