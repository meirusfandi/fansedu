import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/constants/constants.dart';
import 'package:fansedu/core/widgets/action_button_widget.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_form_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
        backColor: Colors.black,
        onTap: () => context.maybePop(),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      child: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: LeftAlignedColumn(
                  children: [
                    Center(child: TextWidget.jakartaSansBold("SIGN UP", size: 32, color: ColorWidget.primaryColor, textAlign: TextAlign.center).horizontalPadded(24)),
                    Center(
                      child: TextWidget.jakartaSansRegular("Create your account to embark on your educational adventure", size: 16, color: ColorWidget.iconColor, textAlign: TextAlign.center, maxLines: 2).horizontalPadded(24).verticalPadded(),
                    ),
                    TextFormWidget(
                        labelText: "Full Name",
                        hintText: "Your Name",
                        controller: _nameController,
                        onChanged: (_) { setState(() {}); },
                        type: TextFieldType.text
                    ).horizontalPadded(24).verticalPadded(8),
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
                    TextFormWidget(
                      labelText: "Confirm Password",
                      hintText: "Confirm password",
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
                    ).horizontalPadded(24).topPadded().bottomPadded(8),
                    ActionButtonWidget(
                        title: "SIGN UP",
                        onTap: () {},
                        isActive: true
                    ).horizontalPadded(24).topPadded()
                  ]
              ),
            ).bottomPadded(48),
            Positioned(
                bottom: 20,
                left: 32,
                right: 32,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Already have an  Account? ",
                            style: TextStyle(
                                fontFamily: "PlusJakartaSans",
                                fontSize: 12,
                                color: ColorWidget.iconColor
                            )
                        ),
                        TextSpan(
                            text: "Sign In here",
                            style: TextStyle(
                                fontFamily: "PlusJakartaSans",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: ColorWidget.blackColor
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () => context.maybePop()
                        )
                      ]
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
