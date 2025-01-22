import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/features/profile/widgets/user_menu_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<StatefulWidget> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
        backgroundColor: Colors.white,
        appBar: BackAppBar(
          context,
          "Security Account",
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: LeftAlignedColumn(
              children: [
                UserMenuWidget(
                    iconLeading: "ic_security",
                    title: "Change Password",
                    onTap: () => context.pushRoute(ChangePasswordRoute())
                ).verticalPadded(),
                Divider(),
                UserMenuWidget(
                    iconLeading: "ic_security",
                    title: "Request Delete Account",
                    onTap: () => context.pushRoute(DeleteAccountRoute()),
                ).verticalPadded(),
              ]
            ).padded(),
          )
        )
    );
  }
}
