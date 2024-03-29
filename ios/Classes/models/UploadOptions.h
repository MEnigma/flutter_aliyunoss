//
//  UpdateOptions.h
//  AliyunOSSiOS
//
//  Created by Mark on 2019/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 上传参数
@interface UpdateOptions : NSObject

/** access key */
@property (nonatomic ,copy) NSString * accessKeyID;

/** access secret */
@property (nonatomic ,copy) NSString * accessSecretID;

/** access token */
@property (nonatomic ,copy) NSString * accessToken;

/** endpoint */
@property (nonatomic ,copy) NSString * endPoint;

/** buket */
@property (nonatomic ,copy) NSString * buketname;

/** 文件夹路径 */
@property (nonatomic ,copy) NSString * dirname;

/** 图片地址 */
@property (nonatomic ,copy) NSArray<NSString*> *filesPath;

/** 图片data */
@property (nonatomic ,strong) NSArray<NSData *>* filesData;

/** 图片base64 */
@property (nonatomic ,strong) NSArray<NSString*> *filesBaseCode;

/** 原图片名 */
@property (nonatomic ,strong) NSArray <NSString *> *oriFileNames;

/** 原图片名尾缀 */
@property (nonatomic ,strong) NSArray <NSString *> *oriFileNames_suffix;
@end


/// 进度
@interface UpdateProgress : NSObject

/** 已发送 */
@property(nonatomic) int64_t bytesSent;
/** 总数 */
@property(nonatomic) int64_t totalByteSent;

@property(nonatomic) int64_t totalBytesExpectedToSend;

@end

@interface UpdateResult : NSObject

/** 结果 */
@property (nonatomic ,assign) NSInteger result;

/** 消息 */
@property (nonatomic ,copy) NSString * message;

/** 总个数 */
@property (nonatomic ,assign) NSInteger totalnum;

/** 成功个数 */
@property (nonatomic ,assign) NSInteger succedNum;

/** 失败个数 */
@property (nonatomic ,assign) NSInteger failNum;

/** 文件名 */
@property (nonatomic ,strong) NSArray<NSString *> *fileNames;

@end
NS_ASSUME_NONNULL_END
