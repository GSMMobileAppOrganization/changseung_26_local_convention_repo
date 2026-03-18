import 'package:daily_tarot_poc_app_9/app_controller.dart';
import 'package:daily_tarot_poc_app_9/main.dart';
import 'package:daily_tarot_poc_app_9/screens/b/my_soul_screen.dart';
import 'package:daily_tarot_poc_app_9/widgets/background2.dart';
import 'package:daily_tarot_poc_app_9/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_9/widgets/widgets.dart';
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

          SizedBox(height: 12),

          LogoWidget(ver2: true, title: "나의 생일로 알아보는 소울카드"),

          Spacer(),
          Text.rich(
            TextSpan(
              children: [
                y("소울 넘버"),
                w(
                  "는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이저 아르카나 타로 카드가 바로 ",
                ),
                y("소울 카드"),
                w("이며,\n이는 당신의 타고난 성격, 기질,\n그리고 삶의 목적을 상징합니다.\n즉, 소울 넘버는 당신의 "),
                y("영혼의 번호"),
                w("이고,\n소울 카드는 그 번호가 의미하는\n"),
                y("영혼의 본질"),
                w("을 보여주는 상징인 셈입니다."),
              ],
            ),
            textAlign: .center,
            strutStyle: StrutStyle(height: 2.2),
          ),

          Spacer(),

          SizedBox(
            width: 260,
            child: outButton(
              date != null
                  ? appController.dateFormat("y/MM/dd", date!)
                  : "생년월일을 선택해 주세요",
              () {
                showDialog(
                  context: context,
                  builder: (context) => datePicker(),
                );
              },
              align: .center,
              hasBack: true,
            ),
          ),

          Spacer(),

          SizedBox(
            width: 320,
            child: button1("달 10개로 소울카드 찾기", () {
              if (appController.moon < 10 || date == null) {
                appController.showSnack(
                  context,
                  date == null
                      ? "생일을 입력해 주십시오"
                      : "달 개수가 부족합니다. 남은 달 개수 : ${appController.moon}",
                );
                return;
              }
              appController.addMoon(-10);
              appController.date = date;
              appController.go(context, MySoulScreen1());
            }, isMoon: true),
          ),
          SizedBox(height: 12),
          title12W(
            "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
            color: Colors.white54,
            align: .center,
            font: f2,
            weight: .w500,
          ),

          Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget datePicker() {
    int year = date?.year ?? appController.initialDate().year;
    int month = date?.month ?? appController.initialDate().month;
    int day = date?.day ?? appController.initialDate().day;

    bool error = false;

    return Dialog(
      clipBehavior: .hardEdge,
      constraints: .tightFor(height: 300),
      child: background(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: StatefulBuilder(
            builder: (context, set) => Column(
              crossAxisAlignment: .start,
              children: [
                title20W("생년월일 선택", font: f2),

                Expanded(
                  child: Padding(
                    padding: .symmetric(vertical: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: .symmetric(
                          horizontal: BorderSide(
                            color: Colors.white54,
                            width: 1.2,
                          ),
                        ),
                      ),
                      padding: .symmetric(vertical: 12),
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

                          SizedBox(width: 12),

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
                ),
                Row(
                  mainAxisAlignment: .end,
                  spacing: 24,
                  children: [
                    if (error)
                      title14W(
                        "오늘 이후의 날짜는\n선택하실 수 없습니다.",
                        color: Colors.white,
                        font: f2,
                        weight: .w500,
                        size: 12,
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
                          error = true;
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
    );
  }

  TextSpan y(String m) => TextSpan(
    text: m,
    style: TextStyle(
      color: yellow,
      fontFamily: f2,
      fontWeight: .bold,
      fontSize: 14,
    ),
  );

  TextSpan w(String m) => TextSpan(
    text: m,
    style: TextStyle(
      color: Colors.white,
      fontFamily: f2,
      fontWeight: .bold,
      fontSize: 14,
    ),
  );
}
