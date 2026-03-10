import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.path, required this.width});

  final String path;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width * 1.5,
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(borderRadius: .circular(12)),
      child: Image.asset(path, fit: .fill),
    );
  }
}
