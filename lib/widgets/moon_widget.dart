import 'package:flutter/material.dart';

class MoonWidget extends StatelessWidget {
  const MoonWidget({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/moon.png", fit: .fitWidth, width: size);
  }
}
