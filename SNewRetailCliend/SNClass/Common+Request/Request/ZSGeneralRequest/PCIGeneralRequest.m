//
//  PCIGeneralRequest.m
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2018/12/13.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "PCIGeneralRequest.h"
#import "ZSInterfacedConst.h"
#import <AliyunOSSiOS/OSSService.h>
#import <Photos/Photos.h>
#import "LGSoundRecorder.h"
#import "ZSNetworkHelper.h"

@implementation PCIGeneralRequest
/** 客户端 | 登录 */
+ (void)loginWithParameters:(NSDictionary *)parameter isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kLogin];
    [self requestDataWithURL:url parameters:parameter isCache:isCache success:success failure:failure];
}

/** 通用 | 发送短信验证码 */
+ (void)getSendCodeParameters:(NSDictionary *)parameter isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kSendMessage];
    [self requestDataWithURL:url parameters:parameter isCache:isCache success:success failure:failure];
}

/** 上传图片 */
+ (void)uploadImagesWithImages:(NSArray *)images isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    NSMutableArray *mulFilenameArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < images.count; i ++) {
        PHAsset *assets = images[i];
        NSString *filename = [[assets valueForKey:@"filename"] lowercaseStringWithLocale:[NSLocale currentLocale]];
        [mulFilenameArr addObject:filename];
    }
    
    NSDictionary *parameters = @{
                                 @"type":@"image",
                                 @"filename":mulFilenameArr,
                                 };
    
    @weakify(self);
    [self uploadFileParameters:parameters isCache:NO success:^(id response) {
        @strongify(self);
        if ([[response objectForKey:@"error_code"] isEqualToString:@"SUCCESS"]) {
            
            NSMutableArray *mulDataArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < images.count; i ++) {
                
                PHAsset *assets = images[i];
                [[PHImageManager defaultManager] requestImageForAsset:assets targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage *resultImage, NSDictionary *info) {
                    
                    if ([[info valueForKey:@"PHImageResultIsDegradedKey"]integerValue] == 0){
//                        NSData* imageData = UIImagePNGRepresentation(resultImage);
                        NSData *imageData = UIImageJPEGRepresentation(resultImage, 0.4);
                        [mulDataArr addObject:imageData];
                    }
                    if (i == images.count - 1) {
                        
                        [self uploadOSSWithDataArr:mulDataArr parameters:response type:@"上传图片" success:success failure:failure];
                    }
                }];
            }
            
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

/** 上传视频 */
+ (void)uploadVideoWithVideo:(NSString *)videoPath isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    NSDictionary *parameters = @{
                                 @"type":@"video",
                                 @"filename":[[videoPath lastPathComponent] lowercaseStringWithLocale:[NSLocale currentLocale]],
                                 };
    
    [PCIGeneralRequest uploadFileParameters:parameters isCache:NO success:^(id response) {
        
        if ([[response objectForKey:@"error_code"] isEqualToString:@"SUCCESS"]) {
            
            NSData *videoData = [NSData dataWithContentsOfFile:videoPath];
            
            [self uploadOSSWithDataArr:@[videoData] parameters:response type:@"上传视频" success:success failure:failure];
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}


/** 上传音频 */
+ (void)uploadAudioWithVideo:(NSString *)AudioPath isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    NSDictionary *parameters = @{
                                 @"type":@"audio",
                                 @"filename":[NSString stringWithFormat:@"%@.amr",[RYToolClass getNowTimeTimestamp]],
                                 };
    
    [PCIGeneralRequest uploadFileParameters:parameters isCache:NO success:^(id response) {
        
        if ([[response objectForKey:@"error_code"] isEqualToString:@"SUCCESS"]) {
            
            NSData *videoData = [[LGSoundRecorder shareInstance] convertCAFtoAMR:AudioPath];
            [self uploadOSSWithDataArr:@[videoData] parameters:response type:@"上传音频" success:success failure:failure];
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/** 31. 通用 | OSS客户端STS凭证直传上传接口 */
+ (void)uploadFileParameters:(NSDictionary *)parameter isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kStsFile];
    [self requestDataWithURL:url parameters:parameter isCache:isCache success:success failure:failure];
}

+ (void)uploadOSSWithDataArr:(NSArray <NSData *>*)data parameters:(NSDictionary *)parameters type:(NSString *)type success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *updata = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < data.count; i ++) {
            
            NSString *endpoint = @"https://oss-cn-hangzhou.aliyuncs.com";
            // 移动端建议使用STS方式初始化OSSClient。可以通过sample中STS使用说明了解更多(https://github.com/aliyun/aliyun-oss-ios-sdk/tree/master/DemoByOC)
            NSString *AccessKeyId = [[parameters objectForKey:@"result"] objectForKey:@"access_key_id"];
            NSString *AccessKeySecret = [[parameters objectForKey:@"result"] objectForKey:@"access_key_secret"];
            NSString *SecurityToken = [[parameters objectForKey:@"result"] objectForKey:@"security_token"];
            NSString *bucketName = [[parameters objectForKey:@"result"] objectForKey:@"bucket_name"];
            NSString *objectKey = [[[parameters objectForKey:@"result"] objectForKey:@"files"][i] objectForKey:@"filepath"];
            
            OSSPutObjectRequest * put = [OSSPutObjectRequest new];
            put.bucketName = bucketName;
            put.objectKey = objectKey;
            put.uploadingData = data[i]; // 直接上传NSData
            put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
                
                CGFloat totalByteSentF = [[NSString stringWithFormat:@"%lld",totalByteSent] floatValue];
                CGFloat totalBytesExpectedToSendF = [[NSString stringWithFormat:@"%lld",totalBytesExpectedToSend] floatValue];
                CGFloat count = 1 * 1.00 / data.count;
                CGFloat position = i * 1.00 / data.count;
                NSString *number = [NSString stringWithFormat:@"%.2f",((totalByteSentF/totalBytesExpectedToSendF) * count) + position];
                
                NSDictionary *dict = @{
                                       @"type":type,
                                       @"number":number,
                                       };
                [self performSelectorOnMainThread:@selector(updateProgressViewWithfloat:) withObject:dict waitUntilDone:NO];
                DLog(@"----------------%@ %f %@",number, count , [NSThread currentThread]);
            };
            
            id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:AccessKeyId secretKeyId:AccessKeySecret securityToken:SecurityToken];
            OSSClient *client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
            OSSTask * putTask = [client putObject:put];
            [putTask continueWithBlock:^id(OSSTask *task) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (i == data.count - 1) {
                        
                        if (!task.error) {
                            [SVProgressHUD showWithStatus:@"上传成功"];
                            
                            success([parameters[@"result"][@"files"] valueForKey:@"url"]);
                        } else {
                            
                            failure(task.error);
                            [SVProgressHUD showWithStatus:@"上传失败请重新上传"];
                        }
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [SVProgressHUD dismiss];
                        });
                    }
                });
                return nil;
            }];
            // 可以等待任务完成
            [putTask waitUntilFinished];
        }
    }];
    
    [queue addOperation:updata];
}

+ (void)updateProgressViewWithfloat:(NSDictionary *)dict{
    
    NSString *type = [NSString stringWithFormat:@"正在%@",dict[@"type"]];
    CGFloat number = [dict[@"number"] floatValue];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showProgress:number status:type];
}

/** 单图上传 */
+ (void)uploadImageWithImages:(UIImage *)image isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    NSDictionary *parameters = @{
                                 @"type":@"image",
                                 @"filename":[NSString stringWithFormat:@"%@.jpg",[RYToolClass getNowTimeTimestamp]],
                                 };
    
    @weakify(self);
    [self uploadFileParameters:parameters isCache:NO success:^(id response) {
        @strongify(self);
        if ([[response objectForKey:@"error_code"] isEqualToString:@"SUCCESS"]) {
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
            [self uploadOSSWithDataArr:@[imageData] parameters:response type:@"上传图片" success:success failure:failure];
        }else{
            
            NSError *error = [[NSError alloc] init];
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}



@end
