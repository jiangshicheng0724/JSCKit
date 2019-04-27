//
//  ZSInterfacedConst.h
//  ZSNetworkHelper
//
//  Created by 班文政 on 2018/9/27.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever 0
#define TestSever    1
#define ProductSever 0

/** 接口前缀-开发服务器*/
UIKIT_EXTERN NSString *const kApiPrefix;

#pragma mark - 详细接口地址

/** 通用 | 获取session信息 */
UIKIT_EXTERN NSString *const kGetSession;
/** 通用 | 统一上传接口  */
UIKIT_EXTERN NSString *const kUpLoad;
/** 通用 |  登录  */
UIKIT_EXTERN NSString *const kLogin;
/** 通用 | oss直传   */
UIKIT_EXTERN NSString *const kStsFile;
/** 通用 | 发送验证码  */
UIKIT_EXTERN NSString *const kSendMessage;

