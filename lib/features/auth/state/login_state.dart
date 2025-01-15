part of '../bloc/login_bloc.dart';

class LoginState extends Equatable {
  final LoginEntity? loginEntity;
  final String errorMessage;
  final bool isloading;

  const LoginState(
      {this.loginEntity, this.errorMessage = '', this.isloading = false});

  const LoginState.noValue()
      : loginEntity = null,
        isloading = true,
        errorMessage = '';

  LoginState copyWith(
      {LoginEntity? loginEntity, bool? isloading, String? errorMessage}) {
    return LoginState(
        loginEntity: loginEntity ?? this.loginEntity,
        isloading: isloading ?? this.isloading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [isloading, loginEntity, errorMessage];
}