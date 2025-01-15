import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/core/widgets/action_button_widget.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: LeftAlignedColumn(
              children: [
                Center(
                  child: SvgPicture.asset(
                    getSourceBySvg("ic_welcome"),
                    width: MediaQuery.of(context).size.width * 0.8,
                  )
                ),
                TextWidget.jakartaSansBold("Unlock Your Learning Potential", size: 32, textAlign: TextAlign.center, color: ColorWidget.primaryColor).padded(24),
                TextWidget.jakartaSansRegular("Your gateway to personalized courses, And guidance for success.", textAlign: TextAlign.center, size: 20, color: ColorWidget.iconColor).horizontalPadded(),
                LeftAlignedRow(
                  children: [
                    Expanded(
                      child: ActionButtonWidget(
                        title: "SIGN IN",
                        onTap: () => context.router.push(LoginRoute()),
                        isActive: true
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ActionButtonWidget(
                          title: "SIGN UP",
                          onTap: () => context.router.push(RegisterRoute()),
                          isActive: false
                      ),
                    )
                  ]
                ).padded(24)
              ],
            ),
          ),
        ) 
      ),
    );
  }
}