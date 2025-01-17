import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/resources/usecase.dart';
import 'package:fansedu/domain/entity/login_entity.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';

class DoLogin implements UseCase<LoginEntity, LoginParams> {
  final FanseduRepository repository;

  DoLogin(this.repository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    final result = await repository.doLogin(params);
    return result.fold((l) => Left(l), (r) {
      return Right(
        LoginEntity(
          success: r.success ?? false,
          message: r.message ?? '',
          code: r.code ?? 0,
          data: DataLoginEntity(
            token: r.data?.token ?? '',
            expired_at: r.data?.expired_at ?? '',
            user_id: r.data?.user_id ?? '',
            email: r.data?.email ?? '',
            full_name: r.data?.full_name ?? ''
          )
        )
      );
    });
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;
  final String fcmToken;

  const LoginParams({required this.email, required this.password, required this.fcmToken});

  @override
  List<Object?> get props => [email, password, fcmToken];
}