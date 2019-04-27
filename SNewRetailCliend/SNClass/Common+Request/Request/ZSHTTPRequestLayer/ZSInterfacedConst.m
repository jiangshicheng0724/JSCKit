//
//  ZSInterfacedConst.m
//  ZSNetworkHelper
//
//  Created by 班文政 on 2018/9/27.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "ZSInterfacedConst.h"

#if DevelopSever
/** 接口前缀-开发服务器*/
NSString *const kApiPrefix = @"https://www.chaoqick.com/api/";
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const kApiPrefix = @"https://www.chaoqick.com/api/";
#elif ProductSever
/** 接口前缀-生产服务器*/
NSString *const kApiPrefix = @"https://www.chaoqick.com/api/";
#endif

/**  获取session信息 */
NSString *const kGetSession =                       @"user/session";
/** 通用 | 统一上传接口  */
NSString *const kUpLoad =                           @"api/file/upload";
/** 通用 | 登录  */
NSString *const kLogin =                             @"api/kLogin";
/** 通用 | oss直传 */
NSString *const kStsFile =                           @"api/kStsFile";
/** 通用 | 发送验证码 */
NSString *const kSendMessage =                           @"api/kSendMessage";
