import 'package:flutter/material.dart';

class CloudWidget extends StatelessWidget {
  const CloudWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.widthOf(context),
      child: Stack(
        children: [
          Positioned(
            bottom: 64,
            left: -32,
            child: Image.asset(
              "assets/images/cloud.png",
              fit: .fitWidth,
              width: 250,
            ),
          ),
          Positioned(
            bottom: 72,
            right: -32,
            child: Image.asset(
              "assets/images/cloud.png",
              fit: .fitWidth,
              width: 250,
            ),
          ),
          Positioned(
            bottom: 32,
            right: -62,
            child: Image.asset(
              "assets/images/cloud.png",
              fit: .fitWidth,
              width: 250,
            ),
          ),
          Positioned(
            bottom: 0,
            left: -32,
            child: Image.asset(
              "assets/images/cloud.png",
              fit: .fitWidth,
              width: 250,
            ),
          ),
          Positioned(
            bottom: -12,
            right: -32,
            child: Image.asset(
              "assets/images/cloud.png",
              fit: .fitWidth,
              width: 250,
            ),
          ),
        ],
      ),
    );
  }
}
