import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final bool isActive;

  const ActionButtonWidget({super.key, required this.title, required this.onTap, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: (isActive) ? ColorWidget.primaryColor : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            border: Border.all(color: ColorWidget.primaryColor)
          ),
          child: TextWidget.jakartaSansSemiBold(title, size: 16, textAlign: TextAlign.center, color: (isActive) ? ColorWidget.whiteColor : ColorWidget.blackColor).padded(),
        ),
      ),
    );
  }
}