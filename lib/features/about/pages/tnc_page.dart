import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TncPage extends StatefulWidget {
  const TncPage({super.key});

  @override
  State<StatefulWidget> createState() => _TncPageState();
}

class _TncPageState extends State<TncPage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: BackAppBar(context, "TnC", elevation: 0.0, backgroundColor: Colors.white,),
      child: SafeArea(child: SingleChildScrollView()),
    );
  }
}
