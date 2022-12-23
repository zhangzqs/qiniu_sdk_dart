import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'auth.dart';

class QiniuDateDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final now = DateTime.now().toUtc();
    final t1 = DateFormat('yyyyMMdd').format(now);
    final t2 = DateFormat('HHmmss').format(now);
    options.headers['X-Qiniu-Date'] = '${t1}T${t2}Z';
    handler.next(options);
  }
}

class QiniuAuthDioInterceptor extends Interceptor {
  final BasicAuth auth;

  QiniuAuthDioInterceptor(this.auth);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    StringBuffer buf = StringBuffer('${options.method} ${options.path}');
    if (options.uri.hasQuery) buf.write('?${options.uri.query}');

    // 接下来增加 Host 信息
    buf.write('\nHost: ${options.uri.host}');

    // 如果存在Content-Type的Header，那么也需要添加
    if (options.contentType != null) {
      buf.write('\nContent-Type: ${options.contentType}');
    }

    HashMap.fromEntries(options.headers.entries.where((e) => e.key.startsWith('X-Qiniu-')))
        .entries
        .map((e) => '${e.key}: ${e.value}')
        .forEach((e) {
      buf.write('\n$e');
    });

    buf.write('\n\n');
    if (options.data != null && options.contentType != 'application/octet-stream') {
      buf.write(options.data);
    }
    final accessToken = auth.generateAccessToken(data: utf8.encode(buf.toString()));
    options.headers['Authorization'] = 'Qiniu $accessToken';
    handler.next(options);
  }
}

class HttpProxy extends HttpOverrides {
  final String host;
  final int port;
  HttpProxy(this.host, this.port);

  static void useGlobalHttpProxy(HttpProxy proxy) => HttpOverrides.global = proxy;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    // 设置证书检查
    client.badCertificateCallback = (cert, host, port) => true;
    // 设置代理
    client.findProxy = (url) => 'PROXY $host:$port';
    return client;
  }
}
