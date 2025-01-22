import 'package:dio/dio.dart';
import 'package:fansedu/core/config/model/error_response.dart';

abstract class Failure {}

class NetworkFailure extends Failure {}

class MappingDataFailure extends Failure {}

class LoginFailure extends Failure {
  final DioException? exception;
  final String? otherException;
  final ErrorResponse? errorResponse;

  LoginFailure({this.exception, this.otherException, this.errorResponse});
}

class RegisterFailure extends Failure {
  final DioException? exception;
  final String? otherException;
  final ErrorResponse? errorResponse;

  RegisterFailure({this.exception, this.otherException, this.errorResponse});
}

class ProfileFailure extends Failure {
  final DioException? exception;
  final String? otherException;
  final ErrorResponse? errorResponse;

  ProfileFailure({this.exception, this.otherException, this.errorResponse});
}
