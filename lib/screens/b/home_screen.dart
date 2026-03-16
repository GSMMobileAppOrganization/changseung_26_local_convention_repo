import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/screens/b/moon_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/background2.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/widgets.dart';
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
                onTap: () => appController.go(context, MoonScreen()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 24,
                  ),
                  child: moonCount(30),
                ),
              ),
            ),

            LogoWidget(),

            SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                spacing: 24,
                children: [
                  section(
                    "Daily Tarot Soul Card",
                    contentBox(
                      "assets/images/daily_tarot_soul_card.png",
                      "Soul Card",
                      "운명적인 나만의 데일리 카드!\n매일 하루를 카운셀링 받으세요.",
                      isLeft: false,
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
                            dimension: 200,
                            child: contentBox(
                              "assets/images/love_tarot.png",
                              "연인 타로",
                              "지금은 힘들지만 그래도,\n그 사람과 인연이 될 수 있을까?",
                              isLeft: true,
                              align: .bottomLeft,
                              isF2: true,
                            ),
                          ),
                          SizedBox.square(
                            dimension: 200,
                            child: contentBox(
                              "assets/images/fruit_tarot.png",
                              "열매 타로",
                              "지금 생각하고 있는 일은\n어떤 결과로 이어질까?",
                              isLeft: true,
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
                      "당신을 위해 모인 ‘데일리마스터’와\n직접 이야기를 나누어 보세요",
                      isLeft: true,
                      isExpand: true,
                      align: .topLeft,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget contentBox(
    String path,
    String title,
    String content, {
    required bool isLeft,
    bool isExpand = false,
    bool isF2 = false,
    required Alignment align,
  }) => Container(
    clipBehavior: .hardEdge,
    decoration: BoxDecoration(
      borderRadius: .circular(12),
      boxShadow: [BoxShadow(color: grad.withAlpha(120), blurRadius: 16)],
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
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: isLeft ? .start : .end,
                children: [
                  title18W(
                    title,
                    size: isExpand ? 20 : 18,
                    weight: .bold,
                    align: isLeft ? .start : .end,
                    font: isF2 ? f2 : null,
                  ),
                  title16W(
                    content,
                    size: isExpand ? 16 : 12,
                    align: isLeft ? .start : .end,
                    font: isF2 ? f2 : null,
                    color: isExpand ? Colors.white.withAlpha(200) : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget section(String m, Widget child) => Column(
    spacing: 12,
    crossAxisAlignment: .start,
    children: [title20W(m, size: 22), child],
  );
}
