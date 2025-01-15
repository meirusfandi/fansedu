import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
      child: SafeArea(
        child: Stack(
          children: [
            LeftAlignedColumn(
              children: []
            ),
            Positioned(
              bottom: 32,
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
        )
      )
    );
  }
}
