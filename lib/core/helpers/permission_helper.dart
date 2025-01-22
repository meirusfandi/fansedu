import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> checkStatusPermissionCamera() async {
    bool _isGranted = false;
    final status = await Permission.camera.status;

    if (status.isGranted) {
      _isGranted = true;
    }
    return _isGranted;
  }

  static Future<bool> checkStatusPermissionStorage() async {
    bool _isGranted = false;
    final status = await Permission.storage.status;
    if (status.isGranted) {
      _isGranted = true;
    }
    return _isGranted;
  }

  static Future<bool> checkStatusPermissionPhotoGallery() async {
    bool _isGranted = false;
    final status = await Permission.photos.status;
    if (status.isGranted) {
      _isGranted = true;
    }
    return _isGranted;
  }

  static Future<bool> checkStatusPermissionNotification() async {
    bool _isGranted = false;
    final status = await Permission.notification.status;
    if (status.isGranted) {
      _isGranted = true;
    }
    return _isGranted;
  }

  static Future<void> requestCameraPermissionHelpers() async {
    var status = await Permission.camera.request();
    if (status.isDenied) {
      await Permission.camera.request();
    } else if (status.isRestricted) {
      await openAppSettings();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      await Permission.camera.request();
    }
  }

  static Future<void> requestPhotoGalleryPermissionHelpers() async {
    var status = await Permission.photos.request();
    if (status.isDenied) {
      await Permission.photos.request();
    } else if (status.isRestricted) {
      await openAppSettings();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      await Permission.camera.request();
    }
  }

  static Future<void> requestStoragePermissionHelpers() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      await Permission.storage.request();
    } else if (status.isRestricted) {
      await openAppSettings();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      await Permission.camera.request();
    }
  }

  static Future<void> requestNotificationPermissionHelpers() async {
    var status = await Permission.notification.request();
    if (status.isDenied) {
      await Permission.notification.request();
    } else if (status.isRestricted) {
      await openAppSettings();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      await Permission.notification.request();
    }
  }
}
