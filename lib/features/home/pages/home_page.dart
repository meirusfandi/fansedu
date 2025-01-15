import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TabsRouter _tabsRouter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AutoTabsScaffold(
        extendBody: true,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        bottomNavigationBuilder: (ctx, tabsRouter) {
          _tabsRouter = tabsRouter;
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorWidget.primaryColor,
            currentIndex: tabsRouter.activeIndex,
            items: _menu(),
            onTap: (idx) async {
              tabsRouter.setActiveIndex(idx);
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
          );
        },
        routes: _setupItems().map((e) => e.route).toList(),
      ),
    );
  }

  List<BottomNavigationBarItem> _menu() => _setupItems()
      .asMap()
      .map(
        (idx, element) => MapEntry(
      idx,
      BottomNavigationBarItem(
        icon: CenterAlignedColumn(
          children: [
            (_tabsRouter.activeIndex != idx) ? SvgPicture.asset(
              getSourceBySvg(element.icon),
              width: 20,
              height: 20,
              // ignore: deprecated_member_use
              color: ColorWidget.whiteColor,
            ) : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: SvgPicture.asset(
                getSourceBySvg(element.icon),
                width: 20,
                height: 20,
                // ignore: deprecated_member_use
                color: ColorWidget.secondaryColor,
              ).padded(4),
            ),
            const SizedBox(height: 4)
          ],
        ),
        label: '',
      ),
    ),
  ).values.toList();

  List<_Tab> _setupItems() {
    return [
      _Tab(
        icon: 'ic_home',
        title: "",
        route: DashboardRoute(),
      ),
      _Tab(
        icon: 'ic_chat',
        title: "",
        route: ChatRoomRoute(),
      ),
      _Tab(
        icon: 'ic_user',
        title: "",
        route: const ProfileRoute(),
      )
    ];
  }
}

class _Tab {
  final String icon;

  final String title;

  final PageRouteInfo route;

  const _Tab({
    required this.icon,
    required this.title,
    required this.route,
  });
}
