import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.path, required this.width});

  final double width;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: .hardEdge,
      width: width,
      height: width * 1.5,
      decoration: BoxDecoration(
        borderRadius: .circular(8),
        image: DecorationImage(image: AssetImage(path), fit: .fill),
      ),
    );
  }
}
