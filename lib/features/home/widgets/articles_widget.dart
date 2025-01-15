import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:flutter/material.dart';

class ArticlesWidget extends StatelessWidget {
  final String images;
  final String title;
  final String desc;
  const ArticlesWidget({super.key, required this.images, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      children: [
        LeftAlignedRow(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: Image.asset(getSourceByPng(images), height: 64, width: 86, fit: BoxFit.cover)
            ).rightPadded(8),
            LeftAlignedColumn(
                children: [
                  TextWidget.jakartaSansSemiBold(title, size: 16, color: ColorWidget.primaryColor),
                  TextWidget.jakartaSansRegular(desc, size: 12, color: ColorWidget.secondaryColor),
                ]
            )
          ]
        )
      ]
    );
  }
}