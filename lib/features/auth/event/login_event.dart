part of '../bloc/login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class ProcessLoginEvent extends LoginEvent {
  final String email;
  final String password;
  final String fcmToken;

  const ProcessLoginEvent({required this.email, required this.password, required this.fcmToken});

  @override
  List<Object?> get props => [email, password, fcmToken];
}
