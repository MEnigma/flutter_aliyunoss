/**
    Project         : flutter_aliyunoss
    Package name    : models
    Filename        : upload
    Date            : 2019/6/16 6:26 PM

    AUTHER : Mark
    EMAIL  : mkw666311@163.com
 */

import "package:flutter/material.dart";
import 'dart:io';
import 'dart:convert';

/// 上传参数
class UpdateOptions {

  UpdateOptions({
    this.accessKeyID,
    this.accessSecretID,
    this.accessToken,
    this.endPoint,
    this.buketname,
    this.filesPath,
    this.dirname,
    this.filesData,
    this.oriFileNames,
    this.filesBaseCode,
  }) :super();

  loadfiles(List<File> files) {
    if (files != null && files.length > 0) {
      /// 有数据
      this.filesBaseCode = [];
      for (File file in files) {
        file.readAsBytes().then((List<int> filebytes) {
          this.filesBaseCode.add(base64Encode(filebytes));
        });
      }
    }
  }

  initFromJson(Map<String, dynamic> data) {
    this.accessKeyID = data['accessKeyID'] ?? "";
    this.accessSecretID = data['accessSecretID'] ?? "";
    this.accessToken = data['accessToken'] ?? "";
    this.endPoint = data['endPoint'] ?? "";
    this.buketname = data['buketname'] ?? "";
    this.filesPath = data['filesPath'] ?? [];
    this.filesData = data['filesData'] ?? [];
    this.dirname = data['dirname'] ?? "";
    this.filesBaseCode = data['filesBaseCode'] ?? [];
    this.oriFileNames = data['oriFileNames'] ?? [];
  }

  String toJson() {
    List suffix = (this.oriFileNames ?? []).map((var name) {
      return name
          .toString()
          .split('.')
          .last;
    }).toList();

    return jsonEncode({
      'accessKeyID': this.accessKeyID,
      'accessSecretID': this.accessSecretID,
      'accessToken': this.accessToken,
      'endPoint': this.endPoint,
      'buketname': this.buketname,
      'filesPath': this.filesPath,
      'dirname': this.dirname,
      'filesData': this.filesData,
      'filesBaseCode': this.filesBaseCode,
      'oriFileNames': this.oriFileNames,
      'oriFileNames_suffix': suffix,
    });
  }

  /// access key
  String accessKeyID;

  /// access secret
  String accessSecretID;

  /// access token
  String accessToken;

  /// endpoint
  String endPoint;

  /// buket
  String buketname;

  /// 文件夹路径
  String dirname;

  /// 图片地址
  List<String> filesPath;

  /// 图片data
  List<int> filesData;

  /// 图片base64
  List<String> filesBaseCode;

  /// 原图片名
  List<dynamic> oriFileNames;


}

/// 进度
class UpdateProgress {
  initFromJson(Map<String, dynamic> data) {
    this.bytesSent = double.parse((data['bytesSent'] ?? "0").toString());
    this.totalByteSent =
        double.parse((data['totalByteSent'] ?? "0").toString());
    this.totalBytesExpectedToSend =
        double.parse((data['totalBytesExpectedToSend'] ?? "0").toString());
  }

  String toJson() {
    return jsonEncode({
      'bytesSent': this.bytesSent,
      'totalByteSent': this.totalByteSent,
      'totalBytesExpectedToSend': this.totalBytesExpectedToSend,
    });
  }

  /// 已发送
  double bytesSent;

  /// 总数
  double totalByteSent;

  double totalBytesExpectedToSend;
}

/// 上传结果
class UpdateResult {
  initFromJson(Map data) {
    this.result = int.parse((data['result'] ?? "").toString()) == 1;
    this.message = data['message'] ?? "";
    this.totalnum = int.parse((data['totalnum'] ?? "").toString());
    this.succedNum = int.parse((data['succedNum'] ?? "").toString());
    this.failNum = int.parse((data['failNum'] ?? "").toString());
    this.fileNames = data['fileNames'] ?? [];
  }

  String toJson() {
    return jsonEncode({
      'result': this.result,
      'message': this.message,
      'totalnum': this.totalnum,
      'succedNum': this.succedNum,
      'failNum': this.failNum,
      'fileNames': this.fileNames
    });
  }

  ///  结果
  bool result;

  ///  消息
  String message;

  ///  总个数
  int totalnum;

  ///  成功个数
  int succedNum;

  ///  失败个数
  int failNum;

  /// 文件名称列表
  List<dynamic> fileNames;
}
