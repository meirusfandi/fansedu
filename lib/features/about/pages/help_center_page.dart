import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/constants/constants.dart';
import 'package:fansedu/core/widgets/action_button_widget.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_form_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<StatefulWidget> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  bool checkCondition() {
    return _formKey.currentState?.validate() ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return Loadable(
        backgroundColor: Colors.white,
        appBar: BackAppBar(
          context, "Help Center",
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          child: ActionButtonWidget(
            onTap: checkCondition() ? () {} : null,
            title: "Send",
            isActive: checkCondition(),
          ).horizontalPadded().topPadded().bottomPadded(32),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
              child: LeftAlignedColumn(
                  children: [
                    TextWidget.jakartaSansRegular("Fans education still in development. For any question please enter here! Your response will display in your notification", size: 14, color: ColorWidget.blackColor, textAlign: TextAlign.center).verticalPadded(24),
                    TextFormWidget(
                        labelText: "Full Name",
                        hintText: "Enter your full name",
                        controller: _nameController,
                        onChanged: (_) {},
                        type: TextFieldType.text,
                    ),
                    TextFormWidget(
                      labelText: "Email Address",
                      hintText: "Enter your email",
                      controller: _emailController,
                      onChanged: (_) {},
                      type: TextFieldType.email,
                      isDisableForm: true,
                    ).topPadded(),
                    TextFormWidget(
                      labelText: "Your Insight Title",
                      hintText: "Enter your insight here",
                      controller: _titleController,
                      onChanged: (_) {},
                      type: TextFieldType.text,
                    ).topPadded(),
                    TextFormWidget(
                      labelText: "Your Detail Insight",
                      hintText: "Enter your detail insight here",
                      controller: _contentController,
                      onChanged: (_) {},
                      type: TextFieldType.multiline,
                    ).topPadded(),
                  ]
              ).horizontalPadded(24),
            )
        )
    );
  }
}
