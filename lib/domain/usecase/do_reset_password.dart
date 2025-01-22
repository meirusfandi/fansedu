import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/resources/usecase.dart';
import 'package:fansedu/domain/entity/common_entity.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';

class DoResetPassword implements UseCase<CommonEntity, ResetPasswordParams> {
  final FanseduRepository repository;

  DoResetPassword(this.repository);

  @override
  Future<Either<Failure, CommonEntity>> call(ResetPasswordParams params) async {
    final result = await repository.doResetPassword(params);
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

class ResetPasswordParams extends Equatable {
  final String email;
  final String password;

  const ResetPasswordParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}