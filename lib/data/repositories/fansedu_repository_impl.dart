import 'package:dartz/dartz.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/data/datasource/fansedu_datasource.dart';
import 'package:fansedu/data/model/request/login_request.dart';
import 'package:fansedu/data/model/response/login_response.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';
import 'package:fansedu/domain/usecase/do_login.dart';

class FanseduRepositoryImpl implements FanseduRepository {
  final FanseduDatasource datasource;

  FanseduRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, LoginResponse>> doLogin(LoginParams params) async {
    final result = await datasource.doLogin(LoginRequest(email: params.email, password: params.password, fcmToken: params.fcmToken));
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
