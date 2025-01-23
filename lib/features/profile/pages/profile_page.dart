import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/config/presentation/language_dialog.dart';
import 'package:fansedu/core/helpers/prefs/pref_helpers.dart';
import 'package:fansedu/core/helpers/prefs/prefs_key_helpers.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:fansedu/core/resources/injection_container.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:fansedu/domain/entity/profile_entity.dart';
import 'package:fansedu/features/profile/bloc/profile_bloc.dart';
import 'package:fansedu/features/profile/widgets/user_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DataProfileEntity? dataProfile;

  @override
  void initState() {
    sl<ProfileBloc>().add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String lang = prefInstance.getString(PrefsKey.appLang.name) ?? 'id';
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (!state.isLoading && state.profileEntity != null) {
          if (state.profileEntity?.success ?? false) {
            dataProfile = state.profileEntity?.data;
          } else {
            showSuccess(context, state.profileEntity?.message ?? '');
          }
        }
        if (!state.isLoading && state.logoutEntity != null) {
          if (state.logoutEntity?.success ?? false) {
            showSuccess(context, state.logoutEntity?.message ?? '');
            storage.clear();
            prefInstance.clear();
            context.router.replaceAll([OnboardingRoute()]);
          } else {
            showSuccess(context, state.logoutEntity?.message ?? '');
          }
        }
      },
      builder: (context, state) {
        return Loadable(
          loading: state.isLoading,
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
                            TextWidget.jakartaSansBold(state.profileEntity?.data.full_name ?? '', size: 20, color: ColorWidget.primaryColor),
                            TextWidget.jakartaSansRegular(state.profileEntity?.data.email ?? '', size: 14, color: ColorWidget.secondaryColor),
                          ]
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pushRoute(EditProfileRoute(profileEntity: dataProfile ?? DataProfileEntity(
                            user_id: "",
                            profile_id: "",
                            email: "",
                            full_name: "",
                            phone_number: "",
                            address: "",
                            profile_picture: "",
                            gender: "",
                            date_of_birth: "",
                            grade: "",
                            institution_name: "",
                            role: DataRoleEntity(role_id: '', role_name: '', role_description: '')
                        ))),
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
                          onTap: () => context.pushRoute(HelpCenterRoute())
                      ).verticalPadded(),
                      Divider(),
                      UserMenuWidget(
                          iconLeading: "ic_about",
                          title: "About Apps",
                          onTap: () => context.pushRoute(AboutRoute())
                      ).verticalPadded(),
                    ]
                  ).horizontalPadded(24),

                  // preference section
                  TextWidget.jakartaSansSemiBold("Preference", size: 20, color: ColorWidget.primaryColor).padded(),
                  ShadowedContainer(children: [
                    UserMenuWidget(
                        iconLeading: "ic_translation",
                        title: "Language",
                        onTap: () {
                          showSheet(
                            context,
                            LanguageDialog(
                                lang: lang,
                                callback: (item) async {
                                  setState(() {
                                    lang = item?.code ?? 'id';
                                  });
                                }),
                          );
                        }
                    ).verticalPadded(),
                    Divider(),
                    UserMenuWidget(
                        iconLeading: "ic_security",
                        title: "Security Account",
                        onTap: () => context.pushRoute(SecurityRoute())
                    ).verticalPadded(),
                    Divider(),
                    UserMenuWidget(
                        iconLeading: "ic_logout",
                        title: "Logout",
                        onTap: () {
                          sl<ProfileBloc>().add(LogoutEvent());
                        }
                    ).verticalPadded(),
                  ]).horizontalPadded(24),

                  // section privacy policy & tnc
                  Center(
                    child: LeftAlignedRow(
                      children: [
                        GestureDetector(
                          onTap: () => context.pushRoute(PrivacyPolicyRoute()),
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
                          onTap: () => context.pushRoute(TncRoute()),
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
    );
  }
}
