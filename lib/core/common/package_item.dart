import 'package:freezed_annotation/freezed_annotation.dart';

part 'package_item.freezed.dart';

part 'package_item.g.dart';

@freezed
class PackageItem with _$PackageItem {
  const factory PackageItem({
    String? appName,
    String? packageName,
    String? version,
    String? buildNumber,
    String? buildSignature,
    String? installerStore,
  }) = _PackageItem;

  factory PackageItem.fromJson(Map<String, Object?> json) =>
      _$PackageItemFromJson(json);
}
