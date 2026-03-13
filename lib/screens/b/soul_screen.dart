import 'package:daily_tarot_poc_app_6/main.dart';
import 'package:daily_tarot_poc_app_6/screens/b/my_soul_screen.dart';
import 'package:daily_tarot_poc_app_6/widgets/background2.dart';
import 'package:daily_tarot_poc_app_6/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_6/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../app_controller.dart';

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

          SizedBox(height: 24),

          LogoWidget(title: "나의 생일로 알아보는 소울카드", ver2: true),

          SizedBox(height: 38),

          Text.rich(
            TextSpan(
              children: [
                _yellow("소울 넘버"),
                _white(
                  "는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이저 아르카나 타로 카는가 바로",
                ),
                _yellow("소울 카드"),
                _white(
                  "이며,\n이는 당신의 타고난 성격, 기질\n그리고 삶의 목저글 상징합니다.\n즉, 소울 넘버는 당신의 ",
                ),
                _yellow("행운의 번호"),
                _white("이고,\n소울 카드는 그 번호가 의미하는\n"),
                _yellow("영혼의 본질"),
                _white("을 보여주는 상징인 셈입니다."),
              ],
            ),
            textAlign: .center,
            strutStyle: StrutStyle(height: 2.2),
          ),

          Spacer(),

          SizedBox(
            width: 280,
            child: outButton(
              date != null
                  ? appController.dateFormat("y/M/d", date!)
                  : "생년월일을 선택해주세요",
              () {
                showDialog(
                  context: context,
                  builder: (context) => datePicker(),
                );
              },
              align: .center,
              hasIcon: true,
            ),
          ),

          Spacer(),

          SizedBox(
            width: 320,
            child: button1("달 10개로 소울카드 찾기", () {
              if (date == null || appController.moon < 10) {
                appController.showSnack(
                  context,
                  date == null ? "생일을 입력해 주세요" : "달 개수가 부족합니다.",
                );
                return;
              }

              appController.date = date;
              appController.minusMoon(10);
              appController.move(context, MySoulScreen1());
            }, hasMoon: true),
          ),
          SizedBox(height: 12),

          titleSSW(
            "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
            font: f2,
            color: Colors.white.withAlpha(100),
          ),

          Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget datePicker() {
    DateTime tempDate = DateTime(1900, 1, 1);

    return Dialog(
      child: background(
        height: 310,
        radius: 12,
        Padding(
          padding: .symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              titleMW("샌년원일 선택", font: f2),
              Padding(
                padding: .symmetric(vertical: 12),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: .symmetric(
                      horizontal: BorderSide(color: Colors.white),
                    ),
                  ),
                  child: StatefulBuilder(
                    builder: (context, set) => Row(
                      children: [
                        Expanded(
                          child: wheelList(
                            List.generate(
                              appController.getYear(DateTime(1900)),
                              (index) => index + 1900,
                            ),
                            (value) {
                              tempDate = DateTime(
                                value,
                                tempDate.month,
                                tempDate.day,
                              );
                              set(() {});
                              setState(() {});
                            },
                            curValue: tempDate.year,
                          ),
                        ),
                        Expanded(
                          child: wheelList(
                            List.generate(
                              appController.getMonth(tempDate),
                              (index) => index + 1,
                            ),
                            (value) {
                              tempDate = DateTime(
                                tempDate.year,
                                value,
                                tempDate.day,
                              );
                              set(() {});
                              setState(() {});
                            },
                            curValue: tempDate.month,
                          ),
                        ),

                        Expanded(
                          child: wheelList(
                            List.generate(
                              appController.getDay(tempDate),
                              (index) => index + 1,
                            ),
                            (value) {
                              tempDate = DateTime(
                                tempDate.year,
                                tempDate.month,
                                value,
                              );
                              set(() {});
                              setState(() {});
                            },
                            curValue: tempDate.day,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: titleSW("취소", font: f2),
                  ),

                  GestureDetector(
                    onTap: () {
                      date = tempDate;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: titleSW("선택", font: f2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan _yellow(String m) => TextSpan(
    text: m,
    style: TextStyle(
      color: yellow,
      fontSize: 16,
      fontWeight: .bold,
      fontFamily: f2,
    ),
  );

  TextSpan _white(String m) => TextSpan(
    text: m,
    style: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: .bold,
      fontFamily: f2,
    ),
  );
}
