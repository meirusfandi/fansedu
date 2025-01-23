import 'package:dartz/dartz.dart';
import 'package:fansedu/core/failure/failure.dart';
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
import 'package:fansedu/domain/repository/fansedu_repository.dart';
import 'package:fansedu/domain/usecase/do_change_password.dart';
import 'package:fansedu/domain/usecase/do_delete_account.dart';
import 'package:fansedu/domain/usecase/do_login.dart';
import 'package:fansedu/domain/usecase/do_register.dart';
import 'package:fansedu/domain/usecase/do_reset_password.dart';
import 'package:fansedu/domain/usecase/do_update_profile.dart';
import 'package:fansedu/domain/usecase/get_references.dart';

class FanseduRepositoryImpl implements FanseduRepository {
  final FanseduDatasource datasource;

  FanseduRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, LoginResponse>> doLogin(LoginParams params) async {
    final result = await datasource.doLogin(LoginRequest(email: params.email, password: params.password, firebase_token: params.fcmToken));
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, CommonResponse>> doRegister(RegisterParams params) async {
    final result = await datasource.doRegister(RegisterRequest(email: params.email, password: params.password, full_name: params.fullName));
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ProfileResponse>> doGetProfile() async {
    final result = await datasource.doGetProfile();
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, CommonResponse>> doLogout() async {
    final result = await datasource.doLogout();
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, CommonResponse>> doResetPassword(ResetPasswordParams params) async {
    final result = await datasource.doForgotPassword(ResetPasswordRequest(email: params.email, password: params.password));
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, ReferencesResponse>> getReferences(ReferencesParams params) async {
    final result = await datasource.doGetReferences(ReferencesRequest(category: params.category));
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, CommonResponse>> doChangePassword(ChangePasswordParams params) async {
    final result = await datasource.doChangePassword(ChangePasswordRequest(
      new_password: params.newPassword,
      old_password: params.oldPassword
    ));
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, CommonResponse>> doRequestDeleteAccount(DeleteAccountParams params) async {
    final result = await datasource.doRequestDeleteAccount(DeleteAccountRequest(
      email: params.email,
      reason: params.reason,
      platform: 'mobile'
    ));
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, CommonResponse>> doUpdateProfile(UpdateProfileParams params) async {
    final result = await datasource.doUpdateProfile(UpdateProfileRequest(
      full_name: params.full_name,
      address: params.address,
      date_of_birth: params.date_of_birth,
      gender: params.gender,
      grade: params.grade,
      institution_name: params.institution_name,
      phone_number: params.phone_number,
      profile_picture: params.profile_picture
    ));
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
