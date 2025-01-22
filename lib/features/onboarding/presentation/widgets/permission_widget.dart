import 'dart:io';

import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PermissionWidget extends StatelessWidget {
  final String imageName;
  final String imageSub;
  final String permissionTitle;
  final String permissionSubtitle;
  final void Function()? onAllow;
  final void Function()? onDeny;

  const PermissionWidget({super.key, required this.imageName, required this.imageSub, required this.permissionTitle, required this.permissionSubtitle, this.onAllow, this.onDeny});

  @override
  Widget build(BuildContext context) {
    return Loadable(
      child: Stack(
        children: [
          CenterAlignedColumn(
            children: [
              Expanded(
                child: Center(
                  child: CenterAlignedColumn(
                    children: [
                      Image.asset(
                        getSourceByPng(imageName)
                      ).bottomPadded(),
                      TextWidget.jakartaSansRegular(imageSub, size: 20, color: ColorWidget.blackColor),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 200.sp),
            ],
          ),
          Container(
            color: Colors.black.withOpacity(0.45),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CenterAlignedColumn(
              children: [
                Flexible(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                    child: CenterAlignedColumn(
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: TextWidget.jakartaSansSemiBold(
                                permissionTitle,
                                size: 16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: onDeny,
                                child: const Icon(Icons.close),
                              ),
                            )
                          ],
                        ).bottomPadded(24),
                        TextWidget.jakartaSansRegular(
                          permissionSubtitle,
                          maxLines: 6,
                          size: 16,
                          textAlign: TextAlign.center,
                        ).bottomPadded(32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onAllow,
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(0),
                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                              backgroundColor: WidgetStateProperty.all(ColorWidget.primaryColor),
                              foregroundColor: WidgetStateProperty.all(Colors.white),
                            ),
                            child: TextWidget.jakartaSansSemiBold("Allow", size: 16, color: Colors.white).verticalPadded(12),
                          ),
                        ).bottomPadded(8),
                        if (Platform.isAndroid)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: onDeny,
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all(0),
                                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                foregroundColor: WidgetStateProperty.all(ColorWidget.primaryColor),
                                backgroundColor: WidgetStateProperty.all(Colors.white),
                              ),
                              child: TextWidget.jakartaSansSemiBold("Deny", size: 16, color: Colors.blue).verticalPadded(12),
                            ),
                          ).bottomPadded()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
