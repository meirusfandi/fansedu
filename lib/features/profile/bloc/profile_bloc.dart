import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/domain/entity/common_entity.dart';
import 'package:fansedu/domain/entity/profile_entity.dart';
import 'package:fansedu/domain/usecase/do_logout.dart';
import 'package:fansedu/domain/usecase/get_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../state/profile_state.dart';
part '../event/profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final DoLogout doLogout;
  ProfileBloc({required this.getProfile, required this.doLogout}): super(ProfileState()) {
    on<GetProfileEvent>(_getProfile);
    on<LogoutEvent>(_doLogout);
  }

  Future<void> _getProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.noValue());
    try {
      final result = await getProfile();
      result.fold((l) {
        final rest = l as ProfileFailure;
        emit(state.copyWith(
            isLoading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success && (r.code == 200 || r.code == 201)) {
          emit(state.copyWith(isLoading: false, profileEntity: r));
        } else {
          emit(state.copyWith(isLoading: false, profileEntity: r, errorMessage: r.message));
        }
      });
    } on DioException catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.response?.data['message']));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _doLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.noValue());
    try {
      final result = await doLogout();
      result.fold((l) {
        final rest = l as ProfileFailure;
        emit(state.copyWith(
            isLoading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success && (r.code == 200 || r.code == 201)) {
          emit(state.copyWith(isLoading: false, logoutEntity: r));
        } else {
          emit(state.copyWith(isLoading: false, logoutEntity: r, errorMessage: r.message));
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
