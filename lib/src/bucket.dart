import 'package:dio/dio.dart';
import 'package:qiniu_sdk_dart/qiniu_sdk_dart.dart';

class BucketService {
  final QiniuSdkContext context;
  final Dio dio;
  BucketService(this.context) : dio = context.dio {
    dio.options.baseUrl = context.regionHost.uc.addHttpPrefix(context.useHttps);
  }

  Future<List<String>> getList() async {
    final response = await dio.get<List>('/buckets');
    return response.data!.cast();
  }

  Bucket of(String name) => Bucket(context, name);
}

class Bucket {
  final String bucketName;
  final QiniuSdkContext context;
  final Dio dio;
  Bucket(this.context, this.bucketName) : dio = context.dio {
    dio.options.baseUrl = context.regionHost.rs.addHttpPrefix(context.useHttps);
  }

  /// 创建bucket
  Future<void> create({String? region = 'z0'}) async {
    try {
      await dio.post('/mkbucketv3/$bucketName/region/$region');
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 614:
          throw BucketAlreadyExists()
            ..errorMsg = e.response?.data['error']
            ..bucketName = bucketName;
        default:
          print(e.response);
          rethrow;
      }
    }
  }

  /// 删除该bucket
  Future<void> drop() async {
    await dio.post('/drop/$bucketName');
  }

  /// 获取该bucket绑定的所有域名列表
  Future<List<String>> getDomainList() async {
    final response = await dio.post<List>('/v2/domains', queryParameters: {'tbl': bucketName});
    return response.data!.cast();
  }

  /// 列举该bucket中的对象
  Future<dynamic> list({
    int? limit, // 1-1000
    String? prefix,
  }) async {
    final old = dio.options.baseUrl;
    dio.options.baseUrl = context.regionHost.rsf.addHttpPrefix(context.useHttps);
    try {
      final response = await dio.get(
        '/list',
        queryParameters: {
          'bucket': bucketName,
          if (limit != null) 'limit': limit,
          if (prefix != null) 'prefix': prefix,
        },
      );
      return response.data['items'];
    } finally {
      dio.options.baseUrl = old;
    }
  }

  /// 操作某个资源对象
  Object of(String objectName) {
    return Object(bucketName, objectName, dio);
  }
}
