import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';
part 'profile_entity.g.dart';

@freezed
class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required bool success,
    required String message,
    required int code,
    required DataProfileEntity data
  }) = _ProfileEntity;

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);
}

@freezed
class DataProfileEntity with _$DataProfileEntity {
  const factory DataProfileEntity({
    required String user_id,
    required String profile_id,
    required String email,
    required String full_name,
    required String phone_number,
    required String address,
    required String profile_picture,
    required String gender,
    required String date_of_birth,
    required String grade,
    required String institution_name,
    required DataRoleEntity role,
  }) = _DataProfileEntity;

  factory DataProfileEntity.fromJson(Map<String, dynamic> json) => _$DataProfileEntityFromJson(json);
}

@freezed
class DataRoleEntity with _$DataRoleEntity {
  const factory DataRoleEntity({
    required String role_id,
    required String role_name,
    required String role_description
  }) = _DataRoleEntity;

  factory DataRoleEntity.fromJson(Map<String, dynamic> json) => _$DataRoleEntityFromJson(json);
}