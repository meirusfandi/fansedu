import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_response.freezed.dart';

part 'language_response.g.dart';

@freezed
class LanguageResponse with _$LanguageResponse {
  const factory LanguageResponse({DataMeta? meta, List<DataLanguage>? data}) =
      _LanguageResponse;

  factory LanguageResponse.fromJson(Map<String, Object?> json) =>
      _$LanguageResponseFromJson(json);
}

@freezed
class DataLanguage with _$DataLanguage {
  const factory DataLanguage({
    String? code,
    String? name,
    int? sort,
  }) = _DataLanguage;

  factory DataLanguage.fromJson(Map<String, Object?> json) =>
      _$DataLanguageFromJson(json);
}

@freezed
class DataMeta with _$DataMeta {
  const factory DataMeta({int? total_count, int? filter_count}) = _DataMeta;

  factory DataMeta.fromJson(Map<String, Object?> json) =>
      _$DataMetaFromJson(json);
}
