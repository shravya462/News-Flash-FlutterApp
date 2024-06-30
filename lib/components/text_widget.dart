import 'package:flutter/material.dart';
import 'package:flutter_project/res/fonts.dart';

class TextWidget extends StatelessWidget {
  final String txtTitle;
  final FontWeight txtFontStyle;
  final double txtFontSize;
  final TextAlign? textAlignment;
  final bool wrapValue;
  final TextOverflow? overflow;

  TextWidget({
    required this.txtTitle,
    required this.txtFontStyle,
    required this.txtFontSize,
    this.textAlignment,
    this.overflow = TextOverflow.visible,
    this.wrapValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txtTitle,
      softWrap: wrapValue,
      overflow: overflow,
      style: TextStyle(
        fontFamily: Fonts.fontRoboto,
        fontWeight: txtFontStyle,
        fontSize: txtFontSize,
      ),
      textAlign: textAlignment != null ? textAlignment : TextAlign.start,
    );
  }
}
