part of '../bloc/profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final ProfileEntity? profileEntity;
  final CommonEntity? logoutEntity;

  const ProfileState({
    this.isLoading = false,
    this.errorMessage = "",
    this.profileEntity,
    this.logoutEntity
  });

  const ProfileState.noValue()
      : profileEntity = null,
        logoutEntity = null,
        isLoading = true,
        errorMessage = '';

  ProfileState copyWith({
    ProfileEntity? profileEntity,
    CommonEntity? logoutEntity,
    bool? isLoading,
    String? errorMessage
  }) {
    return ProfileState(
        profileEntity: profileEntity ?? this.profileEntity,
        logoutEntity: logoutEntity ?? this.logoutEntity,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    profileEntity,
    logoutEntity
  ];
}
