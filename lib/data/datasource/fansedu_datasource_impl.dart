import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:fansedu/core/resources/rest_client.dart';
import 'package:fansedu/data/datasource/fansedu_datasource.dart';
import 'package:fansedu/data/model/request/change_password_request.dart';
import 'package:fansedu/data/model/request/delete_account_request.dart';
import 'package:fansedu/data/model/request/login_request.dart';
import 'package:fansedu/data/model/request/references_request.dart';
import 'package:fansedu/data/model/request/register_request.dart';
import 'package:fansedu/data/model/request/reset_password_request.dart';
import 'package:fansedu/data/model/request/update_profile_request.dart';
import 'package:fansedu/data/model/response/common_response.dart';
import 'package:fansedu/data/model/response/login_response.dart';
import 'package:fansedu/data/model/response/profile_response.dart';
import 'package:fansedu/data/model/response/references_response.dart';

class FanseduDatasourceImpl implements FanseduDatasource {
  final RestClient restClient;

  FanseduDatasourceImpl(this.restClient);

  @override
  Future<Either<Failure, LoginResponse>> doLogin(LoginRequest request) async {
    try {
      final response = await restClient.doLogin(request);
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
      final response = await restClient.doRegister(request);
      final result = CommonResponse.fromJson(jsonDecode(jsonEncode(response)));
      return Future.value(Right(result));
    } on DioException catch (e) {
      return Left(RegisterFailure(exception: e));
    } catch (e) {
      return Left(RegisterFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> doForgotPassword(ResetPasswordRequest request) async {
    try {
      final response = await restClient.doResetPassword(request);
      final result = CommonResponse.fromJson(jsonDecode(jsonEncode(response)));
      return Future.value(Right(result));
    } on DioException catch (e) {
      return Left(ResetPasswordFailure(exception: e));
    } catch (e) {
      return Left(ResetPasswordFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileResponse>> doGetProfile() async {
    try {
      final token = await storage.getAuthToken ?? '';
      final response = await restClient.doGetProfile(token);
      final result = ProfileResponse.fromJson(jsonDecode(jsonEncode(response)));
      return Future.value(Right(result));
    } on DioException catch (e) {
      return Left(ProfileFailure(exception: e));
    } catch (e) {
      return Left(ProfileFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> doLogout() async {
    try {
      final token = await storage.getAuthToken ?? '';
      final response = await restClient.doLogout(token);
      final result = CommonResponse.fromJson(jsonDecode(jsonEncode(response)));
      return Future.value(Right(result));
    } on DioException catch (e) {
      return Left(LoginFailure(exception: e));
    } catch (e) {
      return Left(LoginFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReferencesResponse>> doGetReferences(ReferencesRequest request) async {
    try {
      final token = await storage.getAuthToken ?? '';
      final response = await restClient.doGetReferences(token, request);
      final result = ReferencesResponse.fromJson(jsonDecode(jsonEncode(response)));
      return Future.value(Right(result));
    } on DioException catch (e) {
      return Left(AboutFailure(exception: e));
    } catch (e) {
      return Left(AboutFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> doChangePassword(ChangePasswordRequest request) async {
    try {
      final token = await storage.getAuthToken ?? '';
      final response = await restClient.doChangePassword(token, request);
      final result = CommonResponse.fromJson(jsonDecode(jsonEncode(response)));
      return Future.value(Right(result));
    } on DioException catch (e) {
      return Left(ProfileFailure(exception: e));
    } catch (e) {
      return Left(ProfileFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> doRequestDeleteAccount(DeleteAccountRequest request) async {
    try {
      final token = await storage.getAuthToken ?? '';
      final response = await restClient.doRequestDeleteAccount(token, request);
      final result = CommonResponse.fromJson(jsonDecode(jsonEncode(response)));
      return Future.value(Right(result));
    } on DioException catch (e) {
      return Left(ProfileFailure(exception: e));
    } catch (e) {
      return Left(ProfileFailure(otherException: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> doUpdateProfile(UpdateProfileRequest request) async {
    try {
      final token = await storage.getAuthToken ?? '';
      final file = File(request.profile_picture ?? '');
      final response = await restClient.doUpdateProfile(
        token, request.full_name ?? '', file, request.phone_number ?? '',
        request.address ?? '', request.gender ?? '', request.date_of_birth ?? '',
        request.grade ?? '', request.institution_name ?? ''
      );
      final result = CommonResponse.fromJson(jsonDecode(jsonEncode(response)));
      return Future.value(Right(result));
    } on DioException catch (e) {
      return Left(ProfileFailure(exception: e));
    } catch (e) {
      return Left(ProfileFailure(otherException: e.toString()));
    }
  }
}
