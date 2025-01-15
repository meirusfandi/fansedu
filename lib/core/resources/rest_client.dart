import 'package:dio/dio.dart';
import 'package:fansedu/core/config/helpers/lang_config.dart';
import 'package:fansedu/data/model/response/login_response.dart';
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

  @POST('auth/login')
  Future<LoginResponse> doLogin(@Body() String request);
}
