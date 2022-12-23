import 'dart:convert';

import 'package:crypto/crypto.dart';

class BasicAuth {
  final String accessKey;
  final String secretKey;

  const BasicAuth({
    required this.accessKey,
    required this.secretKey,
  });

  String generateAccessToken({required List<int> data}) {
    final hmacEncoder = Hmac(sha1, utf8.encode(secretKey));
    final sign = hmacEncoder.convert(data);
    final encodedSign = base64Url.encode(sign.bytes);
    return '$accessKey:$encodedSign';
  }

  @override
  String toString() {
    return 'Auth{accessKey: $accessKey, secretKey: $secretKey}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasicAuth &&
          runtimeType == other.runtimeType &&
          accessKey == other.accessKey &&
          secretKey == other.secretKey;

  @override
  int get hashCode => accessKey.hashCode ^ secretKey.hashCode;
}
