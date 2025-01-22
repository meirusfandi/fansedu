part of '../bloc/auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class ProcessLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const ProcessLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class ProcessResetEvent extends AuthEvent {
  final String email;
  final String password;

  const ProcessResetEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class ProcessRegisterEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  const ProcessRegisterEvent({required this.email, required this.password, required this.fullName});

  @override
  List<Object?> get props => [email, password, fullName];
}
