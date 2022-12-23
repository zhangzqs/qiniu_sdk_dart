import 'package:dio/dio.dart';
import 'package:qiniu_sdk_dart/qiniu_sdk_dart.dart';

class QiniuSdkContext {
  Dio dio = Dio();
  RegionHost regionHost = RegionHostList.z0;
  bool useHttps = false;
}
