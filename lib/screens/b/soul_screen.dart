import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/screens/b/my_soul_screen.dart';
import 'package:daily_tarot_poc_app_3/widgets/background.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
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
          SizedBox(height: 36),
          LogoWidget(ver2: true, title: "나의 생일로 알아보는 소울카드"),

          SizedBox(height: 32),

          Text.rich(
            style: TextStyle(
              color: Colors.white,
              fontFamily: f2,
              fontWeight: .bold,
              fontSize: 13,
            ),
            TextSpan(
              children: [
                TextSpan(
                  text: "소울 넘버",
                  style: TextStyle(
                    color: yellow,
                    fontFamily: f2,
                    fontWeight: .bold,
                    fontSize: 13,
                  ),
                ),
                TextSpan(
                  text:
                      "는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이저 타로 카드가 바로 ",
                ),
                TextSpan(
                  text: "소울 카드",
                  style: TextStyle(
                    color: yellow,
                    fontFamily: f2,
                    fontWeight: .bold,
                    fontSize: 13,
                  ),
                ),
                TextSpan(
                  text:
                      "이며,\n이는 당신의 타고난 성격, 기질,\n그리고 삶의 목적을 상징합니다.\n즉, 소울 넘버는 당신의 ",
                ),
                TextSpan(
                  text: "영혼의 번호",
                  style: TextStyle(
                    color: yellow,
                    fontFamily: f2,
                    fontWeight: .bold,
                    fontSize: 13,
                  ),
                ),
                TextSpan(text: "이고,\n소울 카드는 그 번호가 의미하는\n"),
                TextSpan(
                  text: "영혼의 본질",
                  style: TextStyle(
                    color: yellow,
                    fontFamily: f2,
                    fontWeight: .bold,
                    fontSize: 13,
                  ),
                ),
                TextSpan(text: "을 보여주는 상징인 셈입니다."),
              ],
            ),
            textAlign: .center,
            strutStyle: StrutStyle(height: 2),
          ),
          Spacer(),
          dateButton(),
          Spacer(),
          moonButton(),
          SizedBox(height: 12),
          titleW(
            "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
            isF2: true,
            size: 11,
            align: .center,
            color: Colors.white30,
          ),

          Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget datePicker() {
    DateTime tempDate = date ?? DateTime(1901, 1, 1);
    bool error = false;

    void updateDate(StateSetter set, {int? y, int? m, int? d}) {
      int newY = y ?? tempDate.year;
      int newM = m ?? tempDate.month;
      int newD = d ?? tempDate.day;

      final maxD = appController.lastDate(DateTime(newY, newM));

      if (newD > maxD) {
        newD = maxD;
      }

      tempDate = DateTime(newY, newM, newD);
      set(() {});
    }

    return Dialog(
      constraints: .tightFor(height: 300),
      child: Container(
        clipBehavior: .hardEdge,
        decoration: BoxDecoration(borderRadius: .circular(16)),
        child: background(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
            child: StatefulBuilder(
              builder: (context, set) => Column(
                crossAxisAlignment: .start,
                children: [
                  titleW("생년월일 선택", size: 20, isF2: true),
                  Expanded(
                    child: Container(
                      margin: .symmetric(vertical: 12),
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
                            child: listWheel(
                              List.generate(
                                appController.getYear(1900),
                                (index) => index + 1901,
                              ),
                              (value) {
                                updateDate(set, y: value);
                                setState(() {});
                              },
                              tempDate.year - 1901,
                            ),
                          ),
                          Expanded(
                            child: listWheel(
                              List.generate(12, (index) => index + 1),
                              (value) {
                                updateDate(set, m: value);
                                setState(() {});
                              },
                              tempDate.month - 1,
                            ),
                          ),
                          Expanded(
                            child: listWheel(
                              List.generate(
                                appController.lastDate(tempDate),
                                (index) => index + 1,
                              ),
                              (value) {
                                updateDate(set, d: value);
                                setState(() {});
                              },
                              tempDate.day - 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: .end,
                    spacing: 24,
                    children: [
                      if (error) ...{
                        titleW(
                          "오늘 이후의 날짜는\n선택할 수 없습니다.",
                          color: Colors.red,
                          isF2: true,
                          size: 12,
                        ),
                        Spacer(),
                      },

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: titleW("취소", size: 16, isF2: true),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (appController.isNowDay(tempDate)) {
                            error = true;
                            set(() {});
                            return;
                          }

                          date = tempDate;
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: titleW("선택", size: 16, isF2: true),
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

  Widget dateButton() => SizedBox(
    width: 230,
    child: GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (context) => datePicker());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(32),
          border: .all(color: Colors.white54, width: 1.2),
        ),
        padding: .symmetric(vertical: 13, horizontal: 22),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            titleW(
              size: 15,
              date != null
                  ? appController.dateFormat("y년 M월 d일", date!)
                  : "생년월일을 선택해 주세요",
              isF2: true,
              color: Colors.white.withAlpha(date != null ? 240 : 120),
            ),
            Transform.flip(flipX: true, child: back(18)),
          ],
        ),
      ),
    ),
  );

  Widget moonButton() => SizedBox(
    width: 270,
    child: GestureDetector(
      onTap: () {
        if (appController.moon < 10 || date == null) {
          appController.showSnack(
            context,
            date == null
                ? "생일을 입력해 주세요"
                : "달 개수가 ${10 - appController.moon}개 부족합니다.",
          );
          return;
        }

        appController.addMoon(-10);
        appController.date = date;
        appController.go(context, MySoulScreen1());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(32),
          gradient: RadialGradient(
            colors: [grad, purple],
            center: .topLeft,
            radius: 2.2,
          ),
          boxShadow: [
            BoxShadow(
              color: grad.withAlpha(100),
              offset: .new(0, 8),
              blurRadius: 16,
            ),
          ],
        ),
        padding: .symmetric(vertical: 16),
        alignment: .center,
        child: Row(
          mainAxisSize: .min,
          spacing: 4,
          children: [moon(30), titleW("달 10개로 소울카드 찾기", size: 17)],
        ),
      ),
    ),
  );
}
