import 'package:qiniu_sdk_dart/src/bucket.dart';
import 'package:test/scaffolding.dart';

import 'init.dart';

void main() {
  final context = getContext();
  test('get object stat', () async {
    await BucketService(context).of('zzq-test123').of('test.png').stat();
  });
}
