import 'package:daily_tarot_poc_app_7/app_controller.dart';
import 'package:daily_tarot_poc_app_7/main.dart';
import 'package:daily_tarot_poc_app_7/screesn/b/my_soul_screen.dart';
import 'package:daily_tarot_poc_app_7/widgets/background.dart';
import 'package:daily_tarot_poc_app_7/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_7/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SoulScreen extends StatefulWidget {
  const SoulScreen({super.key});

  @override
  State<SoulScreen> createState() => _SoulScreenState();
}

class _SoulScreenState extends State<SoulScreen> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Column(
        children: [
          backButton(context),

          SizedBox(height: 24,),

          LogoWidget(ver2: true, title: "나의 생일로 알아보는 소울카드"),

          Spacer(),

          Text.rich(
            style: TextStyle(fontFamily: f2, fontWeight: .bold, fontSize: 14, color: Colors.white),
            TextSpan(
              children: [
                _y("소울 넘버"),
                _w(
                  "는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이저 아르카나 타로 카드가 바로 ",
                ),
                _y("소울 카드"),
                _w(
                  "이며,\n이는 당신의 타고난 성격, 기질,\n그리고 삶의 목적을 상징합니다.\n즉, 소울 넘버는 당신의 ",
                ),
                _y("영혼의 번호"),
                _w("이고,\n소울 카드는 그 번호가 의미하는\n"),
                _y("영혼의 본질"),
                _w("을 보여주는 상징인 셈입니다."),
              ],
            ),
            textAlign: .center,
            strutStyle: StrutStyle(height: 2),
          ),

          Spacer(),

          SizedBox(
            width: 220,
            child: outButton(
              hasIcon: true,
              color: date != null ? Colors.white : Colors.white54,
              isSpace: date != null,
              align: date != null ? .centerLeft : .center,
              date != null
                  ? appController.dateFormat("y년 M월 d일", date!)
                  : "생년월일을 선택해 주세요",
              () {
                showDialog(
                  context: context,
                  builder: (context) => datePicker(),
                );
              },
            ),
          ),

          Spacer(),

          SizedBox(
            width: 270,
            child: button1("달 10개로 소울카드 찾기", () {
              if (appController.moon < 10 || date == null) {
                appController.showSnack(
                  context,
                  date == null
                      ? "생일을 입력해 주세요."
                      : "달 ${10 - appController.moon}개가 부족합니다.",
                );
                return;
              }

              appController.addMoon(-10);
              appController.date = date;
              appController.go(context, MySoulScreen1());
            }, hasMoon: true),
          ),

          SizedBox(height: 12),

          title12W(
            size: 10,
            "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
            align: .center,
            font: f2,
            color: Colors.white30,
          ),

          Spacer(flex: 3),
        ],
      ),
    );
  }

  Widget datePicker() {
    int year = date?.year ?? 1901;
    int month = date?.month ?? 1;
    int day = date?.day ?? 1;

    String error = "";

    return Dialog(
      child: Container(
        height: 300,
        clipBehavior: .hardEdge,
        decoration: BoxDecoration(borderRadius: .circular(12)),
        child: background(
          child: Padding(
            padding: .symmetric(horizontal: 24, vertical: 18),
            child: StatefulBuilder(
              builder: (context, set) => Column(
                crossAxisAlignment: .start,
                children: [
                  title20W("생년월일 선택", font: f2, align: .start),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          border: .symmetric(
                            horizontal: BorderSide(
                              color: Colors.white30,
                              width: 1.2,
                            ),
                          ),
                        ),
                        padding: .symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: wheelList(
                                List.generate(
                                  appController.getYear(1900),
                                  (index) => index + 1901,
                                ),
                                (value) {
                                  year = value;
                                  set(() {});
                                },
                                year - 1901,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: wheelList(
                                List.generate(12, (index) => index + 1),
                                (value) {
                                  month = value;
                                  set(() {});
                                },
                                month - 1,
                              ),
                            ),
                            Expanded(
                              child: wheelList(
                                List.generate(
                                  appController.lastDate(DateTime(year, month)),
                                  (index) => index + 1,
                                ),
                                (value) {
                                  day = value;
                                  set(() {});
                                },
                                day - 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: .end,
                    spacing: 24,
                    children: [
                      Align(
                        alignment: .centerLeft,
                        child: title12W(error, font: f2, color: Colors.red),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: title16W("취소", font: f2),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (appController.isNowDay(
                            DateTime(year, month, day),
                          )) {
                            error = "생년월일은 오늘 날짜보다\n이전 날짜만 선택 가능합니다.";
                            set(() {});
                            return;
                          }

                          date = DateTime(year, month, day);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: title16W("선택", font: f2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextSpan _y(String m) => TextSpan(
    text: m,
    style: TextStyle(color: yellow, fontSize: 12),
  );

  TextSpan _w(String m) => TextSpan(
    text: m,
    style: TextStyle(color: Colors.white, fontSize: 12),
  );
}
