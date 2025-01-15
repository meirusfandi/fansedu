import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/constants/constants.dart';
import 'package:fansedu/core/widgets/action_button_widget.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_form_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool seePassword = false;
  bool seePasswordConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: CustomBackAppbar(
        context,
        "",
        icon: Icons.arrow_back,
        onTap: () => context.maybePop(),
        elevation: 0.0,
        backColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: LeftAlignedColumn(
              children: [
                Center(child: TextWidget.jakartaSansBold("Reset Password", size: 32, textAlign: TextAlign.center, color: ColorWidget.primaryColor).horizontalPadded(24)),
                TextWidget.jakartaSansRegular("Reset your password to regain access to your learning journey", size: 16, color: ColorWidget.iconColor, textAlign: TextAlign.center, maxLines: 3).horizontalPadded(24).verticalPadded(),
                TextFormWidget(
                    labelText: "Email Here",
                    hintText: "youremail@gmail.com",
                    controller: _emailController,
                    onChanged: (_) { setState(() {}); },
                    type: TextFieldType.email
                ).horizontalPadded(24).verticalPadded(8),
                TextFormWidget(
                  labelText: "New Password",
                  hintText: "*************************",
                  controller: _passwordController,
                  onChanged: (_) { setState(() {}); },
                  type: TextFieldType.password,
                  isObscureText: seePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        seePassword = !seePassword;
                      });
                    },
                    icon: (seePassword)
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ).horizontalPadded(24).verticalPadded(),
                TextFormWidget(
                  labelText: "Confirm Password",
                  hintText: "*************************",
                  controller: _confirmPasswordController,
                  onChanged: (_) { setState(() {}); },
                  type: TextFieldType.password,
                  isObscureText: seePasswordConfirm,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        seePasswordConfirm = !seePasswordConfirm;
                      });
                    },
                    icon: (seePasswordConfirm)
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ).horizontalPadded(24).verticalPadded(),
                ActionButtonWidget(
                  title: "Save",
                  onTap: () {},
                  isActive: false
                ).horizontalPadded(24).verticalPadded()
              ] 
            ),
          ),
        )
      ),
    );
  }
}
