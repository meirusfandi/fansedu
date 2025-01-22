import 'package:fansedu/core/helpers/firebase/remote_config_key.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigHelper {
  FirebaseRemoteConfig instance = FirebaseRemoteConfig.instance;
  bool? get getProgressMenuIsActive =>
      instance.getBool(RemoteConfigKey.progress_menu_is_active.name);
  bool? get getActiveClassMenuIsActive =>
      instance.getBool(RemoteConfigKey.active_class_menu_is_active.name);
  bool? get getCategoryMenuIsActive =>
      instance.getBool(RemoteConfigKey.category_menu_is_active.name);
  bool? get getArticleMenuIsActive =>
      instance.getBool(RemoteConfigKey.articles_menu_is_active.name);
  bool? get getForceUpdateEnable =>
      instance.getBool(RemoteConfigKey.force_update_enable.name);
  bool? get getShowPopUpUpdate =>
      instance.getBool(RemoteConfigKey.show_pop_up_update.name);
  String? get getLatestVersion =>
      instance.getString(RemoteConfigKey.latest_version.name);
  String? get getForceLogout =>
      instance.getString(RemoteConfigKey.force_logout.name);
  int? get getForceUpdateVersion =>
      instance.getInt(RemoteConfigKey.force_update_version.name);
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
