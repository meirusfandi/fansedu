import 'package:equatable/equatable.dart';
import 'package:fansedu/core/config/helpers/lang_config.dart';
import 'package:fansedu/core/helpers/prefs/pref_helpers.dart';
import 'package:fansedu/core/helpers/prefs/prefs_key_helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(ConfigState(local: prefHelpers.getAppLang ?? '')) {
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onChangeLanguage(
      ChangeLanguageEvent event, Emitter<ConfigState> emit) async {
    emit(state.copyWith(isLoading: true, onUpdateLang: false));
    await prefInstance.setString(PrefsKey.appLang.name, event.newLocal);
    LangConfig(
        langValue: prefInstance.getString(PrefsKey.appLang.name) ?? 'id');
    emit(state.copyWith(
        local: event.newLocal, onUpdateLang: true, isLoading: false));
  }
}
