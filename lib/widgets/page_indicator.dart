import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Flexible(
          child: Padding(
            padding: .only(left: count > index ? 5 : 0),
            child: Container(
              height: 8,
              color: count > index ? Colors.white : Colors.white.withAlpha(100),
            ),
          ),
        ),
      ),
    );
  }
}
