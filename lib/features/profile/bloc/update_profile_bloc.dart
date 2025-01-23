import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/domain/entity/common_entity.dart';
import 'package:fansedu/domain/usecase/do_change_password.dart';
import 'package:fansedu/domain/usecase/do_delete_account.dart';
import 'package:fansedu/domain/usecase/do_update_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../state/update_profile_state.dart';
part '../event/update_profile_event.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final DoUpdateProfile doUpdateProfile;
  final DoChangePassword doChangePassword;
  final DoDeleteAccount doDeleteAccount;

  UpdateProfileBloc({required this.doUpdateProfile, required this.doChangePassword, required this.doDeleteAccount}): super(UpdateProfileState()) {
    on<UpdatePasswordEvent>(_doChangePassword);
    on<RequestDeleteAccountEvent>(_doRequestDeleteAccount);
    on<UpdateDataProfileEvent>(_doUpdateProfile);
  }

  Future<void> _doChangePassword(UpdatePasswordEvent event, Emitter<UpdateProfileState> emit) async {
    emit(const UpdateProfileState.noValue());
    try {
      final result = await doChangePassword(ChangePasswordParams(event.oldPassword, event.newPassword));
      result.fold((l) {
        final rest = l as ProfileFailure;
        emit(state.copyWith(
            isLoading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success && (r.code == 200 || r.code == 201)) {
          emit(state.copyWith(isLoading: false, changePasswordEntity: r));
        } else {
          emit(state.copyWith(isLoading: false, changePasswordEntity: r, errorMessage: r.message));
        }
      });
    } on DioException catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.response?.data['message']));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _doRequestDeleteAccount(RequestDeleteAccountEvent event, Emitter<UpdateProfileState> emit) async {
    emit(const UpdateProfileState.noValue());
    try {
      final result = await doDeleteAccount(DeleteAccountParams(event.email, event.reason));
      result.fold((l) {
        final rest = l as ProfileFailure;
        emit(state.copyWith(
            isLoading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success && (r.code == 200 || r.code == 201)) {
          emit(state.copyWith(isLoading: false, deleteAccountEntity: r));
        } else {
          emit(state.copyWith(isLoading: false, deleteAccountEntity: r, errorMessage: r.message));
        }
      });
    } on DioException catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.response?.data['message']));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _doUpdateProfile(UpdateDataProfileEvent event, Emitter<UpdateProfileState> emit) async {
    emit(const UpdateProfileState.noValue());
    try {
      final result = await doUpdateProfile(UpdateProfileParams(event.fullName, event.profilePicture, event.phoneNumber, event.address, event.gender, event.dateOfBirth, event.grade, event.institutionName));
      result.fold((l) {
        final rest = l as ProfileFailure;
        emit(state.copyWith(
            isLoading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success && (r.code == 200 || r.code == 201)) {
          emit(state.copyWith(isLoading: false, updateProfileEntity: r));
        } else {
          emit(state.copyWith(isLoading: false, updateProfileEntity: r, errorMessage: r.message));
        }
      });
    } on DioException catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.response?.data['message']));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
