import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/helpers/firebase/firebase_messsaging_helper.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:fansedu/domain/entity/common_entity.dart';
import 'package:fansedu/domain/entity/login_entity.dart';
import 'package:fansedu/domain/usecase/do_login.dart';
import 'package:fansedu/domain/usecase/do_register.dart';
import 'package:fansedu/domain/usecase/do_reset_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../state/auth_state.dart';
part '../event/auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DoLogin doLogin;
  final DoResetPassword doResetPassword;
  final DoRegister doRegister;
  AuthBloc({required this.doLogin, required this.doResetPassword, required this.doRegister}) : super(const AuthState()) {
    on<ProcessLoginEvent>(_doLogin);
    on<ProcessRegisterEvent>(_doRegister);
    on<ProcessResetEvent>(_doResetPassword);
  }

  Future<void> _doLogin(ProcessLoginEvent event, Emitter<AuthState> emit) async {
    try {
      final fcmToken = await FirebaseMessagingHelpers().getFcmToken();
      emit(const AuthState.noValue());
      final result = await doLogin(LoginParams(
          email: event.email, password: event.password, fcmToken: fcmToken));
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

  Future<void> _doRegister(ProcessRegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const AuthState.noValue());
      final result = await doRegister(RegisterParams(
          email: event.email, password: event.password, fullName: event.fullName));
      result.fold((l) {
        final rest = l as RegisterFailure;
        emit(state.copyWith(
            isLoading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success && (r.code == 200 || r.code == 201)) {
          emit(state.copyWith(isLoading: false, registerEntity: r));
        } else {
          emit(state.copyWith(isLoading: false, registerEntity: r, errorMessage: r.message));
        }
      });
    } on DioException catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.response?.data['message']));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _doResetPassword(ProcessResetEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const AuthState.noValue());
      final result = await doResetPassword(ResetPasswordParams(
          email: event.email, password: event.password));
      result.fold((l) {
        final rest = l as ResetPasswordFailure;
        emit(state.copyWith(
            isLoading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success && (r.code == 200 || r.code == 201)) {
          emit(state.copyWith(isLoading: false, resetPasswordEntity: r));
        } else {
          emit(state.copyWith(isLoading: false, resetPasswordEntity: r, errorMessage: r.message));
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