import 'package:fansedu/core/config/model/info_item.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:fansedu/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShadowedContainer extends StatelessWidget {
  final List<Widget> children;

  final Widget? hero;

  final bool noPadding;

  final double? width;

  final double? borderRadius;

  final bool useUpRadius;

  final double padding;
  final bool useOffset;

  final EdgeInsets? margin;

  const ShadowedContainer({
    super.key,
    required this.children,
    this.hero,
    this.borderRadius,
    this.noPadding = false,
    this.useUpRadius = false,
    this.useOffset = false,
    this.width,
    this.margin,
    this.padding = 16,
  });

  @override
  Widget build(context) {
    final content = LeftAlignedColumn(
      children: children,
    );
    final padded = Padding(
      padding: EdgeInsets.all(padding),
      child: content,
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: useUpRadius
            ? BorderRadius.only(
            topLeft: Radius.circular(borderRadius ?? 8),
            topRight: Radius.circular(borderRadius ?? 8))
            : BorderRadius.circular(borderRadius ?? 8),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.15),
            spreadRadius: -1,
            offset: useOffset ? const Offset(0, -5) : const Offset(-1, 1),
          ),
          useOffset
              ? const BoxShadow(
              blurRadius: 8,
              color: Colors.white,
              spreadRadius: 2,
              offset: Offset(3, 3))
              : const BoxShadow(),
        ],
        color: Colors.white,
      ),
      width: width,
      child: hero == null
          ? (noPadding ? content : padded)
          : Column(
        children: [
          hero!,
          (noPadding ? content : padded),
        ],
      ),
    );
  }
}

class GenericCard extends StatelessWidget {
  const GenericCard({
    super.key,
    this.offset = const Offset(0, 8),
    this.blurRadius = 16,
    this.spreadRAdius = 0,
    this.shadowColor = const Color.fromRGBO(0, 0, 0, 0.08),
    this.borderRadius = 16,
    this.color = Colors.white,
    this.margin,
    required this.child,
  });
  final Color shadowColor;
  final Color color;
  final double blurRadius;
  final Offset offset;
  final double spreadRAdius;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            spreadRadius: spreadRAdius,
            color: shadowColor,
          ),
        ],
      ),
      child: child,
    );
  }
}

class LeftAlignedColumn extends StatelessWidget {
  final List<Widget> children;

  const LeftAlignedColumn({
    super.key,
    required this.children,
  });

  @override
  Widget build(context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: children,
  );
}

class CenterAlignedColumn extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const CenterAlignedColumn({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
    required this.children,
  });

  @override
  Widget build(context) => Column(
    crossAxisAlignment: crossAxisAlignment,
    mainAxisAlignment: mainAxisAlignment,
    mainAxisSize: MainAxisSize.min,
    children: children,
  );
}

class RightAlignedColumn extends StatelessWidget {
  final List<Widget> children;

  const RightAlignedColumn({
    super.key,
    required this.children,
  });

  @override
  Widget build(context) => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: children,
  );
}

class LeftAlignedRow extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  const LeftAlignedRow({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(context) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: crossAxisAlignment,
    mainAxisSize: MainAxisSize.min,
    children: children,
  );
}

class RightAlignedRow extends StatelessWidget {
  final List<Widget> children;

  const RightAlignedRow({
    super.key,
    required this.children,
  });

  @override
  Widget build(context) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: children,
  );
}

class CenterAlignedRow extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;

  final List<Widget> children;

  const CenterAlignedRow({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
  });

  @override
  Widget build(context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: children,
  );
}

class SideToSideRow extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;

  final Widget left;

  final Widget right;

  const SideToSideRow({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    required this.left,
    required this.right,
  });

  @override
  Widget build(context) => Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: crossAxisAlignment,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      left,
      right,
    ],
  );
}

class ShimmerBox extends Container {
  ShimmerBox({
    super.key,
    super.height,
    super.width,
  }) : super(
    decoration: BoxDecoration(
        color: ColorWidget.greyColor, borderRadius: BorderRadius.circular(6)),
    padding: const EdgeInsets.all(6),
  );
}

extension PaddedWidget on Widget {
  Widget rightPadded([final value = 16]) => Padding(
    padding: EdgeInsets.only(right: value.toDouble()),
    child: this,
  );
  Widget topPadded([final value = 16]) => Padding(
    padding: EdgeInsets.only(top: value.toDouble()),
    child: this,
  );
  Widget leftPadded([final value = 16]) => Padding(
    padding: EdgeInsets.only(left: value.toDouble()),
    child: this,
  );
  Widget bottomPadded([final value = 16]) => Padding(
    padding: EdgeInsets.only(bottom: value.toDouble()),
    child: this,
  );
  Widget verticalPadded([final value = 16]) => Padding(
    padding: EdgeInsets.symmetric(vertical: value.toDouble()),
    child: this,
  );
  Widget horizontalPadded([final value = 16]) => Padding(
    padding: EdgeInsets.symmetric(horizontal: value.toDouble()),
    child: this,
  );
  Widget padded([final value = 16]) => Padding(
    padding: EdgeInsets.all(value.toDouble()),
    child: this,
  );
  Widget withoutTopPadded([final value = 16]) => Padding(
    padding: EdgeInsets.only(
        left: value.toDouble(),
        right: value.toDouble(),
        bottom: value.toDouble()),
    child: this,
  );
  Widget withoutBottomPadded([final value = 16]) => Padding(
    padding: EdgeInsets.only(
        left: value.toDouble(),
        top: value.toDouble(),
        right: value.toDouble()),
    child: this,
  );
  Widget withoutLeftPadded([final value = 16]) => Padding(
    padding: EdgeInsets.only(
        right: value.toDouble(),
        top: value.toDouble(),
        bottom: value.toDouble()),
    child: this,
  );
  Widget withoutRightPadded([final value = 16]) => Padding(
    padding: EdgeInsets.only(
        left: value.toDouble(),
        top: value.toDouble(),
        bottom: value.toDouble()),
    child: this,
  );
}

extension MarginWidget on Widget {
  Widget rightMargin([final value = 16]) => Container(
    margin: EdgeInsets.only(right: value.toDouble()),
    child: this,
  );
  Widget topMargin([final value = 16]) => Container(
    margin: EdgeInsets.only(top: value.toDouble()),
    child: this,
  );
  Widget leftMargin([final value = 16]) => Container(
    margin: EdgeInsets.only(left: value.toDouble()),
    child: this,
  );
  Widget bottomMargin([final value = 16]) => Container(
    margin: EdgeInsets.only(bottom: value.toDouble()),
    child: this,
  );
  Widget verticalMargin([final value = 16]) => Container(
    margin: EdgeInsets.symmetric(vertical: value.toDouble()),
    child: this,
  );
  Widget horizontalMargin([final value = 16]) => Container(
    margin: EdgeInsets.symmetric(horizontal: value.toDouble()),
    child: this,
  );
  Widget margin([final value = 16]) => Container(
    margin: EdgeInsets.all(value.toDouble()),
    child: this,
  );
  Widget withoutTopMargin([final value = 16]) => Container(
    margin: EdgeInsets.only(
        left: value.toDouble(),
        right: value.toDouble(),
        bottom: value.toDouble()),
    child: this,
  );
  Widget withoutBottomMargin([final value = 16]) => Container(
    margin: EdgeInsets.only(
        left: value.toDouble(),
        top: value.toDouble(),
        right: value.toDouble()),
    child: this,
  );
  Widget withoutLeftMargin([final value = 16]) => Container(
    margin: EdgeInsets.only(
        right: value.toDouble(),
        top: value.toDouble(),
        bottom: value.toDouble()),
    child: this,
  );
  Widget withoutRightMargin([final value = 16]) => Container(
    margin: EdgeInsets.only(
        left: value.toDouble(),
        top: value.toDouble(),
        bottom: value.toDouble()),
    child: this,
  );
}

Future<void> showSheet(BuildContext ctx, Widget sheet,
    {bool isControlled = true}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: isControlled,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: sheet,
    ),
    context: ctx,
    isScrollControlled: isControlled,
    enableDrag: isControlled,
  );
}

void showAlertGeneral(BuildContext ctx, String text,
    {bool isControlled = true}) {
  AwesomeDialog(
    context: ctx,
    enableEnterKey: true,
    dialogType: DialogType.noHeader,
    btnOkColor: ColorWidget.primaryColor,
    headerAnimationLoop: false,
    body: TextWidget.jakartaSansMedium(
      text,
      color: ColorWidget.primaryColor,
      size: 18,
      textAlign: TextAlign.center,
    )
        .padded(),
    btnOkOnPress: () {},
    btnOkText: S.of(ctx).general_close,
  ).show();
}

void showAlertCommingSoon(BuildContext ctx, {bool isControlled = true}) {
  AwesomeDialog(
    context: ctx,
    enableEnterKey: true,
    dialogType: DialogType.noHeader,
    btnOkColor: ColorWidget.primaryColor,
    headerAnimationLoop: false,
    body: TextWidget.jakartaSansMedium(S.of(ctx).general_coming_soon,
        size: 18, color: ColorWidget.primaryColor)
        .padded(),
    btnOkOnPress: () {},
    btnOkText: S.of(ctx).general_close,
  ).show();
}

void showAlertPermission(BuildContext ctx,
    {required String text, required Function()? onTap}) {
  AwesomeDialog(
    context: ctx,
    enableEnterKey: true,
    dialogType: DialogType.noHeader,
    btnOkColor: ColorWidget.primaryColor,
    headerAnimationLoop: false,
    body: TextWidget.jakartaSansMedium(
      text,
      color: ColorWidget.primaryColor,
      size: 18,
      textAlign: TextAlign.center,
    )
        .padded(),
    isDense: true,
    btnOkOnPress: onTap,
    btnOkText: S.of(ctx).button_permission,
  ).show();
}

void showAlert(BuildContext ctx,
    {bool isControlled = true,
      required String text,
      required VoidCallback yes}) {
  showDialog<void>(
    context: ctx,
    barrierDismissible: isControlled,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextWidget.jakartaSansBold(S.of(context).general_confirm,
            size: 18, color: Colors.black),
        content: TextWidget.jakartaSansRegular(text, color: Colors.black, size: 14),
        actions: <Widget>[
          TextButton(
            child: TextWidget.jakartaSansBold(S.of(context).general_no,
                size: 14, color: ColorWidget.primaryColor),
            onPressed: () {
              ctx.router.back();
            },
          ),
          TextButton(
            onPressed: yes,
            child: TextWidget.jakartaSansBold(S.of(context).general_yes,
                size: 14, color: ColorWidget.primaryColor),
          ),
        ],
      );
    },
  );
}

Future<dynamic> showDialogue(BuildContext context, String title,
    String description, String icons, VoidCallback onTap) {
  return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: TextWidget.jakartaSansRegular(title, size: 29, textAlign: TextAlign.center),
          content: CenterAlignedColumn(
            children: [
              Image.asset(
                getSourceByPng(icons),
                fit: BoxFit.contain,
                height: 120,
              ).padded(),
              TextWidget.jakartaSansRegular(description,
                  size: 14, textAlign: TextAlign.center),
            ],
          ),
          actions: [
            GenericButton(
              S.of(context).general_oke_button,
              ontap: onTap,
              color: ColorWidget.primaryColor,
              borderRadius: 36,
            ).horizontalPadded(),
          ],
        );
      });
}

OutlineInputBorder textFormFieldBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      width: 1.5,
      color: ColorWidget.greyColor,
      style: BorderStyle.solid,
    ),
  );
}

class GenericTabBarView extends StatefulWidget {
  final double? height;
  final Color inactiveIndicatorColor;
  final TabController? controller;
  final void Function(int)? onTap;
  final Color activeIndicatorColor;
  final Color? inactiveLabelColor;
  final Color? activeLabelColor;
  final List<Widget> tabs;
  final EdgeInsetsGeometry? contentPadding;
  const GenericTabBarView({
    super.key,
    this.height = 60,
    required this.inactiveIndicatorColor,
    this.controller,
    this.onTap,
    required this.activeIndicatorColor,
    this.inactiveLabelColor,
    this.activeLabelColor,
    this.contentPadding = const EdgeInsets.all(0),
    required this.tabs,
  });

  @override
  State<GenericTabBarView> createState() => _GenericTabBarViewState();
}

class _GenericTabBarViewState extends State<GenericTabBarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.0),
        border: Border(
            bottom: BorderSide(color: widget.inactiveIndicatorColor, width: 1)),
      ),
      child: TabBar(
        controller: widget.controller,
        onTap: widget.onTap,
        padding: widget.contentPadding,
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: widget.activeIndicatorColor,
              width: 2,
            )),
        labelColor: widget.activeLabelColor,
        unselectedLabelColor: widget.inactiveLabelColor,
        tabs: widget.tabs,
      ),
    );
  }
}

class BottomDrawer extends StatelessWidget {
  final Widget child;

  final bool withBack;

  const BottomDrawer({
    super.key,
    required this.child,
    this.withBack = false,
  });

  @override
  Widget build(context) => withBack
      ? Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: _backButton(context),
      ),
      _main(),
    ],
  )
      : _main();

  Widget _main() => Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      color: Colors.white,
    ),
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
    child: child,
  );

  Widget _backButton(BuildContext ctx) => ElevatedButton(
    onPressed: () => Navigator.of(ctx).pop(),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shape: const CircleBorder(),
    ),
    child: const Icon(Icons.arrow_back_ios),
  );
}

class BottomDrawerWithoutPadding extends StatelessWidget {
  final Widget child;

  final bool withBack;

  const BottomDrawerWithoutPadding({
    super.key,
    required this.child,
    this.withBack = false,
  });

  @override
  Widget build(context) => withBack
      ? Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: _backButton(context),
      ),
      _main(),
    ],
  )
      : _main();

  Widget _main() => SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      // padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: child,
    ),
  );

  Widget _backButton(BuildContext ctx) => ElevatedButton(
    onPressed: () => Navigator.of(ctx).pop(),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shape: const CircleBorder(),
    ),
    child: const Icon(Icons.arrow_back_ios),
  );
}

Widget loader() => BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
  child: Container(
    color: Colors.grey[200]!.withOpacity(0.4),
    child: Center(
      child: SpinKitThreeBounce(
        color: Colors.grey[400],
      ),
    ),
  ),
);

class Loadable extends StatefulWidget {
  final Widget? action;

  final Function()? onRefresh;

  final RefreshController? refreshController;

  final PreferredSizeWidget? appBar;

  final Color? backgroundColor;

  final Widget? bottomNavigationBar;

  final Widget? bottomSheet;

  final Widget child;

  final Widget? extra;

  final Widget? floatingActionButton;

  final bool loading;

  final bool safeTop;

  final bool isUsingGradient;

  final bool extendBodyBehindAppBar;

  const Loadable({
    super.key,
    this.action,
    this.appBar,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    required this.child,
    this.extra,
    this.floatingActionButton,
    this.loading = false,
    this.safeTop = true,
    this.isUsingGradient = true,
    this.extendBodyBehindAppBar = false,
    this.onRefresh,
    this.refreshController,
  });

  @override
  createState() => _State();
}

class _State extends State<Loadable> {
  @override
  Widget build(ctx) => widget.refreshController != null
      ? MediaQuery(
    data: MediaQuery.of(context)
        .copyWith(textScaler: const TextScaler.linear(1.0)),
    child: SmartRefresher(
      controller: widget.refreshController ??
          RefreshController(initialRefresh: false),
      enablePullUp: true,
      onRefresh: () {
        widget.refreshController?.refreshCompleted();
        widget.refreshController?.loadComplete();
        widget.onRefresh?.call();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Scaffold(
            appBar: widget.appBar,
            backgroundColor: widget.backgroundColor,
            extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
            body: Stack(
              fit: StackFit.expand,
              children: [
                widget.child,
                if (widget.extra != null) widget.extra!,
                Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.bottomSheet ?? const SizedBox()),
              ],
            ),
            bottomNavigationBar: widget.bottomNavigationBar,
            floatingActionButton: widget.floatingActionButton,
          ),
          if (widget.loading) loader(),
        ],
      ),
    ),
  )
      : MediaQuery(
    data: MediaQuery.of(context)
        .copyWith(textScaler: const TextScaler.linear(1.0)),
    child: Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: widget.appBar,
          backgroundColor: widget.backgroundColor,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
          body: Stack(
            fit: StackFit.expand,
            children: [
              widget.child,
              if (widget.extra != null) widget.extra!,
              Align(
                  alignment: Alignment.bottomCenter,
                  child: widget.bottomSheet ?? const SizedBox()),
            ],
          ),
          bottomNavigationBar: widget.bottomNavigationBar,
          floatingActionButton: widget.floatingActionButton,
        ),
        if (widget.loading) loader(),
      ],
    ),
  );
}

class GenericButton extends StatelessWidget {
  final VoidCallback ontap;
  final bool disable;
  final String text;
  final Color color;
  final double? borderRadius;
  const GenericButton(this.text,
      {super.key,
        required this.ontap,
        this.disable = false,
        required this.color,
        this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: !disable ? ontap : null,
      child: Ink(
        decoration: BoxDecoration(
            color: !disable ? color : ColorWidget.greyColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 12)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: !disable
              ? TextWidget.jakartaSansBold(text,
              textAlign: TextAlign.center, size: 16, color: Colors.white)
              : TextWidget.jakartaSansBold(text,
              textAlign: TextAlign.center,
              size: 16,
              color: ColorWidget.greyColor),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback ontap;
  final bool disable;
  final Color? color;
  final Widget? child;
  final double radius;
  const CustomButton(
      {super.key,
        required this.ontap,
        this.disable = false,
        this.color,
        this.child,
        this.radius = 12.0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: !disable ? ontap : null,
      child: Ink(
        decoration: BoxDecoration(
            color: !disable ? (color ?? ColorWidget.primaryColor) : ColorWidget.greyColor,
            borderRadius: BorderRadius.circular(8)),
        child: child,
      ),
    );
  }
}

class GenericCustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final double paddingUpAndButton;
  final double paddingLeftAndRight;
  final bool isUsingBorder;
  final Color color;
  final Color borderColor;
  final double radius;
  final double borderThickness;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  const GenericCustomButton({
    super.key,
    required this.widget,
    required this.onPressed,
    this.borderColor = Colors.white,
    this.borderThickness = 0.0,
    this.color = Colors.white,
    this.height,
    this.isUsingBorder = false,
    this.paddingLeftAndRight = 0.0,
    this.paddingUpAndButton = 0.0,
    this.radius = 0.0,
    this.width,
    this.marginTop = 0.0,
    this.marginBottom = 0.0,
    this.marginLeft = 0.0,
    this.marginRight = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: ColorWidget.greyColor),
        child: GenericBoxButton(
          widget: widget,
          borderColor: borderColor,
          borderThickness: borderThickness,
          color: color,
          height: height,
          isUsingBorder: isUsingBorder,
          paddingLeftAndRight: paddingLeftAndRight,
          paddingUpAndButton: paddingUpAndButton,
          radius: radius,
          width: width,
          marginBottom: marginBottom,
          marginLeft: marginLeft,
          marginRight: marginRight,
          marginTop: marginTop,
        ),
      ),
    );
  }
}

class GenericBoxButton extends Container {
  GenericBoxButton({
    super.key,
    required Widget widget,
    super.height,
    super.width,
    double paddingUpAndButton = 0.0,
    double paddingLeftAndRight = 0.0,
    bool isUsingBorder = false,
    Color color = Colors.transparent,
    Color borderColor = Colors.white,
    double marginTop = 0.0,
    double marginBottom = 0.0,
    double marginLeft = 0.0,
    double marginRight = 0.0,
    double radius = 0.0,
    double borderThickness = 0.0,
  }) : super(
    margin: EdgeInsets.only(
        bottom: marginBottom,
        top: marginTop,
        left: marginLeft,
        right: marginRight),
    child: widget,
    padding: EdgeInsets.only(
        left: paddingLeftAndRight,
        right: paddingLeftAndRight,
        top: paddingUpAndButton,
        bottom: paddingUpAndButton),
    decoration: BoxDecoration(
      color: color,
      border: isUsingBorder
          ? Border.all(color: borderColor, width: borderThickness)
          : null,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    ),
  );
}

class BackAppBar extends AppBar {
  BackAppBar(
      BuildContext ctx,
      String text, {
        super.key,
        List<Widget> super.actions = const [],
        super.bottom,
        bool forceBack = false,
        bool center = false,
        super.elevation,
        bool? usingCrossBack,
        Color? crossBackColor,
        super.backgroundColor,
      }) : super(
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark),
    centerTitle: center,
    leading: (ModalRoute.of(ctx)?.canPop ?? false) || forceBack
        ? (usingCrossBack ?? false)
        ? IconButton(
        onPressed: () => ctx.router.back(),
        icon: Icon(Icons.close,
            color: crossBackColor ?? Colors.white, size: 24))
        : const AutoLeadingButton(
        color: Color.fromARGB(255, 0, 53, 119))
        : null,
    title: TextWidget.jakartaSansBold(text, size: 18, color: ColorWidget.blackColor),
  );
}

class CustomBackAppbar extends AppBar {
  CustomBackAppbar(
      BuildContext ctx,
      String text, {
        super.key,
        List<Widget> super.actions = const [],
        super.bottom,
        bool center = false,
        super.elevation,
        Color? backColor,
        required IconData icon,
        required VoidCallback onTap,
        double size = 24.0,
        super.backgroundColor,
      }) : super(
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark),
    centerTitle: center,
    leading: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: backColor ?? Colors.white, size: size)),
    title: TextWidget.jakartaSansBold(text, size: 18, color: ColorWidget.blackColor),
  );
}

class Spinner<T> extends StatelessWidget {
  final bool autofocus;

  final bool dense;

  final String? helperText;

  final String? hintText;

  final List<DropdownMenuItem<T>> items;

  final String? label;

  final ValueChanged<T?>? onChanged;

  final FormFieldSetter<T>? onSaved;

  final FormFieldValidator<T>? validator;

  final T? value;

  final bool isExpanded;

  final bool isFullRounded;

  const Spinner({
    super.key,
    this.autofocus = false,
    this.dense = false,
    this.helperText,
    this.hintText,
    this.items = const [],
    this.label,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.value,
    this.isExpanded = true,
    this.isFullRounded = true,
  });

  @override
  Widget build(context) => DropdownButtonFormField(
    autofocus: autofocus,
    icon: const Icon(Icons.keyboard_arrow_down),
    decoration: InputDecoration(
      border: textFormFieldBorder(),
      focusedBorder: textFormFieldBorder(),
      contentPadding: dense
          ? const EdgeInsets.fromLTRB(12, 9, 12, 10)
          : const EdgeInsets.fromLTRB(20, 14, 20, 14),
      helperMaxLines: 3,
      helperText: helperText,
      hintText: hintText,
      isDense: true,
    ),
    items: items,
    onChanged: onChanged,
    onSaved: onSaved,
    validator: validator,
    value: value,
    isExpanded: isExpanded,
  );
}

class EmptyDataWidget extends StatelessWidget {
  final String message;
  const EmptyDataWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CenterAlignedColumn(children: [
        SvgPicture.asset(getSourceBySvg('ic_no_data')).bottomPadded(),
        TextWidget.jakartaSansBold(message, size: 14, color: ColorWidget.primaryColor),
      ]),
    );
  }
}

class GeneralEmptyDataWidget extends StatelessWidget {
  final String? text;
  const GeneralEmptyDataWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CenterAlignedColumn(children: [
        SvgPicture.asset(getSourceBySvg('ic_no_data')).bottomPadded(),
        TextWidget.jakartaSansBold(text ?? '', size: 14, color: ColorWidget.primaryColor),
      ]),
    );
  }
}

class HeroPhotoViewPage extends StatelessWidget {
  const HeroPhotoViewPage({
    required this.imageProvider,
    required this.tag,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.errorBuilder,
    super.key,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final String tag;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        errorBuilder: errorBuilder,
        backgroundDecoration: backgroundDecoration,
        minScale: 0.2,
        maxScale: maxScale,
        heroAttributes: PhotoViewHeroAttributes(tag: tag),
      ),
    );
  }
}

class SearchTextField extends StatefulWidget {
  final bool enabled;
  final bool autoFocus;
  final String hintText;
  final TextEditingController controller;
  final void Function()? tapAction;
  final void Function(String) onChange;
  final void Function(String?) onSearchValue;
  final TextInputAction textInputAction;
  const SearchTextField({
    super.key,
    this.enabled = true,
    required this.hintText,
    required this.controller,
    this.tapAction,
    required this.onChange,
    this.autoFocus = false,
    required this.onSearchValue,
    this.textInputAction = TextInputAction.none,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.tapAction,
      child: TextFormField(
        autofocus: widget.autoFocus,
        enabled: widget.enabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textCapitalization: TextCapitalization.words,
        onChanged: (value) => widget.onChange(value),
        textInputAction: widget.textInputAction,
        onSaved: (value) => widget.onSearchValue(value),
        onFieldSubmitted: (String value) => widget.onSearchValue(value),
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: SizedBox(
            child: SvgPicture.asset(
              getSourceBySvg("search_icon"),
              height: 16,
              width: 16,
              // ignore: deprecated_member_use
              color: ColorWidget.primaryColor,
            ).horizontalPadded(12).leftPadded(8),
          ),
          prefixIconConstraints:
          const BoxConstraints(minWidth: 24, minHeight: 24),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 0, 53, 119),
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
          focusColor: Colors.black54,
        ),
      ),
    );
  }
}

class GenericSpinnerForm extends StatelessWidget {
  final String labelText;
  final List<InfoItem> items;
  final String initialItems;
  final Function(String?) callback;
  const GenericSpinnerForm({
    super.key,
    required this.callback,
    required this.items,
    required this.initialItems,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return LeftAlignedColumn(
      children: [
        TextWidget.jakartaSansRegular(labelText, size: 14).bottomPadded(),
        Spinner<String>(
          items: infoItemsToDropdown(items),
          onChanged: (s) => callback(s),
          value: initialItems,
        ),
      ],
    );
  }
}

class BottomSheetOptionStatic extends StatefulWidget {
  final String labelText;
  final List<InfoItem> items;
  final String initialItems;
  final Function(InfoItem?) callback;
  const BottomSheetOptionStatic({
    super.key,
    required this.callback,
    required this.items,
    required this.initialItems,
    required this.labelText,
  });

  @override
  State<BottomSheetOptionStatic> createState() =>
      _BottomSheetOptionStaticState();
}

class _BottomSheetOptionStaticState extends State<BottomSheetOptionStatic> {
  @override
  Widget build(BuildContext context) {
    return BottomDrawer(
      child: LeftAlignedColumn(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                  child: TextWidget.jakartaSansBold(widget.labelText,
                      size: 16, color: ColorWidget.blackColor)),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  child: GestureDetector(
                    onTap: () => context.router.back(),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                    ).rightPadded(16),
                  ),
                ),
              ),
            ],
          ).bottomPadded(),
          LeftAlignedColumn(
            children: List.generate(
              widget.items.length,
                  (idx) => GestureDetector(
                onTap: () {
                  widget.callback(widget.items[idx]);
                  context.router.back();
                },
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: LeftAlignedColumn(
                    children: [
                      TextWidget.jakartaSansRegular(widget.items[idx].content ?? '',
                          size: 14,
                          color: ColorWidget.blackColor,
                          textAlign: TextAlign.center)
                          .bottomPadded(12)
                          .topPadded(12),
                      if ((idx + 1) != widget.items.length)
                        const Divider(thickness: 1.5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlobalButton extends ElevatedButton {
  GlobalButton(
      BuildContext ctx, {
        super.key,
        required VoidCallback onTap,
        required Widget super.child,
        double radius = 6.0,
        double padding = 16.0,
        Color? color,
      }) : super(
    onPressed: onTap,
    style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)),
      ),
      padding: WidgetStatePropertyAll(EdgeInsets.all(padding)),
      backgroundColor: WidgetStatePropertyAll(color),
    ),
  );
}

Future<void> showError(BuildContext context, String message) async {
  await showGenericSnackBar(context, message, Icons.cancel, ColorWidget.redColor);
}

Future<void> showSuccess(BuildContext context, String message) async {
  await showGenericSnackBar(
      context, message, Icons.check_circle, ColorWidget.greenColor);
}

Future<void> showWarning(BuildContext context, String message) async {
  await showGenericSnackBar(context, message, Icons.error, ColorWidget.warningColor);
}

Future<void> showGenericSnackBar(BuildContext context, String message,
    IconData iconData, Color backgroundColor) async {
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (BuildContext context) => Positioned(
      top: kToolbarHeight,
      left: 24,
      right: 24,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: LeftAlignedRow(
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ).rightPadded(8),
              Flexible(
                child: TextWidget.jakartaSansRegular(message,
                    size: 16, color: ColorWidget.whiteColor),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  Overlay.of(context).insert(overlayEntry);

  await Future.delayed(const Duration(seconds: 2));

  overlayEntry.remove();
}
