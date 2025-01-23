import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fansedu/core/config/helpers/lang_config.dart';
import 'package:fansedu/data/model/request/change_password_request.dart';
import 'package:fansedu/data/model/request/delete_account_request.dart';
import 'package:fansedu/data/model/request/login_request.dart';
import 'package:fansedu/data/model/request/references_request.dart';
import 'package:fansedu/data/model/request/register_request.dart';
import 'package:fansedu/data/model/request/reset_password_request.dart';
import 'package:fansedu/data/model/response/common_response.dart';
import 'package:fansedu/data/model/response/login_response.dart';
import 'package:fansedu/data/model/response/profile_response.dart';
import 'package:fansedu/data/model/response/references_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {required String baseUrl}) {
    dio.options = BaseOptions(
      headers: {
        "content-type": "application/json",
        "lang": LangConfig.instance.langValue,
      },
    );
    return _RestClient(dio, baseUrl: baseUrl);
  }

  @POST('auth-service/login')
  Future<LoginResponse> doLogin(@Body() LoginRequest request);

  @POST('auth-service/register')
  Future<CommonResponse> doRegister(@Body() RegisterRequest request);

  @POST('auth-service/forgot-password')
  Future<CommonResponse> doResetPassword(@Body() ResetPasswordRequest request);

  @POST('auth-service/logout')
  Future<CommonResponse> doLogout(@Header("Authorization") String token);

  // user service
  @POST('user-service/get-profile')
  Future<ProfileResponse> doGetProfile(@Header("Authorization") String token);

  @POST('user-service/change-password')
  Future<CommonResponse> doChangePassword(@Header("Authorization") String token, @Body() ChangePasswordRequest request);

  @POST('user-service/request-delete-account')
  Future<CommonResponse> doRequestDeleteAccount(@Header("Authorization") String token, @Body() DeleteAccountRequest request);

  @POST('user-service/update-profile')
  @MultiPart()
  Future<CommonResponse> doUpdateProfile(
      @Header("Authorization") String token,
      @Part() String full_name, @Part() File? profile_picture,
      @Part() String phone_number, @Part() String address,
      @Part() String gender, @Part() String date_of_birth,
      @Part() String grade, @Part() String institution_name
      );

  // references service
  @POST('reference-service/reference-list')
  Future<ReferencesResponse> doGetReferences(@Header("Authorization") String token, @Body() ReferencesRequest request);
}
