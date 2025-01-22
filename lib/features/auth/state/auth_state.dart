part of '../bloc/auth_bloc.dart';

class AuthState extends Equatable {
  final LoginEntity? loginEntity;
  final String errorMessage;
  final bool isLoading;

  const AuthState(
      {this.loginEntity, this.errorMessage = '', this.isLoading = false});

  const AuthState.noValue()
      : loginEntity = null,
        isLoading = true,
        errorMessage = '';

  AuthState copyWith(
      {LoginEntity? loginEntity, bool? isLoading, String? errorMessage}) {
    return AuthState(
        loginEntity: loginEntity ?? this.loginEntity,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [isLoading, loginEntity, errorMessage];
}