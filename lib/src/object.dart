import 'dart:convert';

import 'package:dio/dio.dart';

class Object {
  final String bucketName;
  final String objectName;
  final Dio dio;

  late final encodedEntryURI = base64UrlEncode(utf8.encode('$bucketName:$objectName'));

  Object(this.bucketName, this.objectName, this.dio);

  Future<void> stat() async {
    final response = await dio.post('/stat/$encodedEntryURI');
    final json = response.data;
    print(json);
  }
}
