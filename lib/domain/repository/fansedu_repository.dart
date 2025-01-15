import 'package:dartz/dartz.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/data/model/response/login_response.dart';
import 'package:fansedu/domain/usecase/do_login.dart';

abstract class FanseduRepository {
  Future<Either<Failure, LoginResponse>> doLogin(LoginParams params);
}