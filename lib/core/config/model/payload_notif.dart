import 'package:freezed_annotation/freezed_annotation.dart';

part 'payload_notif.freezed.dart';
part 'payload_notif.g.dart';

@freezed
class PayloadNotif with _$PayloadNotif {
  factory PayloadNotif({
    String? scheduleId,
    int? hour,
    int? minutes,
  }) = _PayloadNotif;

  factory PayloadNotif.fromJson(Map<String, dynamic> json) =>
      _$PayloadNotifFromJson(json);
}
