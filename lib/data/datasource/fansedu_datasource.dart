import 'package:dartz/dartz.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/data/model/request/login_request.dart';
import 'package:fansedu/data/model/response/login_response.dart';

abstract class FanseduDatasource {
  Future<Either<Failure, LoginResponse>> doLogin(LoginRequest request);
}