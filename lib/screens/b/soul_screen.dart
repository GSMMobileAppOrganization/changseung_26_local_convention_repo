import 'package:daily_tarot_poc_app_11/app_controller.dart';
import 'package:daily_tarot_poc_app_11/main.dart';
import 'package:daily_tarot_poc_app_11/screens/b/my_soul_screen.dart';
import 'package:daily_tarot_poc_app_11/widgets/background.dart';
import 'package:daily_tarot_poc_app_11/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_11/widgets/widgets.dart';
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

          LogoWidget(ver2: true, title: "나의 생일로 알아보는 소울카드"),

          SizedBox(height: 24),

          Text.rich(
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
            strutStyle: StrutStyle(height: 2.2),
          ),

          Spacer(),

          SizedBox(
            width: 250,
            child: outButton(
              date != null
                  ? appController.dateFormat("y년 M월 d일", date!)
                  : "생년월일을 선택해 주세요",
              () {
                showDialog(
                  context: context,
                  builder: (context) => datePicker(),
                );
              },
              align: .center,
              hasIcon: true,
              white: date != null,
            ),
          ),
          Spacer(),

          SizedBox(
            width: 320,
            child: button1(hasMoon: true, "달 10개로 소울카드 찾기", () {
              if (appController.moon < 10 || date == null) {
                appController.showSnack(
                  context,
                  date == null
                      ? "생일을 선택해 주십시오."
                      : "달 개수가 ${10 - appController.moon}만큼 부족합니다.",
                );

                return;
              }

              appController.addMoon(-10);
              appController.date = date;
              appController.goFade(context, MySoulScreen1(), dur: .zero);
            }),
          ),
          SizedBox(height: 12),
          title14W(
            size: 12,
            "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
            font: f2,
            align: .center,
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

    bool isError = false;

    return Dialog(
      child: Container(
        height: 300,
        clipBehavior: .hardEdge,
        decoration: BoxDecoration(borderRadius: .circular(16)),
        child: StatefulBuilder(
          builder: (context, set) => background(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  title20W("생년월일 선택", font: f2),
                  Expanded(
                    child: Container(
                      margin: .symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: .symmetric(
                          horizontal: BorderSide(color: Colors.white30),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: listWheel(
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
                          Expanded(
                            child: listWheel(
                              List.generate(12, (index) => index + 1),
                              (value) {
                                month = value;
                                set(() {});
                              },
                              month - 1,
                            ),
                          ),
                          Expanded(
                            child: listWheel(
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

                  Row(
                    spacing: 24,
                    mainAxisAlignment: .end,
                    children: [
                      if (isError)
                        title14W(
                          "오늘 이후의 날짜는\n선택할 수 없습니다.",
                          font: f2,
                          color: Colors.red,
                        ),
                      Spacer(),

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: title18W("취소", font: f2),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (appController.isNowDay(
                            DateTime(year, month, day),
                          )) {
                            isError = true;
                            set(() {});
                            return;
                          }
                          date = DateTime(year, month, day);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: title18W("선택", font: f2),
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

  TextSpan _w(String m) => TextSpan(
    text: m,
    style: TextStyle(color: Colors.white, fontWeight: .bold, fontFamily: f2),
  );

  TextSpan _y(String m) => TextSpan(
    text: m,
    style: TextStyle(color: yellow, fontWeight: .bold, fontFamily: f2),
  );
}
