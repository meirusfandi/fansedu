import 'package:dartz/dartz.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/data/model/request/login_request.dart';
import 'package:fansedu/data/model/request/register_request.dart';
import 'package:fansedu/data/model/request/reset_password_request.dart';
import 'package:fansedu/data/model/response/common_response.dart';
import 'package:fansedu/data/model/response/login_response.dart';
import 'package:fansedu/data/model/response/profile_response.dart';

abstract class FanseduDatasource {
  Future<Either<Failure, LoginResponse>> doLogin(LoginRequest request);
  Future<Either<Failure, CommonResponse>> doRegister(RegisterRequest request);
  Future<Either<Failure, ProfileResponse>> doGetProfile();
  Future<Either<Failure, CommonResponse>> doLogout();
  Future<Either<Failure, CommonResponse>> doForgotPassword(ResetPasswordRequest request);
}