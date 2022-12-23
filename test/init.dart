import 'package:dio/dio.dart';
import 'package:qiniu_sdk_dart/qiniu_sdk_dart.dart';
import 'package:qiniu_sdk_dart/src/context.dart';

import 'config.dart';

Dio getDio() {
  HttpProxy.useGlobalHttpProxy(HttpProxy('127.0.0.1', 8866));
  final Dio dio = Dio();
  final auth = BasicAuth(
    accessKey: accessKey,
    secretKey: secretKey,
  );

  dio.options.baseUrl = 'http://${RegionHostList.z0.uc}';
  dio.options.headers['User-Agent'] = 'Dart qiniu/client package';
  dio.interceptors.addAll([
    QiniuDateDioInterceptor(),
    QiniuAuthDioInterceptor(auth),
  ]);
  return dio;
}

QiniuSdkContext getContext() {
  return QiniuSdkContext()
    ..dio = getDio()
    ..regionHost = RegionHostList.z2
    ..useHttps = false;
}
