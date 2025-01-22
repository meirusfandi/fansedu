import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    bool? success,
    String? message,
    int? code,
    DataProfileResponse? data
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);
}

@freezed
class DataProfileResponse with _$DataProfileResponse {
  const factory DataProfileResponse({
    String? user_id,
    String? profile_id,
    String? email,
    String? full_name,
    String? phone_number,
    String? address,
    String? profile_picture,
    String? gender,
    String? date_of_birth,
    String? grade,
    String? institution_name,
    DataRoleResponse? role,
  }) = _DataProfileResponse;

  factory DataProfileResponse.fromJson(Map<String, dynamic> json) => _$DataProfileResponseFromJson(json);
}

@freezed
class DataRoleResponse with _$DataRoleResponse {
  const factory DataRoleResponse({
    String? role_id,
    String? role_name,
    String? role_description
  }) = _DataRoleResponse;

  factory DataRoleResponse.fromJson(Map<String, dynamic> json) => _$DataRoleResponseFromJson(json);
}