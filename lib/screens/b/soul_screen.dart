import 'package:daily_tarot_poc_app_14/app_controller.dart';
import 'package:daily_tarot_poc_app_14/main.dart';
import 'package:daily_tarot_poc_app_14/widgets/background.dart';
import 'package:daily_tarot_poc_app_14/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_14/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'my_soul_screen.dart';

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
      down: false,
      child: Column(
        children: [
          backButton(context),

          SizedBox(height: 32),

          LogoWidget(title: "나의 생일로 알아보는 소울카드", ver2: true),

          SizedBox(height: 38),

          Text.rich(
            textAlign: .center,
            TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: .bold,
                fontFamily: f2,
                height: 2.2,
              ),
              children: [
                TextSpan(
                  text: "소울 넘버",
                  style: TextStyle(color: yellow),
                ),
                TextSpan(
                  text:
                      "는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이저 아르카나 타로 카드가 바로 ",
                ),
                TextSpan(
                  text: "소울 카드",
                  style: TextStyle(color: yellow),
                ),
                TextSpan(
                  text:
                      "이며,\n이는 당신의 타고난 성격, 기질,\n그리고 삶의 목적을 상징합니다.\n즉, 소울 넘버는 당신의 ",
                ),
                TextSpan(
                  text: "영혼의 번호",
                  style: TextStyle(color: yellow),
                ),
                TextSpan(text: "이고,\n소울 카드는 그 번호가 의미하는\n"),
                TextSpan(
                  text: "영혼의 본질",
                  style: TextStyle(color: yellow),
                ),
                TextSpan(text: "을 보여주는 상징인 셈입니다."),
              ],
            ),
          ),

          SizedBox(height: 46),

          dateButton(),

          SizedBox(height: 50),

          moonButton(),
          SizedBox(height: 12),
          titleW(
            "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
            color: Colors.white30,
            isF2: true,
            size: 11,
            align: .center,
          ),
        ],
      ),
    );
  }

  Widget moonButton() => SizedBox(
    width: 290,
    child: GestureDetector(
      onTap: () {
        if (appController.moon < 10 || date == null) {
          appController.showSnack(
            context,
            date == null
                ? "먼저 생년월일을 선택헤주세요."
                : "달 ${10 - appController.moon}개가 부족합니다.",
          );
          return;
        }

        appController.addMoon(-10);
        appController.date = date;
        appController.goFade(context, MySoulScreen1(), dur: .zero);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [grad, purple],
            center: .topLeft,
            radius: 1.7,
          ),
          borderRadius: .circular(32),
          boxShadow: [
            BoxShadow(
              color: grad.withAlpha(80),
              offset: .new(0, 8),
              blurRadius: 16,
            ),
          ],
        ),
        alignment: .center,
        padding: .symmetric(vertical: 16),
        child: Row(
          spacing: 10,
          mainAxisSize: .min,
          children: [moon(36), titleW("달 10개로 소울카드 찾기", size: 18)],
        ),
      ),
    ),
  );

  Widget dateButton() => SizedBox(
    width: 220,
    child: GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (context) => datePicker());
      },
      child: Container(
        decoration: BoxDecoration(
          border: .all(color: Colors.white54, width: 1.2),
          borderRadius: .circular(32),
        ),
        padding: .symmetric(vertical: 13, horizontal: 24),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            titleW(
              date != null
                  ? appController.dateFormat("y년 M월 d일", date!)
                  : "생년월일을 선택해주세요",
              size: 14,
              isF2: true,
              color: date != null ? Colors.white : Colors.white54,
            ),
            Transform.flip(
              flipX: true,
              child: back(
                18,
                color: date != null ? Colors.white : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget datePicker() {
    DateTime tempDate = date ?? DateTime(1901, 1, 1);

    bool error = false;

    final yController = FixedExtentScrollController(
      initialItem: tempDate.year - 1901,
    );
    final mController = FixedExtentScrollController(
      initialItem: tempDate.month - 1,
    );
    final dController = FixedExtentScrollController(
      initialItem: tempDate.day - 1,
    );

    void updateDate(StateSetter set, {int? y, int? m, int? d}) {
      int year = y ?? tempDate.year;
      int month = m ?? tempDate.month;
      int day = d ?? tempDate.day;

      if (m != null || y != null) {
        day = 1;
        dController.animateToItem(
          day - 1,
          duration: Duration(milliseconds: 100),
          curve: Curves.easeIn,
        );
      }

      tempDate = DateTime(year, month, day);
      set(() {});
    }

    return Dialog(
      constraints: .tightFor(height: 320, width: 330),
      child: Container(
        clipBehavior: .hardEdge,
        decoration: BoxDecoration(
          borderRadius: .circular(18),
          gradient: LinearGradient(
            colors: [purple, deepPurple],
            begin: .topLeft,
            end: .bottomRight,
          ),
        ),
        padding: .symmetric(horizontal: 22, vertical: 18),
        child: StatefulBuilder(
          builder: (context, set) => Column(
            crossAxisAlignment: .start,
            children: [
              titleW("생년월일 선택", isF2: true, size: 20),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: .symmetric(
                      horizontal: BorderSide(color: Colors.white30, width: 1.2),
                    ),
                  ),
                  padding: .symmetric(vertical: 12),
                  margin: .symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: listWheel(
                          List.generate(
                            DateTime.now().year - 1900,
                            (index) => index + 1901,
                          ),
                          (value) {
                            updateDate(set, y: value);
                          },
                          yController,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: listWheel(
                          List.generate(12, (index) => index + 1),
                          (value) {
                            updateDate(set, m: value);
                          },
                          mController,
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
                          },
                          dController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: .end,
                children: [
                  if (error)
                    titleW(
                      "오늘 이후의 날짜는\n선택하실 수 없습니다.",
                      isF2: true,
                      size: 12,
                      color: Colors.red,
                    ),

                  Spacer(),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: titleW("취소", isF2: true, size: 18),
                  ),
                  SizedBox(width: 24),
                  GestureDetector(
                    onTap: () {
                      if (appController.isOverNow(tempDate)) {
                        error = true;
                        set(() {});
                        return;
                      }

                      date = tempDate;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: titleW("선택", isF2: true, size: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
