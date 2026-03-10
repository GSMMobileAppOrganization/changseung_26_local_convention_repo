import 'package:daily_tarot_poc_app_1/app_controller.dart';
import 'package:daily_tarot_poc_app_1/main.dart';
import 'package:daily_tarot_poc_app_1/screens/my_soul_card_screen1.dart';
import 'package:daily_tarot_poc_app_1/widgets/back_icon_button.dart';
import 'package:daily_tarot_poc_app_1/widgets/background_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_1.dart';
import 'package:daily_tarot_poc_app_1/widgets/icon_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      child: Column(
        spacing: 36,
        children: [
          Column(
            children: [
              BackIconButton(),
              LogoWidget2(text: "나의 생일로 알아보는 소울카드"),
            ],
          ),

          Text.rich(
            TextSpan(
              children: [
                _yellow("소울 넘버"),
                _white(
                  "는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이저 아르카나 타로 카드가 바로",
                ),
                _yellow("소울 카드"),
                _white(
                  "이며,\n이는 당신의 타고난 성적, 기질,\n그리고 삶의 목적을 상징합니다.\n즉 소울 넘버는 당신의",
                ),
                _yellow("영혼의 번호"),
                _white("이고,\n소울 카드는 그 번호가 의미하는\n"),
                _yellow("영혼의 본질"),
                _white("을 보여주는 상징인 셈입니다."),
              ],
            ),
            textAlign: .center,
            strutStyle: StrutStyle(height: 2.2),
          ),

          _birthSelectButton(),

          Column(
            spacing: 12,
            children: [
              Button1(
                text: "달 10개로 소울카드 찾기",
                tap: () {
                  if (appController.moonCount >= 10 && date != null) {
                    appController.moonCount -= 10;
                    appController.birthDate = date;


                    appController.soulCardList.forEach((element) => print("${element.number}"),);
                    print(appController.birthDate);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MySoulCardScreen1(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: purple,
                        content: Text(
                          date == null
                              ? "생일을 입력해 주십시오"
                              : "달 개수가 부족합니다. 충전 이후에 서비스 이용가능합니다.",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                    );
                  }
                },
                ver2: true,
              ),

              Text(
                "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
                style: TextStyle(
                  color: textGrey,
                  fontSize: 12,
                  fontWeight: .bold,
                  fontFamily: font2,
                ),
                textAlign: .center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _birthSelectButton() => GestureDetector(
    onTap: () {
      date = DateTime.now().add(Duration(days: -1));

      showDialog(context: context, builder: (context) => _popup());
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: .circular(32),
        border: .all(color: Colors.white),
      ),
      padding: .symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisSize: .min,
        spacing: 8,
        children: [
          Text(
            date == null
                ? "생년월일을 선택해주세요"
                : DateFormat("y. MM. dd").format(date!),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Transform.flip(
            flipX: true,
            child: IconWidget(path: "assets/icons/arrow_back.svg", width: 18),
          ),
        ],
      ),
    ),
  );

  Widget _popup() {
    DateTime tempDate = DateTime(1901, 1, 1);
    final now = DateTime.now();

    Widget action(String m, VoidCallback tap) => GestureDetector(
      onTap: tap,
      child: Text(
        m,
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: .bold),
      ),
    );

    return Dialog(
      backgroundColor: purple,
      child: Padding(
        padding: .symmetric(horizontal: 22, vertical: 18),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          spacing: 18,
          children: [
            Text(
              "생년월일 선택",
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontSize: 22,
              ),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: .symmetric(
                  horizontal: BorderSide(color: Colors.white.withAlpha(100)),
                ),
              ),
              padding: .all(8),
              child: StatefulBuilder(
                builder: (context, set) {
                  return Row(
                    children: [
                      Flexible(
                        child: _scrollList(
                          List.generate(
                            now.year - DateTime(1900).year,
                            (index) => 1900 + index + 1,
                          ),
                          (value) {
                            tempDate = DateTime(
                              value,
                              tempDate.month,
                              tempDate.day,
                            );
                            set(() {});
                          },
                        ),
                      ),
                      Flexible(
                        child: _scrollList(
                          List.generate(now.month, (index) => index + 1),
                          (value) {
                            tempDate = DateTime(
                              tempDate.year,
                              value,
                              tempDate.day,
                            );
                            set(() {});
                          },
                        ),
                      ),
                      Flexible(
                        child: _scrollList(
                          List.generate(
                            DateUtils.monthDelta(tempDate, now) == 0
                                ? now.day - 1
                                : DateUtils.getDaysInMonth(
                                    tempDate.day,
                                    tempDate.month,
                                  ),
                            (index) => index + 1,
                          ),
                          (value) {
                            tempDate = DateTime(
                              tempDate.year,
                              tempDate.month,
                              value,
                            );
                            set(() {});
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              spacing: 24,
              mainAxisAlignment: .end,
              children: [
                action("취소", () {
                  Navigator.pop(context);
                }),
                action("선택", () {
                  date = tempDate;
                  Navigator.pop(context);
                  setState(() {});
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollList(List<int> list, Function(int value) onChange) =>
      ListWheelScrollView.useDelegate(
        itemExtent: 64,
        onSelectedItemChanged: (value) {
          onChange.call(list[value]);
        },
        childDelegate: ListWheelChildLoopingListDelegate(
          children: list
              .map(
                (e) => Column(
                  mainAxisAlignment: .spaceAround,
                  children: [
                    Text(
                      "$e",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontSize: 24,
                      ),
                    ),
                    Container(width: 12, height: 1, color: Colors.white),
                  ],
                ),
              )
              .toList(),
        ),
      );

  TextSpan _yellow(String m) => TextSpan(
    text: m,
    style: TextStyle(color: yellow, fontWeight: .bold, fontSize: 14),
  );

  TextSpan _white(String m) => TextSpan(
    text: m,
    style: TextStyle(color: Colors.white, fontWeight: .bold, fontSize: 14),
  );
}
