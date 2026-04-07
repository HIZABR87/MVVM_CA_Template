import 'dart:math';
import 'dart:typed_data';

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvvm_architecture_template/core/hive/hive_boxes.dart';

class HiveDatabase {
  /// The key under which the AES-256 encryption key is stored in the
  /// platform's secure enclave (Android Keystore / iOS Keychain).
  static const String _encryptionKeyStorageKey = '_hive_auth_key';

  static final _secureStorage = const FlutterSecureStorage(
    // Android: store inside the hardware-backed EncryptedSharedPreferences.
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    // iOS/macOS: accessible only while the device is unlocked.
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static Future<void> init() async {
    await Hive.initFlutter();
    // await adapterRegistration();
    await _openBoxes();
  }

  // static Future<void> adapterRegistration() async {}

  static Future<void> _openBoxes() async {
    final encryptionKey = await _getOrCreateEncryptionKey();
    await Hive.openBox<String>(
      HiveBoxes.authorization,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    await Hive.openBox(HiveBoxes.userInfo);
  }

  /// Reads the AES-256 key from the secure enclave on subsequent launches.
  /// Generates a cryptographically secure random 32-byte key on the very first
  /// launch, persists it, then returns it for immediate use.
  static Future<Uint8List> _getOrCreateEncryptionKey() async {
    final stored = await _secureStorage.read(key: _encryptionKeyStorageKey);
    if (stored != null) return base64Url.decode(stored);

    final key = _generateSecureKey();
    await _secureStorage.write(
      key: _encryptionKeyStorageKey,
      value: base64Url.encode(key),
    );
    return key;
  }

  static Uint8List _generateSecureKey() {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(32, (_) => random.nextInt(256)),
    );
  }
}
