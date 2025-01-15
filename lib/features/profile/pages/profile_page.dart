import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:fansedu/features/profile/widgets/user_menu_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: BackAppBar(
        context, "My Profile",
        elevation: 0.0,
        backgroundColor: Colors.white
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: LeftAlignedColumn(
            children: [
              // section profile
              LeftAlignedRow(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorWidget.primaryColor)
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        getSourceByPng('img_articles_1'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ).rightPadded(8),
                  Expanded(
                    child: LeftAlignedColumn(
                      children: [
                        TextWidget.jakartaSansBold("Mei Rusfandi", size: 20, color: ColorWidget.primaryColor),
                        TextWidget.jakartaSansRegular("me.rusfandi@gmail.com", size: 14, color: ColorWidget.secondaryColor),
                      ]
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Icon(Icons.edit, color: ColorWidget.primaryColor, size: 24,),
                  ).leftPadded(8)
                ]
              ).horizontalPadded(24),

              Divider().horizontalPadded(24).verticalPadded(),

              // general information section
              TextWidget.jakartaSansSemiBold("General Information", size: 20, color: ColorWidget.primaryColor).horizontalPadded().bottomPadded(),
              ShadowedContainer(
                children: [
                  UserMenuWidget(
                      iconLeading: "ic_help",
                      title: "Help Center",
                      onTap: () {

                      }
                  ).verticalPadded(),
                  Divider(),
                  UserMenuWidget(
                      iconLeading: "ic_help",
                      title: "About Apps",
                      onTap: () {

                      }
                  ).verticalPadded(),
                ]
              ).horizontalPadded(24),

              // preference section
              TextWidget.jakartaSansSemiBold("Preference", size: 20, color: ColorWidget.primaryColor).padded(),
              ShadowedContainer(children: [
                UserMenuWidget(
                    iconLeading: "ic_help",
                    title: "Language",
                    onTap: () {

                    }
                ).verticalPadded(),
                Divider(),
                UserMenuWidget(
                    iconLeading: "ic_help",
                    title: "Security Account",
                    onTap: () {

                    }
                ).verticalPadded(),
                Divider(),
                UserMenuWidget(
                    iconLeading: "ic_help",
                    title: "Delete Account",
                    onTap: () {

                    }
                ).verticalPadded(),
                Divider(),
                UserMenuWidget(
                    iconLeading: "ic_logout",
                    title: "Logout",
                    onTap: () {

                    }
                ).verticalPadded(),
              ]).horizontalPadded(24),

              // section privacy policy & tnc
              Center(
                child: LeftAlignedRow(
                  children: [
                    GestureDetector(
                      onTap: () {

                      },
                      child: TextWidget.jakartaSansSemiBold("Privacy Policy", size: 12, color: ColorWidget.iconColor),
                    ),
                    Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        color: ColorWidget.iconColor,
                        shape: BoxShape.circle,
                      ),
                    ).padded(8),
                    GestureDetector(
                      onTap: () {

                      },
                      child: TextWidget.jakartaSansSemiBold("Terms and Conditions", size: 12, color: ColorWidget.iconColor),
                    ),
                  ],
                ).topPadded(32).bottomPadded(24).horizontalPadded(24),
              )
            ]
          ),
        )
      ),
    );
  }
}
