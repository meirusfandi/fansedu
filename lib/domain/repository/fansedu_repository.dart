import 'package:dartz/dartz.dart';
import 'package:fansedu/core/failure/failure.dart';
import 'package:fansedu/data/model/response/common_response.dart';
import 'package:fansedu/data/model/response/login_response.dart';
import 'package:fansedu/data/model/response/profile_response.dart';
import 'package:fansedu/data/model/response/references_response.dart';
import 'package:fansedu/domain/usecase/do_change_password.dart';
import 'package:fansedu/domain/usecase/do_delete_account.dart';
import 'package:fansedu/domain/usecase/do_login.dart';
import 'package:fansedu/domain/usecase/do_register.dart';
import 'package:fansedu/domain/usecase/do_reset_password.dart';
import 'package:fansedu/domain/usecase/do_update_profile.dart';
import 'package:fansedu/domain/usecase/get_references.dart';

abstract class FanseduRepository {
  Future<Either<Failure, LoginResponse>> doLogin(LoginParams params);
  Future<Either<Failure, CommonResponse>> doRegister(RegisterParams params);
  Future<Either<Failure, ProfileResponse>> doGetProfile();
  Future<Either<Failure, CommonResponse>> doResetPassword(ResetPasswordParams params);
  Future<Either<Failure, CommonResponse>> doLogout();
  Future<Either<Failure, ReferencesResponse>> getReferences(ReferencesParams params);
  Future<Either<Failure, CommonResponse>> doUpdateProfile(UpdateProfileParams params);
  Future<Either<Failure, CommonResponse>> doChangePassword(ChangePasswordParams params);
  Future<Either<Failure, CommonResponse>> doRequestDeleteAccount(DeleteAccountParams params);
}