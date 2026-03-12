import 'package:daily_tarot_poc_app_5/main.dart';
import 'package:daily_tarot_poc_app_5/screens/b/my_soul_card_screen1.dart';
import 'package:daily_tarot_poc_app_5/widgets/background2.dart';
import 'package:daily_tarot_poc_app_5/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_5/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../app_controller.dart';

class SoulCardScreen extends StatefulWidget {
  const SoulCardScreen({super.key});

  @override
  State<SoulCardScreen> createState() => _SoulCardScreenState();
}

class _SoulCardScreenState extends State<SoulCardScreen> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Background2(
      child: Center(
        child: Column(
          children: [
            backButton(context),

            SizedBox(height: 18),

            LogoWidget(ver2: true, title: "나의 생일로 알아보는 소울카드"),

            SizedBox(height: 32),

            Text.rich(
              TextSpan(
                children: [
                  _yellow("소울 넘버"),
                  _white(
                    "는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이저 아르카나 타로 카드가 바로",
                  ),
                  _yellow("소울 카드"),
                  _white(
                    "이며,\n이는 당신의 타고난 성격, 기질,\n그리고 삶의 목적을 상징합니다.\n즉, 소울 넘버는 당신의 ",
                  ),
                  _yellow("영혼의 번호"),
                  _white("이고,\n소울 카드는 그 번호가 의미하는\n영혼의 본질"),
                  _yellow("을 보여주는 상징인 셈입니다."),
                ],
              ),
              textAlign: .center,
              strutStyle: StrutStyle(height: 2.2),
            ),

            SizedBox(height: 32),

            SizedBox(
              width: 250,
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
                hasIcon: true,
                algin: .center,
              ),
            ),

            SizedBox(height: 48),

            SizedBox(
              width: 290,
              child: button1(
                "달 10개로 소울카드 찾기",
                () {
                  if (date == null || appController.moon < 10) {
                    appController.showSnack(
                      context,
                      date == null ? "생일을 입력해 주세요" : "달의 개수가 부족합니다.",
                    );
                    return;
                  }


                  appController.date = date;
                  appController.move(context, MySoulCardScreen1());

                },
                isBack: false,
                hasMoon: true,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
              style: TextStyle(
                color: Colors.white.withAlpha(160),
                fontFamily: f2,
                fontSize: 12,
              ),
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }

  Widget datePicker() {
    DateTime tempDate = appController.getInitialDate();

    return Dialog(
      child: background(
        radius: 12,
        height: 318,
        Padding(
          padding: .symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                "생년월일 선택",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .bold,
                  fontFamily: f2,
                  fontSize: 20,
                ),
              ),

              Padding(
                padding: .symmetric(vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
                    border: .symmetric(
                      horizontal: BorderSide(color: Colors.white),
                    ),
                  ),
                  padding: .symmetric(vertical: 12),
                  height: 200,
                  child: StatefulBuilder(
                    builder: (context, set) => Row(
                      children: [
                        Expanded(
                          child: wheelList(
                            List.generate(
                              appController.getYear(),
                              (index) => index + 1901,
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
                spacing: 24,
                mainAxisAlignment: .end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "취소",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontFamily: f2,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      date = tempDate;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text(
                      "선택",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontFamily: f2,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan _white(String m) => TextSpan(
    text: m,
    style: TextStyle(color: Colors.white, fontFamily: f2, fontWeight: .bold),
  );

  TextSpan _yellow(String m) => TextSpan(
    text: m,
    style: TextStyle(color: yellow, fontFamily: f2, fontWeight: .bold),
  );
}
