import 'package:dio/dio.dart';
import 'package:qiniu_sdk_dart/qiniu_sdk_dart.dart';

import 'config.dart';

Dio getDio() {
  final Dio dio = Dio();
  final auth = Auth(
    accessKey: accessKey,
    secretKey: secretKey,
  );

  dio.options.baseUrl = 'http://${RegionHostList.z0.uc}';
  dio.interceptors.add(QiniuAuthDioInterceptor(auth));
  return dio;
}
