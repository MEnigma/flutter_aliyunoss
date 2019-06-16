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
    }
    
}
-(void)uploadFile:(FlutterMethodCall*)call{
    UpdateOptions *options = [UpdateOptions mj_setKeyValues:call.arguments];
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
    for(int i = 0; i < options.filesBaseCode.count;i++){
        OSSPutObjectRequest *putRequest = [OSSPutObjectRequest.alloc init];
        putRequest.uploadingData = [NSData.alloc initWithBase64EncodedString:options.filesData[i] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        putRequest.bucketName = options.buketname;
        
        NSString *dirname = (options.dirname && options.dirname.length>0) ? [options.dirname stringByAppendingString:@"/"] : @"";
        putRequest.objectKey = [NSString stringWithFormat:@"%@%u",dirname,arc4random()];
        OSSTask *task = [client putObject:putRequest];
        [task waitUntilFinished];
        if(task.error){
            faileCount+=1;
        }
    }
    if(self.result){
        UpdateResult *result = [UpdateResult new];
        result.result = true;
        result.totalnum = options.filesData.count;
        result.succedNum = result.totalnum-faileCount;
        result.failNum = faileCount;
        self.result(result.mj_JSONObject);
    }
    
}

@end
