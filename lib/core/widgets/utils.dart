import 'package:fansedu/core/config/model/info_item.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

String getSourceByPng(String nameImage,
    {String path = 'assets/png/', String ext = 'png'}) {
  return '$path$nameImage.$ext';
}

String getSourceByJpg(String nameImage,
    {String path = 'assets/jpg/', String ext = 'jpg'}) {
  return '$path$nameImage.$ext';
}

String getSourceBySvg(String nameImage,
    {String path = 'assets/svg/', String ext = 'svg'}) {
  return '$path$nameImage.$ext';
}

String getSourceByPdf(String nameImage,
    {String path = 'assets/pdf/', String ext = 'pdf'}) {
  return '$path$nameImage.$ext';
}

double dp(BuildContext context, double value) {
  return value / MediaQuery.of(context).devicePixelRatio;
}

List<DropdownMenuItem<String>> infoItemsToDropdown(List<InfoItem> items) =>
    items
        .map((o) => DropdownMenuItem(
        value: o.title,
        child: TextWidget.jakartaSansRegular(o.content ?? '',
            color: Colors.black, size: 14)))
        .toList();
