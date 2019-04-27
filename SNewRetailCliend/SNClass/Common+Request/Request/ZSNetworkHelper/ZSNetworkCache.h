//
//  ZSNetworkCache.h
//  ZSNetworkHelper
//
//  Created by 班文政 on 2018/9/27.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>
// 过期提醒
#define PPDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#pragma mark - 网络数据缓存类
@interface ZSNetworkCache : NSObject


/**
 异步缓存网络数据，根据请求的URL与parameters做KEY存储数据，这样就鞥

 @param httpData            服务器返回的数据
 @param URL                 请求的URL地址
 @param parameters          请求的参数
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(id)parameters;


/**
 根据请求的URL与parameters同步取出缓存数据

 @param URL             请求的URL
 @param parameters      请求的参数
 @return                缓存的服务器数据
 */
+ (id)httpCacheForURL:(NSString *)URL parameters:(id)parameters;

/**
 获取网络缓存

 @return 网络缓存总大小 bytes（字节）
 */
+ (NSInteger)getAllHttpCacheSize;

/**
 删除所有网络缓存
 */
+ (void)removeAllHttpCache;

@end

