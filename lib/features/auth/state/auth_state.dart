part of '../bloc/auth_bloc.dart';

class AuthState extends Equatable {
  final LoginEntity? loginEntity;
  final String errorMessage;
  final bool isLoading;
  final CommonEntity? registerEntity;
  final CommonEntity? resetPasswordEntity;

  const AuthState({
    this.loginEntity,
    this.registerEntity,
    this.resetPasswordEntity,
    this.errorMessage = '',
    this.isLoading = false
  });

  const AuthState.noValue()
      : loginEntity = null,
        registerEntity = null,
        resetPasswordEntity = null,
        isLoading = true,
        errorMessage = '';

  AuthState copyWith({
    LoginEntity? loginEntity,
    CommonEntity? registerEntity,
    CommonEntity? resetPasswordEntity,
    bool? isLoading,
    String? errorMessage
  }) {
    return AuthState(
        loginEntity: loginEntity ?? this.loginEntity,
        resetPasswordEntity: resetPasswordEntity ?? this.resetPasswordEntity,
        registerEntity: registerEntity ?? this.registerEntity,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
    isLoading,
    loginEntity,
    registerEntity,
    resetPasswordEntity,
    errorMessage
  ];
}