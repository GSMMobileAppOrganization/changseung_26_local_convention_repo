import 'package:daily_tarot_poc_app_1/widgets/background.dart';
import 'package:daily_tarot_poc_app_1/widgets/button_2.dart';
import 'package:daily_tarot_poc_app_1/widgets/logo_widget.dart';
import 'package:daily_tarot_poc_app_1/widgets/page_indicator.dart';
import 'package:flutter/material.dart';

class BaseInputPage extends StatelessWidget {
  const BaseInputPage({
    super.key,
    required this.title,
    required this.count,
    required this.child,
    this.expandButton,
    required this.prevPage,
  });

  final String title;
  final int count;
  final Widget child;
  final Widget? expandButton;
  final Widget prevPage;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          SizedBox(height: 120),
          LogoWidget(text: title),
          Expanded(child: child),
          Row(
            mainAxisAlignment: .center,
            spacing: 12,
            children: [
              Button2(
                text: "이전",
                tap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => prevPage),
                ),
              ),
              if (expandButton != null) ...{expandButton!},
            ],
          ),
          SizedBox(height: 48),
          PageIndicator(count: count),
        ],
      ),
    );
  }
}
