import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/empty_widget.dart';
import 'package:fansedu/features/notification/widgets/item_notification_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int count = Random().nextInt(10);

  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: BackAppBar(
        context,
        "Notification",
        elevation: 0.0,
        backgroundColor: Colors.white
      ),
      child: SafeArea(
        child: (count > 0) ? SingleChildScrollView(
          child: LeftAlignedColumn(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return ItemNotificationWidget(
                      icon: "ic_check",
                      title: "notification ${index+1}",
                      desc: "sample of notification",
                      time: "${index+1} day ago",
                      isRead: (index % 2 == 0) ? true : false,
                      onTap: () {}
                  ).verticalPadded(8);
                }
              )
            ],
          ).horizontalPadded(24),
        ) : EmptyWidget(
          title: "Notification Empty",
          desc: "No notification found in your account!",
        )
      ),
    );
  }
}
