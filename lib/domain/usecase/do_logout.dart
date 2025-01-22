import 'package:dartz/dartz.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/resources/usecase.dart';
import 'package:fansedu/domain/entity/common_entity.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';

class DoLogout implements UseCaseNoParam<CommonEntity> {
  final FanseduRepository repository;

  DoLogout(this.repository);

  @override
  Future<Either<Failure, CommonEntity>> call() async {
    final result = await repository.doLogout();
    return result.fold((l) => Left(l), (r) {
      return Right(
          CommonEntity(
              success: r.success ?? false,
              message: r.message ?? '',
              code: r.code ?? 0,
          )
      );
    });
  }
}
