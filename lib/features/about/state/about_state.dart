part of '../bloc/about_bloc.dart';

class AboutState extends Equatable {
  final String errorMessage;
  final bool isLoading;
  final ReferencesEntity? referencesEntity;

  const AboutState({
    this.referencesEntity,
    this.errorMessage = '',
    this.isLoading = false
  });

  const AboutState.noValue()
      : referencesEntity = null,
        isLoading = true,
        errorMessage = '';

  AboutState copyWith({
    ReferencesEntity? referencesEntity,
    bool? isLoading,
    String? errorMessage
  }) {
    return AboutState(
        referencesEntity: referencesEntity ?? this.referencesEntity,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    referencesEntity
  ];
}