import 'package:flutter/material.dart';
import 'package:flutter_project/components/text_widget.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextWidget(
      txtTitle: "No Network",
      txtFontStyle: FontWeight.w400,
      txtFontSize: 14,
    ));
  }
}
