import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info_item.freezed.dart';

part 'device_info_item.g.dart';

@freezed
class DeviceInfoItem with _$DeviceInfoItem {
  const factory DeviceInfoItem({
    String? deviceId,
    String? brand,
    String? osType,
    String? osVersion,
  }) = _DeviceInfoItem;

  factory DeviceInfoItem.fromJson(Map<String, Object?> json) =>
      _$DeviceInfoItemFromJson(json);
}
