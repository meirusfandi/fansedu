import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
      appBar: CustomBackAppbar(
        context,
        "",
        icon: Icons.arrow_back,
        onTap: () {},
        elevation: 0.0,
        backgroundColor: ColorWidget.whiteColor,
      ),
      child: SafeArea(
          child: SingleChildScrollView()
      ),
    );
  }
}
