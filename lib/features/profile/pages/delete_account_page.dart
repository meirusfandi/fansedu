import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<StatefulWidget> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: BackAppBar(
        context,
        "Request Delete Account",
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      child: SafeArea(
        child: SingleChildScrollView()
      )
    );
  }
}
