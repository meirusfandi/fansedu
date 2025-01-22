import 'package:fansedu/core/helpers/secure_storage/storage_key_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final _storage = const FlutterSecureStorage();
  Future<String?> get getAuthToken async => await read(StorageKey.authToken);
  Future<String?> get getUserId async => await read(StorageKey.userid);
  Future<String?> get getFullName async => await read(StorageKey.fullName);
  Future<String?> get getForceLogout async =>
      await read(StorageKey.forceLogout);
  Future<String?> get getEmail async => await read(StorageKey.email);
  Future<String?> get getExpiredToken async =>
      await read(StorageKey.expiredToken);

  Future<void> write(StorageKey key, String value) async {
    _storage.write(
      key: key.name,
      value: value,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  Future<String?> read(StorageKey key) async {
    return await _storage.read(
        key: key.name,
        aOptions: const AndroidOptions(
          encryptedSharedPreferences: true,
        ));
  }

  Future<void> clear() async {
    await _storage.delete(
      key: StorageKey.authToken.name,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
    await _storage.delete(
      key: StorageKey.userid.name,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
    await _storage.delete(
      key: StorageKey.fullName.name,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
    await _storage.delete(
      key: StorageKey.email.name,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
  }
}

final storage = Storage();
