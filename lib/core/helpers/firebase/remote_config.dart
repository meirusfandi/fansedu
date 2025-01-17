import 'package:fansedu/core/helpers/firebase/remote_config_key.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigHelper {
  FirebaseRemoteConfig instance = FirebaseRemoteConfig.instance;
  bool? get getInstagramMenu =>
      instance.getBool(RemoteConfigKey.instagram_menu.name);
  bool? get getBannerMenu => instance.getBool(RemoteConfigKey.banner_menu.name);
  bool? get getCategoryNewsMenu =>
      instance.getBool(RemoteConfigKey.category_news.name);
  bool? get getDownloadMenu =>
      instance.getBool(RemoteConfigKey.download_menu.name);
  bool? get getEventMenu => instance.getBool(RemoteConfigKey.event_menu.name);
  bool? get getFavoriteMenu =>
      instance.getBool(RemoteConfigKey.favorite_menu.name);
  bool? get getHeaderMenu => instance.getBool(RemoteConfigKey.header_menu.name);
  bool? get getHomeMenu => instance.getBool(RemoteConfigKey.home_menu.name);
  bool? get getLatestNews => instance.getBool(RemoteConfigKey.latest_news.name);
  bool? get getListNews =>
      instance.getBool(RemoteConfigKey.list_news_menu.name);
  bool? get getMapsMenu => instance.getBool(RemoteConfigKey.maps_menu.name);
  bool? get getProfileMenu =>
      instance.getBool(RemoteConfigKey.profile_menu.name);
  bool? get getForceUpdateEnable =>
      instance.getBool(RemoteConfigKey.force_update_enable.name);
  bool? get getShowPopUpUpdate =>
      instance.getBool(RemoteConfigKey.show_pop_up_update.name);
  String? get getLatestVersion =>
      instance.getString(RemoteConfigKey.latest_version.name);
  String? get getForceLogout =>
      instance.getString(RemoteConfigKey.force_logout.name);
  int? get getForceUpdateVersion =>
      instance.getInt(RemoteConfigKey.forceupdate_version.name);
  bool? get getRnDMenu => instance.getBool(RemoteConfigKey.rnd_menu.name);

  Future<void> initFirebase() async {
    try {
      await instance.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 5),
        minimumFetchInterval: const Duration(seconds: 120),
      ));
      instance.fetchAndActivate();
    } on FirebaseException catch (_) {}
  }

  Future<void> reloadRemoteConfig() async {
    try {
      await instance.fetchAndActivate();
    } on FirebaseException catch (_) {}
  }
}
