import 'package:daily_tarot_poc_app_5/app_controller.dart';
import 'package:daily_tarot_poc_app_5/main.dart';
import 'package:daily_tarot_poc_app_5/screens/b/moon_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/b/soul_card_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_5/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_5/widgets/background2.dart';
import 'package:daily_tarot_poc_app_5/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
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
      child: Padding(
        padding: .symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 18),

              Align(
                alignment: .topRight,
                child: GestureDetector(
                  onTap: () => appController.move(context, MoonScreen()),
                  child: moonCount(30),
                ),
              ),

              SizedBox(height: 24),

              LogoWidget(),

              SizedBox(height: 24),

              Column(
                spacing: 24,
                children: [
                  section(
                    "Daily Tarot Soul Card",
                    contentBox(
                      "assets/images/daily_tarot_soul_card.png",
                      "Soul Card",
                      "운명적인 나만의 데일리 카드!\n매일 하루를 카운셀링 받으세요.",
                      () => appController.move(context, SoulCardScreen()),
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
                                );
                                */
                                appController.move(context, LoveScreen());
                              },
                              align: .bottomLeft,
                              isLeft: true,
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
                              isLeft: true,
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
                      () => appController.moveUrl(
                        "https://ko.wikipedia.org/wiki/타로",
                      ),
                      align: .topLeft,
                      isLeft: true,
                      isExpand: true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 98),
            ],
          ),
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
    required bool isLeft,
    bool isExpand = false,
    bool isF2 = false,
  }) => GestureDetector(
    onTap: tap,
    child: Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(borderRadius: .circular(12)),
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
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisSize: .min,
                  spacing: 2,
                  crossAxisAlignment: isLeft ? .start : .end,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontSize: 20,
                        fontFamily: isF2 ? f2 : null,
                      ),
                      textAlign: isLeft ? .start : .end,
                    ),
                    Text(
                      content,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
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
    children: [
      Text(
        m,
        style: TextStyle(color: Colors.white, fontWeight: .bold, fontSize: 24),
      ),
      child,
    ],
  );
}
