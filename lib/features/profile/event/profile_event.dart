part of '../bloc/profile_bloc.dart';

class ProfileEvent extends Equatable {

  const ProfileEvent();
  @override
  List<Object?> get props => [];

}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends ProfileEvent {
  const LogoutEvent();
  @override
  List<Object?> get props => [];
}
