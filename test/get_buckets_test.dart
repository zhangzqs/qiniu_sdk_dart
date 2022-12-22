import 'package:qiniu_sdk_dart/qiniu_sdk_dart.dart';
import 'package:test/test.dart';

import 'init.dart';

void main() {
  final dio = getDio();
  test('get buckets test', () async {
    final list = await Bucket(dio).getList();
    print(list);
  });
}
