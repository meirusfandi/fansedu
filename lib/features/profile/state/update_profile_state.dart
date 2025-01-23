part of '../bloc/update_profile_bloc.dart';

class UpdateProfileState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final CommonEntity? updateProfileEntity;
  final CommonEntity? changePasswordEntity;
  final CommonEntity? deleteAccountEntity;

  const UpdateProfileState({
    this.isLoading = false,
    this.errorMessage = "",
    this.updateProfileEntity,
    this.changePasswordEntity,
    this.deleteAccountEntity
  });

  const UpdateProfileState.noValue()
      : changePasswordEntity = null,
        updateProfileEntity = null,
        deleteAccountEntity = null,
        isLoading = true,
        errorMessage = '';

  UpdateProfileState copyWith({
    CommonEntity? changePasswordEntity,
    CommonEntity? updateProfileEntity,
    CommonEntity? deleteAccountEntity,
    bool? isLoading,
    String? errorMessage
  }) {
    return UpdateProfileState(
        changePasswordEntity: changePasswordEntity ?? this.changePasswordEntity,
        updateProfileEntity: updateProfileEntity ?? this.updateProfileEntity,
        deleteAccountEntity: deleteAccountEntity ?? this.deleteAccountEntity,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    changePasswordEntity,
    updateProfileEntity,
    deleteAccountEntity
  ];
}
