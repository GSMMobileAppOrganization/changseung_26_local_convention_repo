import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/screens/moon_charge_screen.dart';
import 'package:daily_tarot_poc_app_1/screens/soul_card_screen.dart';
import 'package:daily_tarot_poc_app_1/widgets/background_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/moon_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void showPopup() => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: purple,
      content: Text(
        "아직 기능 준비 중에 있는 서비스 입니다..",
        style: TextStyle(color: Colors.white, fontWeight: .bold),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: SingleChildScrollView(
        child: Padding(
          padding: .symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 18),

              Align(
                alignment: .centerRight,
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoonChargeScreen(),
                      ),
                    );
                    setState(() {});
                  },
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      MoonWidget(size: 24),
                      Text(
                        "${appController.moonCount}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: .bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),

              LogoWidget(),

              _section(
                "Daily Tarot Soul Card",
                _image(
                  "assets/images/daily_tarot_soul_card.png",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SoulCardScreen()),
                  ),
                  _text(
                    "Soul Card",
                    "운명적인 나만의 데일리 카드!\n 매일 하루를 카운셀링 받으세요.",
                    align: .bottomRight,
                    textAlign: .end,
                  ),
                  width: MediaQuery.widthOf(context) - 24,
                  isLight: true,
                ),
              ),

              SizedBox(height: 24),

              _section(
                "Daily Tarot List",
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Row(
                    spacing: 12,
                    children: [
                      _image(
                        "assets/images/love_tarot.png",
                        () => showPopup(),
                        _text(
                          "인연 타로",
                          "지금은 힘들지만 그래도,\n그 사람과 인연이 될 수 있을까?",
                          align: .bottomLeft,
                          textAlign: .start,
                        ),
                        width: 250,
                      ),
                      _image(
                        "assets/images/fruit_tarot.png",
                        () => showPopup(),
                        _text(
                          "열매 타로",
                          "지금 생각하고 있는 일은\n어떤 결과로 이어질까?",
                          align: .bottomLeft,
                          textAlign: .start,
                        ),
                        width: 250,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),

              _section(
                "Daily Master",
                _image(
                  "assets/images/daily_master.png",
                  () {
                    print(":dsfdsf");
                    appController.moveUrl("https://ko.wikipedia.org/wiki/타로");
                  },_text(
                    "당신만을 위한 상담",
                    "당신을 위해 모인 ‘데일리마스터’와\n직접 이야기를 나누어 보세요.",
                    align: .topLeft,
                    textAlign: .start,
                  ),
                  width: MediaQuery.widthOf(context) - 24,
                  isLight: true,
                ),
              ),

              SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image(
    String path,
    VoidCallback tap,
    Widget child, {
    double? width,
    bool isLight = false,
  }) => GestureDetector(
    onTap: tap,
    child: Stack(
      children: [
        Container(
          clipBehavior: .hardEdge,
          decoration: BoxDecoration(
            borderRadius: .circular(12),
            boxShadow: isLight
                ? [BoxShadow(color: gradY, spreadRadius: 0, blurRadius: 8)]
                : null,
          ),
          child: Image.asset(path, fit: .fitWidth, width: width),
        ),

        Positioned.fill(child: child),
      ],
    ),
  );

  Widget _text(
    String title,
    String content, {
    required Alignment align,
    required TextAlign textAlign,
  }) => Align(
    alignment: align,
    child: Padding(
      padding: .all(18),
      child: Column(
        mainAxisSize: .min,
        children: [
          Align(
            alignment: align,
            child: Text(
              title,
              softWrap: true,
              textAlign: textAlign,
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontSize: 18,
              ),
            ),
          ),

          Align(
            alignment: align,
            child: Text(
              content,
              softWrap: true,
              textAlign: textAlign,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _section(String title, Widget child) => Column(
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    children: [
      Padding(
        padding: .symmetric(vertical: 8),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontSize: 24,
          ),
        ),
      ),
      Flexible(child: child),
    ],
  );
}
