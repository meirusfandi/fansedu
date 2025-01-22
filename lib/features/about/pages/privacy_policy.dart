import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<StatefulWidget> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: BackAppBar(context, "Privacy Policy", elevation: 0.0, backgroundColor: Colors.white,),
      child: SafeArea(child: SingleChildScrollView()),
    );
  }
}
