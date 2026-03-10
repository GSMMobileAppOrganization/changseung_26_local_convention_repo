import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:daily_tarot_poc_app_2/screens/moon_charge_screen.dart';
import 'package:daily_tarot_poc_app_2/screens/soul_card_screen.dart';
import 'package:daily_tarot_poc_app_2/widgets/background2.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_2/widgets/moon_view.dart';
import 'package:daily_tarot_poc_app_2/widgets/moon_widget.dart';
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
            spacing: 24,
            crossAxisAlignment: .start,
            children: [
              Align(
                alignment: .topRight,
                child: GestureDetector(
                  onTap: () async {
                    await appController.move(context, MoonChargeScreen());
                    setState(() {});
                  },
                  child: MoonView(),
                ),
              ),

              LogoWidget(),

              SizedBox(
                width: MediaQuery.widthOf(context),
                child: _section(
                  "Daily Tarot Soul Card",
                  _box(
                    "assets/images/daily_tarot_soul_card.png",
                    Align(
                      alignment: .bottomRight,
                      child: _content(
                        "Soul Card",
                        "운명적인 나만의 데일리 카드!\n매일 하루를 카운셀링 받으세요.",
                        .end,
                        .end,
                      ),
                    ),
                    () => appController.move(context, SoulCardScreen()),
                  ),
                ),
              ),

              _section(
                "Daily Tarot List",
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Row(
                    spacing: 12,
                    children: [
                      SizedBox.square(
                        dimension: 250,
                        child: _box(
                          "assets/images/love_tarot.png",
                          Align(
                            alignment: .bottomRight,
                            child: _content(
                              "인연 타로",
                              "지금은 힘들지만 그래도, 그 사람과 인연이 될 수 있을까?",
                              .start,
                              .start,
                            ),
                          ),
                          () => appController.showSnack(
                            context,
                            "아직 개발중인 서비스 입니다.",
                          ),
                        ),
                      ),
                      SizedBox.square(
                        dimension: 250,
                        child: _box(
                          "assets/images/fruit_tarot.png",
                          Align(
                            alignment: .bottomRight,
                            child: _content(
                              "열매 타로",
                              "지금 생각하고 있는 일은 어떤 결과로 이어질까?",
                              .start,
                              .start,
                            ),
                          ),
                          () => appController.showSnack(
                            context,
                            "아직 개발중인 서비스 입니다.",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: MediaQuery.widthOf(context),
                child: _section(
                  "Daily Master",
                  _box(
                    "assets/images/daily_master.png",
                    Align(
                      alignment: .topLeft,
                      child: _content(
                        "당신만을 위한 상담",
                        "당신을 위해 모인 ‘데일리마스터’와\n직접 이야기를 나누어 보세요.",
                        .start,
                        .start,
                      ),
                    ),
                    () => appController.moveUrl(
                      "https://ko.wikipedia.org/wiki/타로",
                    ),
                    MediaQuery.widthOf(context),
                  ),
                ),
              ),
              SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(
    String title,
    String content,
    CrossAxisAlignment align,
    TextAlign textAlign,
  ) => Padding(
    padding: .all(18),
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: align,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontSize: 20,
          ),
          textAlign: textAlign,
        ),
        Text(
          content,
          style: TextStyle(color: Colors.white, fontSize: 14),
          textAlign: textAlign,
        ),
      ],
    ),
  );

  Widget _box(String path, Widget child, VoidCallback tap, [double? width]) =>
      GestureDetector(
        onTap: tap,
        child: Container(
          clipBehavior: .hardEdge,
          decoration: BoxDecoration(borderRadius: .circular(18)),
          child: Stack(
            children: [
              Image.asset(path, fit: .fitWidth, width: width),
              Positioned.fill(child: child),
            ],
          ),
        ),
      );

  Widget _section(String title, Widget child) => Column(
    crossAxisAlignment: .start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontSize: 24,
          ),
        ),
      ),
      Center(child: child),
    ],
  );
}
