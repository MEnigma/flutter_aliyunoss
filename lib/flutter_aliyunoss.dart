library flutter_aliyunoss;

import 'dart:async';
import 'package:flutter/services.dart';

import 'src/file_upload.dart';
import 'models/upload.dart';

class MKAliyunOSS {

  static MKAliyunOSS _shareOss = MKAliyunOSS();
  static MKAliyunOSS get shareOSS => _shareOss;

  /// 通道
  final MethodChannel _ossChannel = const MethodChannel("upload#file");

  Future<UpdateResult> uploadFile(UpdateOptions options){
    return _ossChannel.invokeMethod("uploadFile",options.toJson());
  }


  static const MethodChannel _normalChannel =  const MethodChannel('flutter_aliyunoss');

  static Future<String> get platformVersion async {
    final String version = await _normalChannel.invokeMethod('getPlatformVersion');
    return version;
  }



}