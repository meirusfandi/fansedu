import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_response.freezed.dart';
part 'common_response.g.dart';

@freezed
class CommonResponse with _$CommonResponse {
  const factory CommonResponse({
    bool? success,
    String? message,
    int? code
  }) = _CommonResponse;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => _$CommonResponseFromJson(json);
}