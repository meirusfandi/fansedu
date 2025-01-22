import 'package:fansedu/core/helpers/prefs/prefs_key_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefInstance;

class PrefHelpers {
  String? get getSavedAppVersion =>
      prefInstance.getString(PrefsKey.savedAppVersion.name);
  String? get getDateUpdateAppears =>
      prefInstance.getString(PrefsKey.dateUpdateAppears.name);
  String? get getAppLang => prefInstance.getString(PrefsKey.appLang.name);
  bool? get getFirstAccess => prefInstance.getBool(PrefsKey.isFirstAccess.name);
  String? get getPermissionNotification => prefInstance.getString(PrefsKey.isNotificationAllow.name);
  String? get getPermissionGallery => prefInstance.getString(PrefsKey.isGalleryAllow.name);
  String? get getPermissionCamera => prefInstance.getString(PrefsKey.isCameraAllow.name);
  String? get getPermissionStorage => prefInstance.getString(PrefsKey.isStorageAllow.name);
}

final prefHelpers = PrefHelpers();
