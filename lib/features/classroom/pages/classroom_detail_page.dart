import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ClassRoomDetailPage extends StatefulWidget {
  const ClassRoomDetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _ClassRoomDetailPageState();
}

class _ClassRoomDetailPageState extends State<ClassRoomDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: BackAppBar(context, "Class Room Detail", elevation: 0.0, backgroundColor: Colors.white,),
      child: SafeArea(child: SingleChildScrollView()),
    );
  }
}
