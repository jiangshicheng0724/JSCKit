//
//  PCIGeneralRequest.h
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2018/12/13.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "ZSHTTPRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCIGeneralRequest : ZSHTTPRequest

/** 客户端 | 登录 */
+ (void)loginWithParameters:(NSDictionary *)parameter isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;
/** 通用 | 发送短信验证码 */
+ (void)getSendCodeParameters:(NSDictionary *)parameter isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;

/** 上传图片 */
+ (void)uploadImagesWithImages:(NSArray *)images isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;

/** 上传视频 */
+ (void)uploadVideoWithVideo:(NSString *)videoPath isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;

/** 上传音频 */
+ (void)uploadAudioWithVideo:(NSString *)AudioPath isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;

/** 31. 通用 | OSS客户端STS凭证直传上传接口 */
+ (void)uploadFileParameters:(NSDictionary *)parameter isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;

/** 单图上传 */
+ (void)uploadImageWithImages:(UIImage *)image isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;

@end

NS_ASSUME_NONNULL_END
