import 'package:dio/dio.dart';

class BucketWithName {
  final String name;
  final Dio dio;
  BucketWithName(this.name, this.dio);

  Future<void> make({required String name, String? region = 'z0'}) async {
    await dio.post('/mkbucketv3/$name/region/$region');
  }

  Future<void> delete({required String name}) async {
    await dio.post('/drop/$name');
  }

  Future<List<String>> getDomainList({required String name}) async {
    final response = await dio.post<List>('/v2/domains', queryParameters: {'tbl': name});
    return response.data!.cast();
  }
}

class Bucket {
  final Dio dio;
  Bucket(this.dio);

  Future<List<String>> getList() async {
    final response = await dio.get<List>('/buckets');
    return response.data!.cast();
  }

  BucketWithName of(String name) => BucketWithName(name, dio);
}
