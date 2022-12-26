class BucketAlreadyExists implements Exception {
  String errorMsg = '';
  String bucketName = '';

  @override
  String toString() {
    return 'BucketAlreadyExists{errorMsg: $errorMsg, bucketName: $bucketName}';
  }
}
