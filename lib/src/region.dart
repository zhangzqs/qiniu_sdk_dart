extension AddHttpScheme on String {
  String addHttpPrefix(bool useHttps) {
    return (useHttps ? 'https://' : 'http://') + this;
  }
}

class RegionHost {
  /// 空间管理
  final String uc;

  /// 加速上传
  final String upload;

  /// 源站上传
  final String up;

  /// 源站下载
  final String io;

  /// 对象管理
  final String rs;

  /// 对象列举
  final String rsf;

  /// 计量查询
  final String api;

  const RegionHost({
    required this.uc,
    required this.upload,
    required this.up,
    required this.io,
    required this.rs,
    required this.rsf,
    required this.api,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || // 先检查引用是否相同
      other is RegionHost && // 再检查类型和字段
          runtimeType == other.runtimeType &&
          uc == other.uc &&
          upload == other.upload &&
          up == other.up &&
          io == other.io &&
          rs == other.rs &&
          rsf == other.rsf &&
          api == other.api;

  @override
  int get hashCode =>
      uc.hashCode ^ upload.hashCode ^ up.hashCode ^ io.hashCode ^ rs.hashCode ^ rsf.hashCode ^ api.hashCode;
}

class RegionHostList {
  // 存储区域: 华东-浙江
  static const z0 = RegionHost(
    uc: 'uc.qiniuapi.com', // 空间管理
    upload: 'upload.qiniup.com', // 加速上传,
    up: 'up.qiniup.com', // 源站上传,
    io: 'iovip.qiniuio.com', // 源站下载,
    rs: 'rs-z0.qiniuapi.com', // 对象管理,
    rsf: 'rsf-z0.qiniuapi.com', // 对象列举,
    api: 'api.qiniuapi.com', // 计量查询,
  );

  // 存储区域: 华东-浙江2
  static const cnEast2 = RegionHost(
    uc: 'uc.qiniuapi.com', // 空间管理
    upload: 'upload-cn-east-2.qiniup.com', // 加速上传,
    up: 'up-cn-east-2.qiniup.com', // 源站上传,
    io: 'iovip-cn-east-2.qiniuio.com', // 源站下载,
    rs: 'rs-cn-east-2.qiniuapi.com', // 对象管理,
    rsf: 'rsf-cn-east-2.qiniuapi.com', // 对象列举,
    api: 'api.qiniuapi.com', // 计量查询,
  );

  // 存储区域: 华北-河北
  static const z1 = RegionHost(
    uc: 'uc.qiniuapi.com', // 空间管理
    upload: 'upload-z1.qiniup.com', // 加速上传,
    up: 'up-z1.qiniup.com', // 源站上传,
    io: 'iovip-z1.qiniuio.com', // 源站下载,
    rs: 'rs-z1.qiniuapi.com', // 对象管理,
    rsf: 'rsf-z1.qiniuapi.com', // 对象列举,
    api: 'api.qiniuapi.com', // 计量查询,
  );

  // 存储区域: 华南-广东
  static const z2 = RegionHost(
    uc: 'uc.qiniuapi.com', // 空间管理
    upload: 'upload-z2.qiniup.com', // 加速上传,
    up: 'up-z2.qiniup.com', // 源站上传,
    io: 'iovip-z2.qiniuio.com', // 源站下载,
    rs: 'rs-z2.qiniuapi.com', // 对象管理,
    rsf: 'rsf-z2.qiniuapi.com', // 对象列举,
    api: 'api.qiniuapi.com', // 计量查询,
  );

  // 存储区域: 北美-洛杉矶
  static const na0 = RegionHost(
    uc: 'uc.qiniuapi.com', // 空间管理
    upload: 'upload-na0.qiniup.com', // 加速上传,
    up: 'up-na0.qiniup.com', // 源站上传,
    io: 'iovip-na0.qiniuio.com', // 源站下载,
    rs: 'rs-na0.qiniuapi.com', // 对象管理,
    rsf: 'rsf-na0.qiniuapi.com', // 对象列举,
    api: 'api.qiniuapi.com', // 计量查询,
  );

  // 存储区域: 亚太-新加坡（原东南亚）
  static const as0 = RegionHost(
    uc: 'uc.qiniuapi.com', // 空间管理
    upload: 'upload-as0.qiniup.com', // 加速上传,
    up: 'up-as0.qiniup.com', // 源站上传,
    io: 'iovip-as0.qiniuio.com', // 源站下载,
    rs: 'rs-as0.qiniuapi.com', // 对象管理,
    rsf: 'rsf-as0.qiniuapi.com', // 对象列举,
    api: 'api.qiniuapi.com', // 计量查询,
  );

  // 存储区域: 亚太-首尔
  static const apNortheast1 = RegionHost(
    uc: 'uc.qiniuapi.com', // 空间管理
    upload: 'upload-ap-northeast-1.qiniup.com', // 加速上传,
    up: 'up-ap-northeast-1.qiniup.com', // 源站上传,
    io: 'iovip-ap-northeast-1.qiniuio.com', // 源站下载,
    rs: 'rs-ap-northeast-1.qiniuapi.com', // 对象管理,
    rsf: 'rsf-ap-northeast-1.qiniuapi.com', // 对象列举,
    api: 'api.qiniuapi.com', // 计量查询,
  );
}
