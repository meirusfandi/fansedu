import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ClassRoomEnrollPage extends StatefulWidget {
  const ClassRoomEnrollPage({super.key});

  @override
  State<StatefulWidget> createState() => _ClassRoomEnrollPageState();
}

class _ClassRoomEnrollPageState extends State<ClassRoomEnrollPage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: BackAppBar(context, "Class Room Enroll", elevation: 0.0, backgroundColor: Colors.white,),
      child: SafeArea(child: SingleChildScrollView()),
    );
  }
}
