import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/resources/usecase.dart';
import 'package:fansedu/data/model/response/common_response.dart';
import 'package:fansedu/domain/entity/common_entity.dart';
import 'package:fansedu/domain/entity/login_entity.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';

class DoRegister implements UseCase<CommonEntity, RegisterParams> {
  final FanseduRepository repository;

  DoRegister(this.repository);

  @override
  Future<Either<Failure, CommonEntity>> call(RegisterParams params) async {
    final result = await repository.doRegister(params);
    return result.fold((l) => Left(l), (r) {
      return Right(
          CommonEntity(success: r.success ?? false, message: r.message ?? '', code: r.code ?? 0)
      );
    });
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String fullName;

  const RegisterParams({required this.email, required this.password, required this.fullName});

  @override
  List<Object?> get props => [email, password, fullName];
}