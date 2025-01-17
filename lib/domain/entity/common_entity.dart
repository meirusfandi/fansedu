import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_entity.freezed.dart';
part 'common_entity.g.dart';

@freezed
class CommonEntity with _$CommonEntity {
  const factory CommonEntity({
    required bool success,
    required String message,
    required int code
  }) = _CommonEntity;

  factory CommonEntity.fromJson(Map<String, dynamic> json) => _$CommonEntityFromJson(json);
}