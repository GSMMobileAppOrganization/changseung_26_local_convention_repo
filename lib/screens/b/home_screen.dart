import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/main.dart';
import 'package:daily_tarot_poc_app_9/screens/b/moon_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/b/soul_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_9/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/background2.dart';
import 'package:daily_tarot_poc_app_9/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 18,
                ),
                child: GestureDetector(
                  onTap: () => appController.go(context, MoonScreen()),
                  child: moonCount(24),
                ),
              ),
            ),

            Padding(
              padding: .symmetric(horizontal: 18),
              child: Column(
                spacing: 24,
                children: [
                  LogoWidget(),

                  section(
                    "Daily Tarot Soul Card",
                    contentBox(
                      "assets/images/daily_tarot_soul_card.png",
                      "Soul Card",
                      "운명적인 나만의 데일리 카드!\n매일 하루 카운셀링 받으세요.",
                      () {
                        appController.go(context, SoulScreen());
                      },
                      align: .bottomRight,
                    ),
                  ),

                  section(
                    "Daily Tarot List",
                    SingleChildScrollView(
                      scrollDirection: .horizontal,
                      child: Row(
                        spacing: 12,
                        children: [
                          SizedBox.square(
                            dimension: 220,
                            child: contentBox(
                              "assets/images/love_tarot.png",
                              "인연 타로",
                              "지금은 힘들지만 그래도,\n그 사람과 인연이 될 수 있을까?",
                              () {
                                /*appController.showSnack(
                                  context,
                                  "현재 개발중인 서비스입니다. 이용하실 수 없습니다.",
                                );*/
                                appController.go(context, LoveScreen());
                              },
                              isF2: true,
                              align: .bottomLeft,
                              isLeft: true,
                            ),
                          ),

                          SizedBox.square(
                            dimension: 220,
                            child: contentBox(
                              "assets/images/fruit_tarot.png",
                              "열매 타로",
                              "지금 생각하고 있는 일은\n어떤 결과로 이어질까?",
                              () {
                                /*appController.showSnack(
                                  context,
                                  "현재 개발중인 서비스입니다. 이용하실 수 없습니다.",
                                );*/
                                appController.go(context, FruitScreen());
                              },
                              isF2: true,
                              align: .bottomLeft,
                              isLeft: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  section(
                    "Daily Master",
                    contentBox(
                      "assets/images/daily_master.png",
                      "당신만을 위한 상담",
                      "당신을 위해 모인 ‘데일리마스터’와\n직접 이야기를 나누어 보세요.",
                      () {
                        appController.goUrl("https://ko.wikipedia.org/wiki/타로");
                      },
                      align: .topLeft,
                      isExpand: true,
                      isLeft: true,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 108),
          ],
        ),
      ),
    );
  }

  Widget contentBox(
    String path,
    String title,
    String content,
    VoidCallback tap, {
    bool isExpand = false,
    bool isF2 = false,
    bool isLeft = false,
    required Alignment align,
  }) => GestureDetector(
    onTap: tap,
    child: Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        boxShadow: [BoxShadow(color: grad.withAlpha(160), blurRadius: 8)],
      ),
      child: Stack(
        children: [
          Image.asset(
            path,
            fit: .fitWidth,
            width: isExpand ? MediaQuery.widthOf(context) : null,
          ),
          Positioned.fill(
            child: Align(
              alignment: align,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: isLeft ? .start : .end,
                  children: [
                    title20W(
                      title,
                      size: isExpand ? 22 : 20,
                      align: isLeft ? .start : .end,
                      font: isF2 ? f2 : null,
                    ),
                    title14W(
                      content,
                      size: isExpand ? 17 : 14,
                      align: isLeft ? .start : .end,
                      color: Colors.white70,
                      font: isF2 ? f2 : null,
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

  Widget section(String title, Widget child) => Column(
    spacing: 12,
    crossAxisAlignment: .start,
    children: [title24W(title), child],
  );
}
