import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fansedu/core/common/device_info_item.dart';
import 'package:fansedu/core/common/package_info_data.dart';
import 'package:fansedu/core/common/package_item.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

DeviceInfoItem deviceInfo = const DeviceInfoItem();

Future<void> initPlatformState() async {
  final info = await PackageInfo.fromPlatform();
  var deviceData = const DeviceInfoItem();
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  packageInfo = PackageItem(
    appName: info.appName,
    packageName: info.packageName,
    version: info.version,
    buildNumber: info.buildNumber,
    buildSignature: info.buildSignature,
    installerStore: info.installerStore,
  );

  try {
    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }
  } on PlatformException {
    deviceData = const DeviceInfoItem();
  }
  deviceInfo = deviceData;
}

DeviceInfoItem _readAndroidBuildData(AndroidDeviceInfo build) {
  return DeviceInfoItem(
    deviceId: build.id,
    brand: build.brand,
    osType: 'android',
    osVersion: build.version.release,
  );
}

DeviceInfoItem _readIosDeviceInfo(IosDeviceInfo data) {
  return DeviceInfoItem(
    deviceId: data.identifierForVendor,
    brand: 'apple',
    osType: data.systemName,
    osVersion: data.systemVersion,
  );
}
