import 'package:daily_tarot_poc_app_3/app_controller.dart';
import 'package:daily_tarot_poc_app_3/main.dart';
import 'package:daily_tarot_poc_app_3/screens/module_b/my_soul_card_screen1.dart';
import 'package:daily_tarot_poc_app_3/widgets/background2.dart';
import 'package:daily_tarot_poc_app_3/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_3/widgets/widgets.dart';
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
          Align(alignment: .topLeft, child: backButton(context)),

          LogoWidget(ver2: true, title: "나의 생일로 알아보는 소울카드"),
          Spacer(),

          Text.rich(
            TextSpan(
              children: [
                yellowT("소울 넘버"),
                white(
                  "는 생년월일의 숫자를 모두 더해\n얻는 최종적인 한 자리 숫자로,\n당신의 핵심적인 에너지와 삶의 테마를 나타냅니다.\n이 소울 넘버에 해당하는\n메이저 아르카나 타로 카드가 바로",
                ),
                yellowT("소울 카드"),
                white(
                  "이며,\n이는 당신의 타고난 성격, 기질,\n그리고 삶의 목적을 상징합니다.\n즉, 소울 넘버는 당신의 ",
                ),
                yellowT("영혼의 번호"),
                white("이고,\n소울 카드는 그 번호가 의미하는\n"),
                yellowT("영혼의 본질"),
                white("을 보여주는 상징인 셈입니다."),
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
                  ? appController.dateFormat("y/M/d", date!)
                  : "생년월일을 선택해주세요",
              () => showDialog(
                context: context,
                builder: (context) => datePopup(),
              ),
              hasIcon: true,
            ),
          ),
          Spacer(),

          SizedBox(
            width: 300,
            child: button1(
              "달 10개로 소울카드 찾기",
              () {
                if (date == null || appController.moon < 10) {
                  appController.showSnack(
                    context,
                    date == null ? "생일을 입력해 주세요." : "달 개수가 부족합니다.",
                  );
                  return;
                }

                appController.birthDate = date;
                appController.move(context, MySoulCardScreen1());
              },
              hasMoon: true,
              radius: 3,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "소울카드에 사용되는 정보는\n카드 조합 용도 외에 사용되지 않습니다.",
            style: TextStyle(
              color: Colors.white,
              fontWeight: .w300,
              fontSize: 12,
            ),
            textAlign: .center,
          ),

          Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget datePopup() {
    Widget action(String m, VoidCallback tap) => GestureDetector(
      onTap: tap,
      child: Text(
        m,
        style: TextStyle(color: Colors.white, fontWeight: .bold, fontSize: 18),
      ),
    );

    DateTime tempDate = DateTime(1901, 1, 1);

    return Dialog(
      child: Container(
        padding: .symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: .circular(8),
          gradient: LinearGradient(
            colors: [purpleAccent, purple],
            begin: .topLeft,
            end: .bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Text(
              "생년월일 선택",
              style: TextStyle(
                color: Colors.white,
                fontWeight: .bold,
                fontSize: 24,
              ),
            ),

            Padding(
              padding: .symmetric(vertical: 12),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: .symmetric(
                    horizontal: BorderSide(color: Colors.white),
                  ),
                ),
                padding: .symmetric(vertical: 12),
                child: StatefulBuilder(
                  builder: (context, set) => Row(
                    children: [
                      Expanded(
                        child: wheelList(
                          List.generate(
                            DateTime.now().year - DateTime(1900).year,
                            (index) => index + 1901,
                          ),
                          (value) {
                            tempDate = DateTime(
                              value,
                              tempDate.month,
                              tempDate.day,
                            );
                            set(() {});
                          },
                          curValue: tempDate.year,
                        ),
                      ),
                      Expanded(
                        child: wheelList(
                          List.generate(
                            appController.isNowYear(tempDate.year)
                                ? DateTime.now().month
                                : 12,
                            (index) => index + 1,
                          ),
                          (value) {
                            tempDate = DateTime(
                              tempDate.year,
                              value,
                              tempDate.day,
                            );
                            set(() {});
                          },
                          curValue: tempDate.month,
                          format: "00"
                        ),
                      ),
                      Expanded(
                        child: wheelList(
                          List.generate(
                            appController.isNowMonth(tempDate)
                                ? DateTime.now().day
                                : appController.lastDate(tempDate),
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
                          curValue: tempDate.day,
                          format: "00"
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
                action("취소", () {
                  Navigator.pop(context);
                }),
                action("선택", () {
                  date = tempDate;
                  setState(() {});
                  Navigator.pop(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextSpan white(String m) => TextSpan(
    style: TextStyle(color: Colors.white, fontFamily: f2, fontWeight: .bold),
    text: m,
  );

  TextSpan yellowT(String m) => TextSpan(
    style: TextStyle(color: yellow, fontFamily: f2, fontWeight: .bold),
    text: m,
  );
}
