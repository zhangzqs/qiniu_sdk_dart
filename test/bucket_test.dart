import 'package:qiniu_sdk_dart/qiniu_sdk_dart.dart';
import 'package:test/test.dart';

import 'init.dart';

void main() {
  final context = getContext();
  test('get bucket list test', () async {
    final list = await BucketService(context).getList();
    print(list);
  });
  test('create new bucket', () async {
    await Bucket(context, 'zzq-test123-test').create();
  });
  test('delete bucket', () async {
    await Bucket(context, 'zzq-test123-test').drop();
  });
  test('bucket list', () async {
    print(await Bucket(context, 'zzq-test123').list());
  });
}
