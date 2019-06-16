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

  UpdateOptions.files(
      {this.accessKeyID,
      this.accessSecretID,
      this.accessToken,
      this.endPoint,
      this.buketname,
      this.filesPath,
      this.filesData,
      List<File> files}) {
      if(files != null && files.length>0){
        /// 有数据
        this.filesBaseCode = [];
        for (File file in files){
          file.readAsBytes().then((List<int> filebytes ){
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
    this.filesBaseCode = data['filesBaseCode'] ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      'accessKeyID': this.accessKeyID,
      'accessSecretID': this.accessSecretID,
      'accessToken': this.accessToken,
      'endPoint': this.endPoint,
      'buketname': this.buketname,
      'filesPath': this.filesPath,
      'filesData': this.filesData,
      'filesBaseCode': this.filesBaseCode,
    };
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

  /// 图片地址
  List<String> filesPath;

  /// 图片data
  List<int> filesData;

  /// 图片base64
  List<String> filesBaseCode;
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

  Map<String, dynamic> toJson() {
    return {
      'bytesSent': this.bytesSent,
      'totalByteSent': this.totalByteSent,
      'totalBytesExpectedToSend': this.totalBytesExpectedToSend,
    };
  }

  /// 已发送
  double bytesSent;

  /// 总数
  double totalByteSent;

  double totalBytesExpectedToSend;
}

/// 上传结果
class UpdateResult {
  initFromJson(Map<String, dynamic> data) {
    this.result = int.parse((data['result'] ?? "").toString()) == 1;
    this.message = data['message'] ?? "";
    this.totalnum = int.parse((data['totalnum'] ?? "").toString());
    this.succedNum = int.parse((data['succedNum'] ?? "").toString());
    this.failNum = int.parse((data['failNum'] ?? "").toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'result': this.result,
      'message': this.message,
      'totalnum': this.totalnum,
      'succedNum': this.succedNum,
      'failNum': this.failNum,
    };
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
}
