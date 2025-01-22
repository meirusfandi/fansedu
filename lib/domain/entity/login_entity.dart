import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_entity.freezed.dart';
part 'login_entity.g.dart';

@freezed
class LoginEntity with _$LoginEntity {
  const factory LoginEntity({
    required bool success,
    required String message,
    required int code,
    required DataLoginEntity data
  }) = _LoginEntity;

  factory LoginEntity.fromJson(Map<String, dynamic> json) => _$LoginEntityFromJson(json);
}

@freezed
class DataLoginEntity with _$DataLoginEntity {
  const factory DataLoginEntity({
    required String token,
    required String expired_at,
    required String user_id,
    required String email,
    required String full_name
  }) = _DataLoginEntity;

  factory DataLoginEntity.fromJson(Map<String, dynamic> json) => _$DataLoginEntityFromJson(json);
}