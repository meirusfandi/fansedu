import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
