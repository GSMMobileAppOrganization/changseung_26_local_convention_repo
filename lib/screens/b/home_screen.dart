import 'package:daily_tarot_poc_app_6/app_controller.dart';
import 'package:daily_tarot_poc_app_6/main.dart';
import 'package:daily_tarot_poc_app_6/screens/b/moon_screen.dart';
import 'package:daily_tarot_poc_app_6/screens/b/soul_screen.dart';
import 'package:daily_tarot_poc_app_6/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_6/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/background2.dart';
import 'package:daily_tarot_poc_app_6/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
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
                onTap: () => appController.move(context, MoonScreen()),
                child: Padding(padding: .all(12), child: moonCount(32)),
              ),
            ),

            Padding(
              padding: .symmetric(horizontal: 18, vertical: 24),
              child: Column(
                spacing: 24,
                children: [
                  LogoWidget(),
                  section(
                    "Daily Tarot Soul Card",
                    contentBox(
                      "assets/images/daily_tarot_soul_card.png",
                      "Soul Card",
                      "운명적인 나만의 데일리 카드!\n매일 하루를 카운셀링 받으세요.",
                      () {
                        appController.move(context, SoulScreen());
                      },
                      align: .bottomRight,
                      isLeft: false,
                    ),
                  ),
                  section(
                    "Daily Tarot List",
                    SingleChildScrollView(
                      scrollDirection: .horizontal,
                      child: Row(
                        spacing: 18,
                        children: [
                          SizedBox.square(
                            dimension: 250,
                            child: contentBox(
                              "assets/images/love_tarot.png",
                              "인연 타로",
                              "지금은 힘들지만 그래도,\n그 사람과 인연이 될 수 있을까?",
                              () {
                                /*appController.showSnack(
                                  context,
                                  "아직 개발중인 서비스 입니다.",
                                );*/

                                appController.move(context, LoveScreen());
                              },
                              align: .bottomLeft,
                              isF2: true,
                            ),
                          ),

                          SizedBox.square(
                            dimension: 250,
                            child: contentBox(
                              "assets/images/fruit_tarot.png",
                              "열매 타로",
                              "지금 생각하고 있는 일은\n어떤 결과로 이어질까?",
                              () {
                                /*appController.showSnack(
                                  context,
                                  "아직 개발중인 서비스 입니다.",
                                );*/

                                appController.move(context, FruitScreen());
                              },
                              align: .bottomLeft,
                              isF2: true,
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
                      () => appController.goUrl(
                        "https://ko.wikipedia.org/wiki/타로",
                      ),
                      align: .topLeft,
                      isExpand: true,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 58),
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
    required Alignment align,
    bool isLeft = true,
    bool isExpand = false,
    bool isF2 = false,
  }) => GestureDetector(
    onTap: tap,
    child: Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(borderRadius: .circular(8)),
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
                padding: .all(12),
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: isLeft ? .start : .end,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: .bold,
                        fontFamily: isF2 ? f2 : null,
                      ),
                      textAlign: isLeft ? .start : .end,
                    ),

                    Text(
                      content,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: .w500,
                        fontFamily: isF2 ? f2 : null,
                      ),
                      textAlign: isLeft ? .start : .end,
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

  Widget section(String m, Widget child) => Column(
    crossAxisAlignment: .start,
    spacing: 12,
    children: [titleW(m), child],
  );
}
