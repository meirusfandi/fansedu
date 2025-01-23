import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_entity.freezed.dart';
part 'references_entity.g.dart';

@freezed
class ReferencesEntity with _$ReferencesEntity {
  const factory ReferencesEntity({
    required bool success,
    required String message,
    required int code,
    required List<DataReferencesEntity> data
  }) = _ReferencesEntity;

  factory ReferencesEntity.fromJson(Map<String, dynamic> json) => _$ReferencesEntityFromJson(json);
}

@freezed
class DataReferencesEntity with _$DataReferencesEntity {
  const factory DataReferencesEntity({
    required String reference_id,
    required String category,
    required String title_id,
    required String title_en,
    required String content_id,
    required String content_en,
    required String created_at,
    required String updated_at,
    required String deleted_at,
  }) = _DataReferencesEntity;

  factory DataReferencesEntity.fromJson(Map<String, dynamic> json) => _$DataReferencesEntityFromJson(json);
}