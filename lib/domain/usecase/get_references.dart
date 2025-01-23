import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/resources/usecase.dart';
import 'package:fansedu/domain/entity/references_entity.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';

class GetReferences extends UseCase<ReferencesEntity, ReferencesParams>{
  final FanseduRepository _repository;

  GetReferences(this._repository);

  @override
  Future<Either<Failure, ReferencesEntity>> call(ReferencesParams params) async {
    final result = await _repository.getReferences(params);
    return result.fold((l) => Left(l), (r) {
      return Right(
          ReferencesEntity(
              success: r.success ?? false,
              message: r.message ?? '',
              code: r.code ?? 0,
              data: r.data?.map((e) => DataReferencesEntity(
                reference_id: e.reference_id ?? '',
                category: e.category ?? '',
                title_id: e.title_id ?? '',
                title_en: e.title_en ?? '',
                content_id: e.content_id ?? '',
                content_en: e.content_en ?? '',
                created_at: e.created_at ?? '',
                updated_at: e.updated_at ?? '',
                deleted_at: e.deleted_at ?? '',
              )).toList() ?? []
          )
      );
    });
  }
}

class ReferencesParams extends Equatable {
  final String? category;
  const ReferencesParams(this.category);

  @override
  List<Object?> get props => [category];

}