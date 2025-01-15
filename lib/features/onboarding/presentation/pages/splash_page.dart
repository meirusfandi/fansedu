import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/common/package_info_data.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:fansedu/generated/l10n.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..forward()
      ..addStatusListener((_) async {
        await initialProcess();
      });
  }

  Future<void> initialProcess() async {
    context.router.replaceAll([LoginRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CenterAlignedColumn(
                  children: [
                    Image.asset(
                      getSourceByPng('app_logo'),
                      height: 128,
                      width: 128,
                    ),
                    const CircularProgressIndicator().topPadded(75),
                  ],
                ),
              ).topPadded(MediaQuery.of(context).size.height / 5),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TextWidget.jakartaSansRegular(
                      S.of(context).general_app_version(packageInfo.version ?? ''),
                      size: 16,
                      color: ColorWidget.greyColor))
                  .bottomPadded(48),
            ],
          )),
    );
  }
}
