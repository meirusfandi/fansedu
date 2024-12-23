import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:flutter/material.dart';

class TextWidget {
  static Text jakartaSansBold(String title,
      {TextAlign? textAlign,
        Color? color,
        double? size,
        int? maxLines,
        TextOverflow? overflow,
        double? lineSpacing}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: textPlusJakartaSansSetting(
          size: size ?? 12.0,
          fontWeight: FontWeight.w700,
          color: color,
          height: lineSpacing),
    );
  }

  static Text jakartaSansMedium(String title,
      {TextAlign? textAlign,
        Color? color,
        double? size,
        int? maxLines,
        TextOverflow? overflow,
        double? lineSpacing}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: textPlusJakartaSansSetting(
          size: size ?? 12.0,
          fontWeight: FontWeight.w500,
          color: color,
          height: lineSpacing),
    );
  }

  static Text jakartaSansRegular(String title,
      {TextAlign? textAlign,
        Color? color,
        double? size,
        int? maxLines,
        TextOverflow? overflow,
        double? lineSpacing}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: textPlusJakartaSansSetting(
          size: size ?? 12.0,
          fontWeight: FontWeight.w400,
          color: color,
          height: lineSpacing),
    );
  }

  static Text jakartaSansSemiBold(String title,
      {TextAlign? textAlign,
        Color? color,
        double? size,
        int? maxLines,
        TextOverflow? overflow,
        double? lineSpacing}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: textPlusJakartaSansSetting(
          size: size ?? 12.0,
          fontWeight: FontWeight.w600,
          color: color,
          height: lineSpacing),
    );
  }

  static TextStyle textPlusJakartaSansSetting(
      {double? size, FontWeight? fontWeight, Color? color, double? height}) {
    return TextStyle(
        fontFamily: 'PlusJakartaSans',
        fontSize: size ?? 12.0,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? ColorWidget.iconColor,
        height: height);
  }
}