import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    bool? success,
    String? message,
    int? code,
    DataLoginResponse? data
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
}

@freezed
class DataLoginResponse with _$DataLoginResponse {
  const factory DataLoginResponse({
    String? token,
    String? expired_at,
    String? user_id,
    String? email,
    String? full_name
  }) = _DataLoginResponse;

  factory DataLoginResponse.fromJson(Map<String, dynamic> json) => _$DataLoginResponseFromJson(json);
}