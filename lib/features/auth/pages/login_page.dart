import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/constants/constants.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/core/widgets/action_button_widget.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_form_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool seePassword = false;

  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: LeftAlignedColumn(
                children: [
                  Center(child: TextWidget.jakartaSansBold("SIGN IN", size: 32, color: ColorWidget.primaryColor, textAlign: TextAlign.center).horizontalPadded(24)),
                  Center(
                    child: TextWidget.jakartaSansRegular("Sign in to access your personalized learning journey", size: 16, color: ColorWidget.iconColor, textAlign: TextAlign.center, maxLines: 2).horizontalPadded(24).verticalPadded(),
                  ),
                  TextFormWidget(
                      labelText: "Email Here",
                      hintText: "youremail@gmail.com",
                      controller: _emailController,
                      onChanged: (_) { setState(() {}); },
                      type: TextFieldType.email
                  ).horizontalPadded(24).verticalPadded(8),
                  TextFormWidget(
                    labelText: "Password",
                    hintText: "password",
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
                  ).horizontalPadded(24).topPadded().bottomPadded(8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.router.push(ResetPasswordRoute()),
                      child: TextWidget.jakartaSansRegular("Forgot Password?", size: 12, color: ColorWidget.iconColor).horizontalPadded(24),
                    ),
                  ),
                  ActionButtonWidget(
                      title: "SIGN IN",
                      onTap: () {},
                      isActive: true
                  ).horizontalPadded(24).topPadded()
                ]
              ),
            ).bottomPadded(32),
            Positioned(
              bottom: 20,
              left: 32,
              right: 32,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don’t have an  Account? ",
                      style: TextStyle(
                        fontFamily: "PlusJakartaSans",
                        fontSize: 12,
                        color: ColorWidget.iconColor
                      )
                    ),
                    TextSpan(
                      text: "Sign Up here",
                      style: TextStyle(
                        fontFamily: "PlusJakartaSans",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ColorWidget.blackColor
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () => context.router.push(RegisterRoute())
                    )
                  ]
                ),
              )
            )
          ],
        ),
      )
    );
  }
}
