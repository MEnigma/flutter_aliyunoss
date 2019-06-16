#import "FlutterAliyunossPlugin.h"
#import "UploadEvent.h"
#import "channel.h"

@implementation FlutterAliyunossPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    FlutterMethodChannel *uploadChannel  = [FlutterMethodChannel methodChannelWithName:CHANNEL_UPLOADFILE
                                                                       binaryMessenger:registrar.messenger];
    [uploadChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        [UploadEvent installFromMethodcall:call result:result];
    }];
    
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_aliyunoss"
            binaryMessenger:[registrar messenger]];
  FlutterAliyunossPlugin* instance = [[FlutterAliyunossPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
    
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
