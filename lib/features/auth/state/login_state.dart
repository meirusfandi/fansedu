part of '../bloc/login_bloc.dart';

class LoginState extends Equatable {
  final LoginEntity? loginEntity;
  final String errorMessage;
  final bool isLoading;

  const LoginState(
      {this.loginEntity, this.errorMessage = '', this.isLoading = false});

  const LoginState.noValue()
      : loginEntity = null,
        isLoading = true,
        errorMessage = '';

  LoginState copyWith(
      {LoginEntity? loginEntity, bool? isLoading, String? errorMessage}) {
    return LoginState(
        loginEntity: loginEntity ?? this.loginEntity,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [isLoading, loginEntity, errorMessage];
}