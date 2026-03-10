import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({super.key, required this.path, required this.size});


  final String path;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path, fit: .fitWidth, width: size,);
  }
}
