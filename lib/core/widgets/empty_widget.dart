import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String desc;

  const EmptyWidget({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CenterAlignedColumn(
        children: [
          Image.asset(getSourceByPng('img_finish_class')),
          TextWidget.jakartaSansBold(title, size: 24, textAlign: TextAlign.center, color: ColorWidget.primaryColor).topPadded(24).bottomPadded(8),
          TextWidget.jakartaSansRegular(desc, size: 16, textAlign: TextAlign.center, maxLines: 3, color: ColorWidget.secondaryColor),
        ]
      ),
    );
  }
}
