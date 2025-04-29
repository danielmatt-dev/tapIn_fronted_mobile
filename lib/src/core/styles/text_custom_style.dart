import 'package:flutter/material.dart';

enum TypeText { title, text, button }

class TextCustomStyle extends StatelessWidget {

  final String text;
  final Color? color;
  final double? fontSize;
  final TypeText typeText;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;

  const TextCustomStyle({
    super.key,
    required this.text,
    this.typeText = TypeText.text,
    this.color,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.textAlign,
    this.maxLines
  });

  TextStyle _getStyle() {
    if (typeText == TypeText.title) {
      return TextStyle(
        fontSize: fontSize ?? 18,
        color: color,
        fontWeight: fontWeight ?? FontWeight.bold,
      );
    }

    if (typeText == TypeText.button) {
      return TextStyle(
          fontSize: fontSize ?? 16,
          color: color,
          fontWeight: fontWeight ?? FontWeight.bold
      );
    }

    return TextStyle(
        fontSize: fontSize ?? 14,
        color: color,
        fontWeight: fontWeight,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? _getStyle(),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }

}