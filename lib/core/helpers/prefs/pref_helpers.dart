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
}

final prefHelpers = PrefHelpers();
