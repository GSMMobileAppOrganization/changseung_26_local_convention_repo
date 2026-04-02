import 'package:daily_tarot_poc_app_13/app_controller.dart';
import 'package:daily_tarot_poc_app_13/main.dart';
import 'package:daily_tarot_poc_app_13/screens/b/my_soul_screen.dart';
import 'package:daily_tarot_poc_app_13/widgets/background.dart';
import 'package:daily_tarot_poc_app_13/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_13/widgets/widgets.dart';
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

          SizedBox(height: 8),

          LogoWidget(title: "나의 생일로 알아보는 소울카드", ver2: true),

          SizedBox(height: 36),

          Text.rich(
            TextSpan(
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
              style: TextStyle(
                color: Colors.white,
                fontFamily: f2,
                fontWeight: .bold,
                fontSize: 12,
                height: 2.2,
              ),
            ),
            textAlign: .center,
          ),

          SizedBox(height: 48),
          dateButton(),
          SizedBox(height: 48),

          moonButton(),

          SizedBox(height: 12),

          titleW(
            "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
            color: Colors.white30,
            size: 10,
            isF2: true,
            align: .center,
          ),
        ],
      ),
    );
  }

  Widget datePicker() {
    DateTime tempDate = date ?? DateTime(1901, 1, 1);

    bool error = false;

    void updateDate(StateSetter set, {int? y, int? m, int? d}) {
      int year = y ?? tempDate.year;
      int month = m ?? tempDate.month;
      int day = d ?? tempDate.day;

      final maxD = appController.lastDate(DateTime(year, month));

      if (maxD < day) {
        day = maxD;
      }

      tempDate = DateTime(year, month, day);
      set(() {});
    }

    return Dialog(
      constraints: .tightFor(width: 300, height: 280),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [purple, deepPurple],
            begin: .topLeft,
            end: .bottomRight,
          ),
          borderRadius: .circular(16),
        ),
        padding: .symmetric(horizontal: 28, vertical: 18),
        clipBehavior: .hardEdge,
        child: StatefulBuilder(
          builder: (context, set) => Column(
            crossAxisAlignment: .start,
            children: [
              titleW("생년월일 선택", size: 18, isF2: true),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: .symmetric(
                      horizontal: BorderSide(color: Colors.white30, width: 1.6),
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
                      "오늘 이후의 날짜는\n선택하실 수 없습니다.",
                      isF2: true,
                      color: Colors.red,
                      size: 12,
                    ),
                    Spacer(),
                  },

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: titleW("취소", isF2: true),
                  ),
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
                    child: titleW("선택", isF2: true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget moonButton() => SizedBox(
    width: 280,
    child: GestureDetector(
      onTap: () {
        if (date == null || appController.moon < 10) {
          appController.showSnack(
            context,
            date == null
                ? "생년월일을 입력해 주세요."
                : "달 ${10 - appController.moon}개가 부족합니다.",
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
            colors: [grad, accentPurple],
            radius: 2.2,
            center: .topLeft,
          ),
          borderRadius: .circular(32),
          boxShadow: [
            BoxShadow(
              color: grad.withAlpha(60),
              offset: .new(0, 8),
              blurRadius: 16,
            ),
          ],
        ),
        padding: .symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 9,
          children: [moon(34), titleW("달 10개로 소울카드 찾기", size: 17)],
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
          borderRadius: .circular(32),
          border: .all(color: Colors.white54, width: 1.6),
        ),
        padding: .symmetric(vertical: 13, horizontal: 20),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            titleW(
              date != null
                  ? appController.dateFormat("y년 M월 d일", date!)
                  : "생년월일을 선택해주세요",
              size: 15,
              isF2: true,
              color: date != null ? null : Colors.white54,
            ),
            Transform.flip(
              flipX: true,
              child: back(18, color: date != null ? null : Colors.white54),
            ),
          ],
        ),
      ),
    ),
  );
}
