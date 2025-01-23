import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/constants/constants.dart';
import 'package:fansedu/core/resources/injection_container.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/core/widgets/action_button_widget.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_form_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _formKey = GlobalKey<FormState>();

  bool checkCondition() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (!state.isLoading && state.resetPasswordEntity != null) {
          if (state.resetPasswordEntity?.success ?? false) {
            showSuccess(context, state.resetPasswordEntity?.message ?? '');
            context.router.replaceAll([LoginRoute()]);
          } else {
            showError(context, state.resetPasswordEntity?.message ?? '');
          }
        }
      },
      builder: (context, state) {
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
                child: Form(
                  key: _formKey,
                  child: LeftAlignedColumn(
                    children: [
                      Center(child: TextWidget.jakartaSansBold("Reset Password", size: 32, textAlign: TextAlign.center, color: ColorWidget.primaryColor).horizontalPadded(24)),
                      TextWidget.jakartaSansRegular("Reset your password to regain access to your learning journey", size: 16, color: ColorWidget.iconColor, textAlign: TextAlign.center, maxLines: 3).horizontalPadded(24).verticalPadded(),
                      TextFormWidget(
                          labelText: "Email Here",
                          hintText: "youremail@gmail.com",
                          controller: _emailController,
                          validator: (val) {
                            if (val?.isEmpty ?? false) {
                              return "Email must be filled";
                            }
                            return null;
                          },
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
                        validator: (val) {
                          if (val?.isEmpty ?? false) {
                            return "Password must be filled";
                          }
                          return null;
                        },
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
                        validator: (val) {
                          if ((val?.isEmpty ?? false) || (val?.contains(_passwordController.text) ?? false)) {
                            return "Password not match";
                          } else {
                            null;
                          }
                          return null;
                        },
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
                        title: "Reset Password",
                        onTap: checkCondition() ? () {
                          sl<AuthBloc>().add(ProcessResetEvent(email: _emailController.text, password: _passwordController.text));
                        } : null,
                        isActive: checkCondition()
                      ).horizontalPadded(24).verticalPadded()
                    ]
                  ),
                ),
              ),
            )
          ),
        );
      }
    );
  }
}
