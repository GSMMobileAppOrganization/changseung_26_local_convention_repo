import 'package:flutter/material.dart';

class CloudWidget extends StatelessWidget {
  const CloudWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.widthOf(context),
      height: 250,
      child: Stack(
        children: [
          Positioned(bottom: 72, left: -12, child: _image()),
          Positioned(bottom: -12, left: -36, child: _image()),
          Positioned(bottom: 72, right: -36, child: _image()),
          Positioned(bottom: 36, right: -80, child: _image()),
          Positioned(bottom: -30, right: 0, child: _image()),
        ],
      ),
    );
  }

  Widget _image() =>
      Image.asset("assets/images/cloud.png", fit: .fitWidth, width: 250);
}
