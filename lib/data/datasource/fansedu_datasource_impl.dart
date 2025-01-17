import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/resources/rest_client.dart';
import 'package:fansedu/data/datasource/fansedu_datasource.dart';
import 'package:fansedu/data/model/request/login_request.dart';
import 'package:fansedu/data/model/request/register_request.dart';
import 'package:fansedu/data/model/response/common_response.dart';
import 'package:fansedu/data/model/response/login_response.dart';

class FanseduDatasourceImpl implements FanseduDatasource {
  final RestClient restClient;

  FanseduDatasourceImpl(this.restClient);

  @override
  Future<Either<Failure, LoginResponse>> doLogin(LoginRequest request) async {
    try {
      final response = await restClient.doLogin(jsonEncode(request));
      final result = LoginResponse.fromJson(jsonDecode(jsonEncode(response)));
      return Future.value(Right(result));
    } on DioException catch (e) {
      return Left(LoginFailure(exception: e));
    } catch (e) {
      return Left(LoginFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> doRegister(RegisterRequest request) async {
    try {
      final response = await restClient.doRegister(jsonEncode(request));
      final result = CommonResponse.fromJson(jsonDecode(jsonEncode(response)));
      return Future.value(Right(result));
    } on DioException catch (e) {
      return Left(LoginFailure(exception: e));
    } catch (e) {
      return Left(LoginFailure(otherException: e.toString()));
    }
  }
}
