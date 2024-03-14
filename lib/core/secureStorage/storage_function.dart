// ignore_for_file: non_constant_identifier_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<dynamic> storageRead(FlutterSecureStorage secureStorage) async {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  var Token = await secureStorage.read(key: "Token");
  return Token;
}
