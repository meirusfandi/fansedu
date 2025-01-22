import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
        backgroundColor: Colors.white,
        appBar: BackAppBar(
          context,
          "Change Password",
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        child: SafeArea(child: SingleChildScrollView())
    );
  }
}
