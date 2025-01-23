import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_account_request.freezed.dart';
part 'delete_account_request.g.dart';

@freezed
class DeleteAccountRequest with _$DeleteAccountRequest {
  const factory DeleteAccountRequest({
    String? email,
    String? reason,
    String? platform
  }) = _DeleteAccountRequest;

factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) => _$DeleteAccountRequestFromJson(json);
}
