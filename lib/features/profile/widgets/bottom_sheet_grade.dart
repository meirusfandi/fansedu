import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/config/model/info_item.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BottomSheetGrade extends StatefulWidget {
  final InfoItem selectedValue;
  final List<InfoItem> grades;
  final Function(InfoItem) onTap;

  const BottomSheetGrade({super.key, required this.selectedValue, required this.onTap, required this.grades});

  @override
  State<BottomSheetGrade> createState() => _BottomSheetGradeState();
}

class _BottomSheetGradeState extends State<BottomSheetGrade> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: BottomDrawer(
        child: LeftAlignedColumn(
          children: [
            Stack(
              children: [
                Center(
                  child: TextWidget.jakartaSansSemiBold('Select Your Grade', size: 16, color: ColorWidget.blackColor),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => context.router.maybePop(),
                    child: Icon(Icons.close, size: 24, color: Colors.black),
                  ),
                )
              ],
            ).bottomPadded(),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return LeftAlignedRow(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.onTap(widget.grades[index]);
                          });
                          context.maybePop();
                        },
                        child: TextWidget.jakartaSansRegular('Grade ${widget.grades[index].content}', size: 16, color: ColorWidget.iconColor).horizontalPadded().verticalPadded(8),
                      ),
                    ),
                    if (widget.selectedValue.title == widget.grades[index].title) Icon(Icons.check, size: 32, color: ColorWidget.accentColor)
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: widget.grades.length
            )
          ]
        )
      )
    );
  }
}
