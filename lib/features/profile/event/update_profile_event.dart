part of '../bloc/update_profile_bloc.dart';

class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePasswordEvent extends UpdateProfileEvent {
  final String newPassword;
  final String oldPassword;

  const UpdatePasswordEvent({required this.newPassword, required this.oldPassword});

  @override
  List<Object?> get props => [newPassword, oldPassword];
}

class RequestDeleteAccountEvent extends UpdateProfileEvent {
  final String email;
  final String reason;

  const RequestDeleteAccountEvent({required this.email, required this.reason});

  @override
  List<Object?> get props => [email, reason];
}

class UpdateDataProfileEvent extends UpdateProfileEvent {
  final String? fullName;
  final String? profilePicture;
  final String? phoneNumber;
  final String? address;
  final String? gender;
  final String? dateOfBirth;
  final String? grade;
  final String? institutionName;

  const UpdateDataProfileEvent(this.fullName, this.profilePicture, this.phoneNumber, this.address, this.gender, this.dateOfBirth, this.grade, this.institutionName);

  @override
  List<Object?> get props => [fullName, profilePicture, phoneNumber, address, gender, dateOfBirth, grade, institutionName];
}
