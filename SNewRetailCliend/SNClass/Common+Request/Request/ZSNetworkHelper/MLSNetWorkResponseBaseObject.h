//
//  MLSNetWorkResponseBaseObject.h
//  MoLiSangCar
//
//  Created by 班文政 on 2018/10/2.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MLSNetWorkResponseType) {
    MLSNetWorkResponseTypeUnknownError = -1,        // 未知错误
    MLSNetWorkResponseTypeSuccess = 1000 ,          //数据返回成功
    MLSNetWorkResponseTypeErrorLoseInternet,        //联网失败
    MLSNetWorkResponseTypeErrorTimeOut,             // 联网超时
    MLSNetWorkResponseTypeCacheData                 //返回缓存数据
};


@interface MLSNetWorkResponseBaseObject : NSObject

@property (nonatomic, assign) NSInteger flg;
@property (nonatomic, copy)   NSString *msg;
/** 数据响应状态 */
@property (nonatomic, assign) MLSNetWorkResponseType responseType;

@end

