import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/resources/usecase.dart';
import 'package:fansedu/domain/entity/common_entity.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';

class DoChangePassword extends UseCase<CommonEntity, ChangePasswordParams>{
  final FanseduRepository _repository;

  DoChangePassword(this._repository);

  @override
  Future<Either<Failure, CommonEntity>> call(ChangePasswordParams params) async {
    final result = await _repository.doChangePassword(params);
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

class ChangePasswordParams extends Equatable {
  final String? newPassword;
  final String? oldPassword;
  const ChangePasswordParams(this.oldPassword, this.newPassword);

  @override
  List<Object?> get props => [oldPassword, newPassword];

}