import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:flutter/material.dart';

class CoursesWidget extends StatelessWidget {
  final String images;
  final String title;
  final String categories;
  final String rating;

  const CoursesWidget({super.key, required this.images, required this.title, required this.categories, required this.rating});

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      width: double.infinity,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          child: AspectRatio(
            aspectRatio: 1/1,
            child: Image.asset(getSourceByPng(images), fit: BoxFit.cover)
          )
        ),
        TextWidget.jakartaSansSemiBold(title, size: 16, maxLines: 2, color: ColorWidget.primaryColor),
        TextWidget.jakartaSansRegular(categories, size: 12, maxLines: 1, color: ColorWidget.secondaryColor),
        LeftAlignedRow(
          children: [
            Icon(Icons.star, color: ColorWidget.secondaryColor, size: 16),
            TextWidget.jakartaSansSemiBold(rating, size: 8).leftPadded(4)
          ]
        )
      ]
    );
  }
}
