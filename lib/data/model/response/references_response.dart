import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_response.freezed.dart';
part 'references_response.g.dart';

@freezed
class ReferencesResponse with _$ReferencesResponse {
  const factory ReferencesResponse({
    bool? success,
    String? message,
    int? code,
    List<DataReferencesResponse>? data
  }) = _ReferencesResponse;

  factory ReferencesResponse.fromJson(Map<String, dynamic> json) => _$ReferencesResponseFromJson(json);
}

@freezed
class DataReferencesResponse with _$DataReferencesResponse {
  const factory DataReferencesResponse({
    String? reference_id,
    String? category,
    String? title_id,
    String? title_en,
    String? content_id,
    String? content_en,
    String? created_at,
    String? updated_at,
    String? deleted_at,
  }) = _DataReferencesResponse;

  factory DataReferencesResponse.fromJson(Map<String, dynamic> json) => _$DataReferencesResponseFromJson(json);
}
