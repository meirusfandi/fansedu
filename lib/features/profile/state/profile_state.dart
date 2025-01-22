part of '../bloc/profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final ProfileEntity? profileEntity;

  const ProfileState({
    this.isLoading = false,
    this.errorMessage = "",
    this.profileEntity
  });

  const ProfileState.noValue()
      : profileEntity = null,
        isLoading = true,
        errorMessage = '';

  ProfileState copyWith(
      {ProfileEntity? profileEntity, bool? isLoading, String? errorMessage}) {
    return ProfileState(
        profileEntity: profileEntity ?? this.profileEntity,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [];
}
