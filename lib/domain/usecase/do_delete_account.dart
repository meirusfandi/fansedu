import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/resources/usecase.dart';
import 'package:fansedu/domain/entity/common_entity.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';

class DoDeleteAccount extends UseCase<CommonEntity, DeleteAccountParams>{
  final FanseduRepository _repository;

  DoDeleteAccount(this._repository);

  @override
  Future<Either<Failure, CommonEntity>> call(DeleteAccountParams params) async {
    final result = await _repository.doRequestDeleteAccount(params);
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

class DeleteAccountParams extends Equatable {
  final String? email;
  final String? reason;
  const DeleteAccountParams(this.email, this.reason);

  @override
  List<Object?> get props => [email, reason];
}