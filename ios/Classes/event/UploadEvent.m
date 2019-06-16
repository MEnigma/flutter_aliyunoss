//
//  UploadEvent.m
//  flutter_aliyunoss
//
//  Created by Mark on 2019/6/16.
//

#import "UploadEvent.h"
#import <MJExtension.h>
#import <Photos/Photos.h>
#import <AliyunOSSiOS.h>
#import "UploadOptions.h"
#import <CommonCrypto/CommonCrypto.h>

@interface UploadEvent ()

/** 回调 */
@property (nonatomic) FlutterResult result;


@end
@implementation UploadEvent

+(UploadEvent *)installFromMethodcall:(FlutterMethodCall *)call result:(FlutterResult)result{
    UploadEvent *event = UploadEvent.new;
    event.result = result;
    [event callonMethod:call];
    return event;
}

// 执行事件
-(void)callonMethod:(FlutterMethodCall *)methodCall{
    if (!methodCall.arguments) {
        if(self.result){
            UpdateResult *uResult = UpdateResult.new;
            uResult.result = false;
            uResult.message = @"缺少参数";
            self.result(uResult.mj_JSONObject);
        }
    }
    
    NSString *method = [NSString stringWithFormat:@"%@:",methodCall.method];
    if ([self respondsToSelector:NSSelectorFromString(method)]) {
        [self performSelector:NSSelectorFromString(method) withObject:methodCall];
    }else{
        self.result(FlutterMethodNotImplemented);
    }
    
}
-(void)uploadFile:(FlutterMethodCall*)call{
    UpdateOptions *options = [UpdateOptions.new mj_setKeyValues:call.arguments];
    [self _uploadFileWithParam:options];
}
/// 隐性上传
-(void)_uploadFileWithParam:(UpdateOptions *)options{
    
    id<OSSCredentialProvider> provider = [OSSStsTokenCredentialProvider.alloc initWithAccessKeyId:options.accessKeyID
                                                                                      secretKeyId:options.accessSecretID
                                                                                    securityToken:options.accessToken];
    
    OSSClient *client = [OSSClient.alloc initWithEndpoint:options.endPoint
                                       credentialProvider:provider];
    
    NSInteger faileCount = 0;
    NSMutableArray *filenames = [NSMutableArray array];
    for(int i = 0; i < options.filesBaseCode.count;i++){
        OSSPutObjectRequest *putRequest = [OSSPutObjectRequest.alloc init];
        putRequest.uploadingData = [NSData.alloc initWithBase64EncodedString:options.filesBaseCode[i] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        putRequest.bucketName = options.buketname;
        
        NSString *dirname = (options.dirname && options.dirname.length>0) ? [options.dirname stringByAppendingString:@"/"] : @"";
        /// 后缀
        NSString *suffix = (options.oriFileNames_suffix  && (i < options.oriFileNames_suffix.count)) ? options.oriFileNames_suffix[i] : @".jpg";
        
        /// 制作文件名
        NSString *timestamp = [NSString stringWithFormat:@"%f",NSDate.date.timeIntervalSince1970];
        NSString *timestamp_base64 = [[timestamp dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSString *randomName = [NSString stringWithFormat:@"%@.%@",[UploadEvent md5:timestamp_base64],suffix];
        putRequest.objectKey = [NSString stringWithFormat:@"%@%@",dirname,randomName];
        
        [filenames addObject:putRequest.objectKey.copy];
        OSSTask *task = [client putObject:putRequest];
        [task waitUntilFinished];
        if(task.error){
            faileCount+=1;
        }
    }
    if(self.result){
        UpdateResult *result = [UpdateResult new];
        result.result = 1;
        result.totalnum = options.filesData.count;
        result.succedNum = result.totalnum-faileCount;
        result.failNum = faileCount;
        result.fileNames = filenames;
        result.message = options.mj_JSONString;
        self.result(result.mj_JSONObject);
    }
    
}

+ (nullable NSString *)md5:(nullable NSString *)str {
    if (!str) return nil;
    
    const char *cStr = str.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}
@end
