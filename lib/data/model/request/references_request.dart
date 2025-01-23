import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_request.freezed.dart';
part 'references_request.g.dart';

@freezed
class ReferencesRequest with _$ReferencesRequest {
  const factory ReferencesRequest({
    String? category
  }) = _ReferencesRequest;

  factory ReferencesRequest.fromJson(Map<String, dynamic> json) => _$ReferencesRequestFromJson(json);
}