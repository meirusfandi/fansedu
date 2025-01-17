import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_key_helper.dart';
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
      final result = await doLogin(LoginParams(
          email: event.email, password: event.password, fcmToken: "firebase_token"));
      result.fold((l) {
        final rest = l as LoginFailure;
        emit(state.copyWith(
            isLoading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success) {
          storage.write(StorageKey.authToken, 'Bearer ${r.data.token}');
          storage.write(StorageKey.email, r.data.email);
          storage.write(StorageKey.fullName, r.data.full_name);
          storage.write(StorageKey.expiredToken, r.data.expired_at.toString());
          storage.write(StorageKey.userid, r.data.user_id.toString());
          emit(state.copyWith(isLoading: false, loginEntity: r));
        } else {
          emit(state.copyWith(isLoading: false, loginEntity: r, errorMessage: r.message));
        }
      });
    } on DioException catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.response?.data['message']));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}