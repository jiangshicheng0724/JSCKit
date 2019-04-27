//
//  PCIAccount.h
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2018/12/11.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PCIAccount : NSObject

/**  token */
@property (nonatomic , copy) NSString  *access_token;
/**  用户ID */
@property (nonatomic , copy) NSString  *user_id;
/** 手机号码 */
@property (nonatomic , copy) NSString  *telephone;
/** 头像地址 */
@property (nonatomic , copy) NSString  *avatar;
/** 真实姓名 */
@property (nonatomic , copy) NSString  *realname;
/** 性别 0 未知 1 男 2 女 */
@property (nonatomic , assign) NSInteger  gender;
/** 公司名 */
@property (nonatomic , copy) NSString  *company;
/** 职务 */
@property (nonatomic , copy) NSString  *staffer;
/** 是否设置支付密码 */
@property (nonatomic , assign) BOOL  is_set_safepay;
/** 是否设置密码 */
@property (nonatomic , assign) BOOL  is_set_password;
/** 是否绑定银行卡(银行卡列表有查询到，就是true) */
@property (nonatomic , assign) BOOL  is_bind_bankcard;
/** 是否绑定微信 */
@property (nonatomic , copy) NSString*  is_bind_wechat;
/** 是否绑定支付宝 */
@property (nonatomic , copy) NSString*  is_bind_alipay;
/** 实名认证状态 0 未实名认证 1 认证中 2 认证通过 3 认证失败 */
@property (nonatomic , assign) NSInteger  verify_status;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
