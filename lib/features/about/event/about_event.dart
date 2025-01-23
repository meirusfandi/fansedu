part of '../bloc/about_bloc.dart';

class AboutEvent extends Equatable {
  const AboutEvent();

  @override
  List<Object?> get props => [];
}

class GetReferenceEvent extends AboutEvent {
  final String? category;

  const GetReferenceEvent(this.category);

  @override
  List<Object?> get props => [category];
}