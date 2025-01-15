import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/domain/entity/login_entity.dart';
import 'package:fansedu/domain/usecase/do_login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../state/login_state.dart';
part '../event/login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DoLogin doLogin;
  LoginBloc({required this.doLogin}) : super(const LoginState()) {
    on<ProcessLoginEvent>(_doLogin);
  }

  Future<void> _doLogin(ProcessLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(const LoginState.noValue());
      // String fcmToken = await sl<FirebaseMessagingHelpers>().getFcmToken();
      final result = await doLogin(LoginParams(
          email: event.email, password: event.password, fcmToken: event.fcmToken));
      result.fold((l) {
        final rest = l as LoginFailure;
        emit(state.copyWith(
            isloading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success) {
          // storage.write(StorageKey.forceLogout,
          //     sl<RemoteConfigHelper>().getForceLogout ?? '');
          // storage.write(StorageKey.authToken, 'Bearer ${r.access_token}');
          // storage.write(StorageKey.email, r.data.email);
          // storage.write(StorageKey.fullName, r.data.name);
          // storage.write(StorageKey.expiredToken, r.expires_in.toString());
          // storage.write(StorageKey.userid, r.data.id.toString());
          // storage.write(StorageKey.username, r.data.username);
          emit(state.copyWith(isloading: false, loginEntity: r));
        }
      });
    } on DioException catch (e) {
      emit(state.copyWith(
          isloading: false, errorMessage: e.response?.data['message']));
    } catch (e) {
      emit(state.copyWith(isloading: false, errorMessage: e.toString()));
    }
  }
}