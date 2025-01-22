import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ClassRoomListPage extends StatefulWidget {
  const ClassRoomListPage({super.key});

  @override
  State<StatefulWidget> createState() => _ClassRoomListPageState();
}

class _ClassRoomListPageState extends State<ClassRoomListPage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: BackAppBar(context, "Class Room List", elevation: 0.0, backgroundColor: Colors.white,),
      child: SafeArea(child: SingleChildScrollView()),
    );
  }
}
