import 'package:flutter/material.dart';
import 'package:tapin/src/core/styles/text_custom_style.dart';

class ButtonCustom extends StatelessWidget {

  final String text;
  final Color? color;
  final Function()? onPressed;
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;

  const ButtonCustom({
    super.key,
    required this.text,
    this.color,
    this.onPressed,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.rightPadding = 40,
    this.leftPadding = 40
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding, right: rightPadding, left: leftPadding),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF23436E),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(double.infinity, 50),
            maximumSize: const Size(double.infinity, 100),
          ),
          child: TextCustomStyle(text: text, typeText: TypeText.button,)
      ),
    );
  }

}