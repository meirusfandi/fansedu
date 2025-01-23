import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/domain/entity/references_entity.dart';
import 'package:fansedu/domain/usecase/get_references.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../event/about_event.dart';
part '../state/about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  final GetReferences getReferences;

  AboutBloc({required this.getReferences}): super (const AboutState()) {
   on<GetReferenceEvent>(_getReferences);
  }

  Future<void> _getReferences(GetReferenceEvent event, Emitter<AboutState> emit) async {
    try {
      emit(const AboutState.noValue());
      final result = await getReferences(ReferencesParams(event.category));
      result.fold((l) {
        final rest = l as AboutFailure;
        emit(state.copyWith(
            isLoading: false,
            errorMessage: rest.exception?.response?.data["message"] ??
                rest.otherException ??
                ''));
      }, (r) {
        if (r.success && (r.code == 200 || r.code == 201)) {
          emit(state.copyWith(isLoading: false, referencesEntity: r));
        } else {
          emit(state.copyWith(isLoading: false, referencesEntity: r, errorMessage: r.message));
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