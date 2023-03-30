// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtUtils {
  static const String _keyName = 'jwt';
  static String? _jwtKey;

  // static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static void storeKey(String newJwtKey) async => _jwtKey = newJwtKey;

  // await _storage.write(key: _keyName, value: newJwtKey);

  static Future<String> getKey() async {
    // String? jwtKey = await _storage.read(key: _keyName);
    String? existingJwtKey = _jwtKey;

    if (existingJwtKey == null) {
      throw Exception('JWT key is null');
    }

    return existingJwtKey;
  }

  static Future<void> deleteKey() async {
    _jwtKey = '';
  }
}
