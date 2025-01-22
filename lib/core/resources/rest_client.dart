import 'package:dio/dio.dart';
import 'package:fansedu/core/config/helpers/lang_config.dart';
import 'package:fansedu/data/model/response/common_response.dart';
import 'package:fansedu/data/model/response/login_response.dart';
import 'package:fansedu/data/model/response/profile_response.dart';
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
  Future<LoginResponse> doLogin(@Body() String request);

  @POST('auth-service/register')
  Future<CommonResponse> doRegister(@Body() String request);

  @POST('auth-service/forgot-password')
  Future<CommonResponse> doResetPassword(@Body() String request);

  @POST('auth-service/logout')
  Future<CommonResponse> doLogout(@Header("Authorization") String token);

  // user service
  @POST('user-service/get-profile')
  Future<ProfileResponse> doGetProfile(@Header("Authorization") String token);
}
