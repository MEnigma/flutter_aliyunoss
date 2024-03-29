library flutter_aliyunoss;

import 'dart:async';
import 'package:flutter/services.dart';

import 'src/file_upload.dart';
import 'models/upload.dart';

export 'models/upload.dart';
export 'src/file_upload.dart';

class MKAliyunOSS {

  static MKAliyunOSS _shareOss = MKAliyunOSS();
  static MKAliyunOSS get shareOSS => _shareOss;

  /// 通道
  final MethodChannel _ossChannel = const MethodChannel("upload#file");

  Future<UpdateResult> uploadFile(UpdateOptions options) async {
    Map result = await _ossChannel.invokeMethod("uploadFile",options.toJson());
    return UpdateResult()..initFromJson(result);
  }


  static const MethodChannel _normalChannel =  const MethodChannel('flutter_aliyunoss');

  static Future<String> get platformVersion async {
    final String version = await _normalChannel.invokeMethod('getPlatformVersion');
    return version;
  }



}