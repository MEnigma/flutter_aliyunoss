//
//  UploadEvent.h
//  flutter_aliyunoss
//
//  Created by Mark on 2019/6/16.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <AliyunOSSiOS/OSSService.h>
#import "UpdateOptions.h"

NS_ASSUME_NONNULL_BEGIN

/// 上传管理
@interface UploadEvent : NSObject

+(UploadEvent *)installFromMethodcall:(FlutterMethodCall *)call
                               result:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
