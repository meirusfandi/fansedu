import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemNotificationWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;
  final String time;
  final bool isRead;
  final Function() onTap;

  const ItemNotificationWidget({super.key, required this.icon, required this.title, required this.desc, required this.time, required this.isRead, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: (isRead) ? Colors.white : ColorWidget.whiteColor,
          border: Border.all(color: ColorWidget.whiteColor),
          borderRadius: BorderRadius.all(Radius.circular(6.0))
        ),
        child: LeftAlignedRow(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorWidget.primaryColor,
              ),
              child: SvgPicture.asset(getSourceBySvg(icon), color: Colors.white, width: 24, height: 24,).padded(10),
            ).rightPadded(8),
            Expanded(
              child: LeftAlignedColumn(
                children: [
                  TextWidget.jakartaSansSemiBold(title, size: 16, maxLines: 1, color: ColorWidget.primaryColor),
                  TextWidget.jakartaSansRegular(desc, size: 12, maxLines: 2, color: ColorWidget.secondaryColor),
                ],
              )
            ),
            TextWidget.jakartaSansSemiBold(time, size: 10, color: ColorWidget.iconColor)
          ]
        ).padded(),
      ),
    );
  }
}
