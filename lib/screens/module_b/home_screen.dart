import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/screens/module_b/moon_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_b/soul_card_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_c/fruit_screen.dart';
import 'package:daily_tarot_poc_app_3/screens/module_c/love_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/background2.dart';
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
      child: Padding(
        padding: .symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 18),

              Align(
                alignment: .topRight,
                child: GestureDetector(
                  onTap: () async {
                    await appController.move(context, MoonScreen());
                    setState(() {});
                  },
                  child: moonCount(16, appController.moon),
                ),
              ),

              SizedBox(height: 32),

              Center(child: LogoWidget()),

              SizedBox(height: 18),

              section(
                "Daily Tarot Soul Card",
                contentBox(
                  "assets/images/daily_tarot_soul_card.png",
                  "Soul Card",
                  "운명적인 나만의 데일리 카드!\n매일 하루를 카운셀링 받으세요.",
                  () => appController.move(context, SoulCardScreen()),
                  contentAlign: .bottomRight,
                  alignLeft: false,
                ),
              ),

              SizedBox(height: 18),

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
                          contentAlign: .bottomLeft,
                          alignLeft: true,
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
                          contentAlign: .bottomLeft,
                          alignLeft: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 18),

              section(
                "Daily Master",
                contentBox(
                  "assets/images/daily_master.png",
                  "당신만을 위한 상담",
                  "당신을 위해 모인 ‘데일리마스터’와\n직접 이야기를 나누어 보세요.",
                  () =>
                      appController.moveUrl("https://ko.wikipedia.org/wiki/타로"),
                  contentAlign: .topLeft,
                  alignLeft: true,
                  isExpand: true,
                ),
              ),

              SizedBox(height: 84),
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
    required Alignment contentAlign,
    required bool alignLeft,
    bool isExpand = false,
  }) => GestureDetector(
    onTap: tap,
    child: Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(borderRadius: .circular(12)),
      child: Stack(
        children: [
          Image.asset(path, fit: .fitWidth, width: isExpand ? .infinity : null),
          Positioned.fill(
            child: Align(
              alignment: contentAlign,
              child: Padding(
                padding: .all(16),
                child: Column(
                  crossAxisAlignment: alignLeft ? .start : .end,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontSize: 18,
                      ),
                      textAlign: alignLeft ? .start : .end,
                    ),

                    Text(
                      content,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontSize: 14,
                      ),
                      textAlign: alignLeft ? .start : .end,
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
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    spacing: 8,
    children: [
      Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: .bold),
      ),
      child,
    ],
  );
}
