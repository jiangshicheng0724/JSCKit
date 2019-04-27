//
//  ZSHTTPRequest.h
//  ZSNetworkHelper
//
//  Created by 班文政 on 2018/9/27.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 请求成功的block
 
 @param response 响应体数据
 */
typedef void(^ZSRequestSuccess)(id response);
/**
 请求失败的block
 */
typedef void(^ZSRequestFailure)(NSError *error);
/**
 请求失败的block
 */
typedef void(^ZSRequestProgress)(CGFloat progress);

@interface ZSHTTPRequest : NSObject
/** 通用 | 获取session信息 */
+ (void)GetSessionWithIsCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;

/** 通用 | OSS客户端STS凭证直传上传接口  */
+ (void)uploadDataOSSWithURL:(NSString *)URL parameters:(NSDictionary *)parameter isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;

//POST 请求的公共方法
+ (void)requestDataWithURL:(NSString *)URL parameters:(NSDictionary *)parameter isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;

//上传图片
+ (NSURLSessionTask *)uploadImagesParameters:(NSDictionary *)parameter  images:(NSArray <UIImage *>*)images success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;

//上传文件
+ (NSURLSessionTask *)uploadFileWithParameters:(NSDictionary *)parameters name:(NSString *)name filePath:(NSString *)filePath success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure;
@end


