import 'package:daily_tarot_poc_app_2/app_controller.dart';
import 'package:daily_tarot_poc_app_2/main.dart';
import 'package:daily_tarot_poc_app_2/screens/my_soul_card_screen1.dart';
import 'package:daily_tarot_poc_app_2/widgets/back_icon_button.dart';
import 'package:daily_tarot_poc_app_2/widgets/background2.dart';
import 'package:daily_tarot_poc_app_2/widgets/button_1.dart';
import 'package:daily_tarot_poc_app_2/widgets/icon_widget.dart';
import 'package:daily_tarot_poc_app_2/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

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
        children: [
          BackIconButton(),

          LogoWidget(title: "나의 생일로 알아보는 소울카드", ver2: true),

          SizedBox(height: 18),

          Text.rich(
            strutStyle: StrutStyle(height: 2.4),
            textAlign: .center,
            TextSpan(
              children: [
                _yellow("소울 넘버"),
                _white(
                  "는 생녀월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이지 아르가나 타로 카드가 바로",
                ),
                _yellow("소울 카드"),
                _white(
                  "이며,\n이는 당신의 타고난 성격, 기질,\n그리고 삶의 목적을 상징합니다.\n즉, 소울 넘버는 당신의",
                ),
                _yellow("영혼의 번호"),
                _white("이고,\n소울 카드는 그 번호가 의미하\n"),
                _yellow("영혼의 본질"),
                _white("을 보여주는 상징인 셈입니다."),
              ],
            ),
          ),

          SizedBox(height: 32),

          _dateButton(),

          SizedBox(height: 42),

          Button1(
            ver2: true,
            tap: () {
              if (date != null && appController.moonCount >= 10) {
                appController.birthDate = date;
                appController.move(context, MySoulCardScreen1());
              }
              appController.showSnack(
                context,
                date == null ? "생일을 선택해 주세요" : "달의 개수가 부족합니다.",
              );
            },
          ),

          SizedBox(height: 8),

          Text(
            "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
            style: TextStyle(color: textGrey, fontSize: 12, fontFamily: font2),
            textAlign: .center,
          ),
        ],
      ),
    );
  }

  Widget _dateButton() => GestureDetector(
    onTap: () {
      showDialog(context: context, builder: (context) => _datePopup());
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: .circular(32),
        border: .all(color: Colors.white),
      ),
      padding: .symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisSize: .min,
        children: [
          Text(
            date == null
                ? "생년월일을 선택해주세요"
                : appController.dateFormat("y/MM/dd", date!),
            style: TextStyle(color: Colors.white, fontWeight: .bold),
          ),
          Transform.flip(
            flipX: true,
            child: IconWidget(path: "assets/icons/arrow_back.svg", size: 18),
          ),
        ],
      ),
    ),
  );

  Widget _datePopup() {
    Widget action(String m, VoidCallback tap) => GestureDetector(
      onTap: tap,
      child: Text(m, style: TextStyle(fontSize: 18, fontWeight: .bold)),
    );

    DateTime tempDate = DateTime(1901, 1, 1);
    DateTime now = DateTime.now();

    return Dialog(
      backgroundColor: purple,
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white, fontFamily: font2),
        child: Padding(
          padding: .symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Padding(
                padding: .symmetric(vertical: 16),
                child: Text(
                  "생년월일 선택",
                  style: TextStyle(fontSize: 24, fontWeight: .bold),
                ),
              ),
              Container(
                height: 200,
                padding: .symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: .symmetric(
                    horizontal: BorderSide(color: Colors.white),
                  ),
                ),
                child: StatefulBuilder(
                  builder: (context, set) => Row(
                    children: [
                      _dateList(
                        List.generate(
                          now.year - DateTime(1900).year,
                          (index) => 1900 + index + 1,
                        ),
                        false,
                        (value) {
                          tempDate = DateTime(
                            value,
                            tempDate.month,
                            tempDate.day,
                          );
                          set(() {});
                        },
                      ),
                      _dateList(
                        List.generate(now.month, (index) => index + 1),
                        true,
                        (value) {
                          tempDate = DateTime(
                            tempDate.year,
                            value,
                            tempDate.day,
                          );
                          set(() {});
                        },
                      ),
                      _dateList(
                        List.generate(
                          DateTime(1, now.month)
                                      .difference(DateTime(1, tempDate.month))
                                      .inDays ==
                                  0
                              ? now.day - 1
                              : DateUtils.getDaysInMonth(
                                  tempDate.year,
                                  tempDate.month,
                                ),
                          (index) => index + 1,
                        ),
                        true,
                        (value) {
                          tempDate = DateTime(
                            tempDate.year,
                            tempDate.month,
                            value,
                          );
                          set(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: .bottomRight,
                child: Padding(
                  padding: .symmetric(vertical: 18),
                  child: Row(
                    spacing: 24,
                    mainAxisSize: .min,
                    children: [
                      action("취소", () {
                        setState(() {});
                        Navigator.pop(context);
                      }),
                      action("선택", () {
                        date = tempDate;
                        setState(() {});
                        Navigator.pop(context);
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateList(List<int> list, bool is2, Function(int value) onChange) =>
      Expanded(
        child: ListWheelScrollView.useDelegate(
          itemExtent: 72,
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
                        "${is2 ? appController.numberFormat("##", e) : e}",
                        style: TextStyle(
                          fontWeight: .bold,
                          color: Colors.white,
                          fontFamily: font2,
                          fontSize: 24,
                        ),
                      ),
                      Container(width: 24, height: 1, color: Colors.white),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      );

  TextSpan _white(String m) => TextSpan(
    text: m,
    style: TextStyle(color: Colors.white, fontWeight: .bold, fontFamily: font2),
  );

  TextSpan _yellow(String m) => TextSpan(
    text: m,
    style: TextStyle(color: yellow, fontWeight: .bold, fontFamily: font2),
  );
}
