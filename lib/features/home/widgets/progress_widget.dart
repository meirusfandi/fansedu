import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      children: [
        LeftAlignedRow(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              child: Image.asset(getSourceByPng('img_progress_class'), width: 87, height: 58, fit: BoxFit.cover)
            ).rightPadded(8),
            LeftAlignedColumn(
              children: [
                TextWidget.jakartaSansBold("UI/UX Design Essentials", maxLines: 1, color: ColorWidget.primaryColor, size: 14),
                TextWidget.jakartaSansSemiBold("Tech Innovations University", size: 8, maxLines: 1, color: ColorWidget.secondaryColor),
                LeftAlignedRow(
                  children: [
                    Icon(Icons.star, color: ColorWidget.secondaryColor, size: 16),
                    TextWidget.jakartaSansSemiBold("4.9", size: 8).leftPadded(4)
                  ]
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextWidget.jakartaSansSemiBold("35% Completed", size: 8, color: ColorWidget.iconColor),
                ),
              ]
            )
          ]
        )
      ],
    );
  }
}