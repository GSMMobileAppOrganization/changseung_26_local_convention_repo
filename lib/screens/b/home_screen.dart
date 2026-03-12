import 'package:daily_tarot_poc_app_4/app_controller.dart';
import 'package:daily_tarot_poc_app_4/main.dart';
import 'package:daily_tarot_poc_app_4/screens/b/moon_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/b/soul_card_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_4/screens/c/love_screen.dart';
import 'package:daily_tarot_poc_app_4/widgets/background2.dart';
import 'package:daily_tarot_poc_app_4/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_4/widgets/widgets.dart';
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
        child: Padding(
          padding: .symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(height: 16),

              Align(
                alignment: .topRight,
                child: GestureDetector(
                  onTap: () => appController.move(context, MoonScreen()),
                  child: moonCount(18),
                ),
              ),

              SizedBox(height: 28),

              LogoWidget(),

              SizedBox(height: 24),

              section(
                "Daily Tarot Soul Card",
                contentBox(
                  "Soul Card",
                  "운명적인 나만의 데일리 카드!\n매일 하루를 카운셀링 받으세요.",
                  "assets/images/daily_tarot_soul_card.png",
                  () => appController.move(context, SoulCardScreen()),
                  isLeft: false,
                  align: .bottomRight,
                ),
              ),
              SizedBox(height: 32),

              section(
                "Daily Tarot List",
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Row(
                    spacing: 12,
                    children: [
                      SizedBox.square(
                        dimension: 250,
                        child: contentBox(
                          "인연 타로",
                          "지금은 힘들지만 그래도,\n그 사람과 인연이 될 수 있을까?",
                          "assets/images/love_tarot.png",
                          () {
                            /*appController.showSnack(
                              context,
                              "아직 준비중인 서비스 입니다.",
                            );*/
                            appController.move(context, LoveScreen());
                          },
                          isLeft: true,
                          align: .bottomLeft,
                          isF2: true,
                        ),
                      ),
                      SizedBox.square(
                        dimension: 250,
                        child: contentBox(
                          "열매 타로",
                          "지금 생각하고 있는 일은\n어떤 결과로 이어질까?",
                          "assets/images/fruit_tarot.png",
                          () {
                            /*appController.showSnack(
                              context,
                              "아직 준비중인 서비스 입니다.",
                            );*/
                            appController.move(context, FruitScreen());
                          },
                          isLeft: true,
                          align: .bottomLeft,
                          isF2: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),

              section(
                "Daily Master",
                contentBox(
                  "당신만을 위한 상담",
                  "당신을 위해 모인 ‘데일리마스터’와\n직접 이야기를 나누어 보세요.",
                  "assets/images/daily_master.png",
                  () =>
                      appController.moveUrl("https://ko.wikipedia.org/wiki/타로"),
                  isLeft: true,
                  align: .topLeft,
                  isExpand: true,
                ),
              ),

              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget contentBox(
    String title,
    String content,
    String path,
    VoidCallback tap, {
    required bool isLeft,
    required Alignment align,
    bool isExpand = false,
    bool isF2 = false,
  }) => GestureDetector(
    onTap: tap,
    child: Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(borderRadius: .circular(16)),
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
                padding: .all(16),
                child: Column(
                  crossAxisAlignment: isLeft ? .start : .end,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontSize: 18,
                        fontFamily: isF2 ? f2 : null,
                      ),
                      textAlign: isLeft ? .start : .end,
                    ),
                    SizedBox(height: 6),
                    Text(
                      content,
                      style: TextStyle(color: Colors.white, fontWeight: .bold),
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
    spacing: 10,
    children: [
      Text(
        m,
        style: TextStyle(color: Colors.white, fontWeight: .bold, fontSize: 24),
      ),

      child,
    ],
  );
}
