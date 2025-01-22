import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/domain/entity/profile_entity.dart';
import 'package:fansedu/domain/usecase/get_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../state/profile_state.dart';
part '../event/profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  ProfileBloc({required this.getProfile}): super(ProfileState()) {
    on<GetProfileEvent>(_getProfile);
  }

  Future<void> _getProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(const ProfileState.noValue());
      final result = await getProfile();
      result.fold((l) {
        final rest = l as ProfileFailure;
        emit(state.copyWith(
            isLoading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success) {
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
}
