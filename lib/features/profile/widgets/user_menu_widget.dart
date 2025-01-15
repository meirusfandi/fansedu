import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserMenuWidget extends StatelessWidget {
  final String iconLeading;
  final String title;
  final Function() onTap;

  const UserMenuWidget({super.key, required this.iconLeading, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LeftAlignedRow(
        children: [
          SvgPicture.asset(getSourceBySvg(iconLeading), width: 24, height: 24).rightPadded(),
          Expanded(
            child: TextWidget.jakartaSansSemiBold(title, size: 16, color: ColorWidget.primaryColor)
          ),
          Icon(Icons.arrow_forward_ios, color: ColorWidget.primaryColor, size: 16)
        ]
      ),
    );
  }
}