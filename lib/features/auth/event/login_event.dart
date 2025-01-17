part of '../bloc/login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class ProcessLoginEvent extends LoginEvent {
  final String email;
  final String password;

  const ProcessLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
