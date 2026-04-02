import 'package:daily_tarot_poc_app_10/app_controller.dart';
import 'package:daily_tarot_poc_app_10/main.dart';
import 'package:daily_tarot_poc_app_10/screens/b/my_soul_screen.dart';
import 'package:daily_tarot_poc_app_10/widgets/background1.dart';
import 'package:daily_tarot_poc_app_10/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_10/widgets/widgets.dart';
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
      down: false,
      child: Column(
        children: [
          backButton(context),

          SizedBox(height: 24),

          LogoWidget(ver2: true, title: "나의 생일로 알아보는 소울카드"),

          Spacer(),

          content(),

          Spacer(),

          SizedBox(width: 220, child: timeButton()),
          Spacer(),

          SizedBox(width: 280, child: moonButton()),

          SizedBox(height: 12),

          titleW(
            "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
            color: Colors.white30,
            size: 10,
            align: .center,
            font: f2,
          ),

          Spacer(flex: 3),
        ],
      ),
    );
  }

  Widget datePicker() {
    DateTime tempDate = date ?? DateTime(1901, 1, 1);

    void updateDate(StateSetter set, {int? y, int? m, int? d}) {
      int Ny = y ?? tempDate.year;
      int Nm = m ?? tempDate.month;
      int Nd = d ?? tempDate.day;

      final maxD = appController.lastDate(DateTime(Ny, Nm, Nd));

      if (maxD < Nd) {
        Nd = maxD;
      }
      tempDate = DateTime(Ny, Nm, Nd);
      set(() {});
    }

    bool error = false;

    return Dialog(
      constraints: .tightFor(height: 300),
      child: Container(
        clipBehavior: .hardEdge,
        decoration: BoxDecoration(borderRadius: .circular(16)),
        child: background(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: StatefulBuilder(
              builder: (context, set) => Column(
                crossAxisAlignment: .start,
                children: [
                  titleW("생년월일 선택", font: f2, size: 19),
                  Expanded(
                    child: Container(
                      padding: .symmetric(vertical: 12),
                      margin: .symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: .symmetric(
                          horizontal: BorderSide(
                            color: Colors.white30,
                            width: 1.2,
                          ),
                        ),
                      ),
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
                              },
                              tempDate.year - 1901,
                            ),
                          ),
                          Expanded(
                            child: listWheel(
                              List.generate(12, (index) => index + 1),
                              (value) {
                                updateDate(set, m: value);
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
                              },
                              tempDate.day - 1,
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
                      if (error) ...{
                        titleW(
                          color: Colors.red,
                          "오늘 이후의 날짜는\n선택하실 수 없습니다.",
                          size: 12,
                          font: f2,
                        ),
                        Spacer(),
                      },
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: titleW("취소", font: f2, size: 17),
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
                        child: titleW("선택", font: f2, size: 17),
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

  Widget moonButton() => GestureDetector(
    onTap: () {
      if (date == null || appController.moon < 10) {
        appController.showSnack(
          context,
          date == null
              ? "생년월일을 선택해주세요"
              : "달 개수가 ${10 - appController.moon}개 부족합니다.",
        );
        return;
      }

      appController.addMoon(-10);
      appController.date = date;
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              MySoulScreen1(),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [grad, purple],
          radius: 2.2,
          center: .topLeft,
        ),
        boxShadow: [
          BoxShadow(
            color: grad.withAlpha(160),
            offset: .new(0, 8),
            blurRadius: 16,
          ),
        ],
        borderRadius: .circular(32),
      ),
      alignment: .center,
      padding: .symmetric(vertical: 16),
      child: Row(
        spacing: 4,
        mainAxisSize: .min,
        children: [
          moon(32),
          title18W("달 10개로 소울카드 찾기", weight: .w800),
        ],
      ),
    ),
  );

  Widget timeButton() => GestureDetector(
    onTap: () {
      showDialog(context: context, builder: (context) => datePicker());
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: .circular(32),
        border: .all(
          color: date != null ? Colors.white : Colors.white54,
          width: 1.5,
        ),
      ),
      padding: .symmetric(horizontal: 18, vertical: 14),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          titleW(
            date != null
                ? appController.dateFormat("y년 M월 d일", date!)
                : "생년월일을 선택해 주세요",
            color: date != null ? Colors.white : Colors.white54,
            font: f2,
            size: 15,
          ),
          Transform.flip(flipX: true, child: back(18)),
        ],
      ),
    ),
  );

  Widget content() => Text.rich(
    strutStyle: StrutStyle(height: 2),
    style: TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontFamily: f2,
      fontWeight: .bold,
    ),
    textAlign: .center,
    TextSpan(
      children: [
        TextSpan(
          text: "소울 넘버",
          style: TextStyle(
            color: yellow,
            fontSize: 12,
            fontFamily: f2,
            fontWeight: .bold,
          ),
        ),
        TextSpan(
          text:
              "는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이저 아르카나 타로 카드가 바로 ",
        ),
        TextSpan(
          text: "소울 카드",
          style: TextStyle(
            color: yellow,
            fontSize: 12,
            fontFamily: f2,
            fontWeight: .bold,
          ),
        ),
        TextSpan(
          text: "이며,\n이는 당신의 타고난 성격, 기질,\n그리고 삶의 목적을 상징합니다.\n즉, 소울 넘버는 당신의 ",
        ),
        TextSpan(
          text: "영혼의 번호",
          style: TextStyle(
            color: yellow,
            fontSize: 12,
            fontFamily: f2,
            fontWeight: .bold,
          ),
        ),
        TextSpan(text: "이고,\n소울 카드는 그 번호가 의미하는\n"),
        TextSpan(
          text: "영혼의 본질",
          style: TextStyle(
            color: yellow,
            fontSize: 12,
            fontFamily: f2,
            fontWeight: .bold,
          ),
        ),
        TextSpan(text: "을 보여주는 상징인 셈입니다."),
      ],
    ),
  );
}
