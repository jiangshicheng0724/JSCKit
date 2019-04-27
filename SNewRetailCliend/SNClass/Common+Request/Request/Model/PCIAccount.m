//
//  PCIAccount.m
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2018/12/11.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "PCIAccount.h"

@implementation PCIAccount

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
//        _access_token = [NSString stringWithFormat:@"%@",dict[@"access_token"]];
        _user_id = [NSString stringWithFormat:@"%@",dict[@"user_id"]];
        _telephone = dict[@"telephone"];
        _avatar = dict[@"avatar"];
        _realname = dict[@"realname"];
        _gender = [dict[@"gender"] integerValue];
        _company = dict[@"company"];
        _staffer = dict[@"staffer"];
        _is_set_safepay = [dict[@"is_set_safepay"] boolValue];
        _is_set_password = [dict[@"is_set_password"] boolValue];
        _is_bind_bankcard = [dict[@"is_bind_bankcard"] boolValue];
        _is_bind_wechat = [NSString stringWithFormat:@"%@",dict[@"is_bind_wechat"]];
        _is_bind_alipay = [NSString stringWithFormat:@"%@",dict[@"is_bind_alipay"]];
        _verify_status = [dict[@"verify_status"] integerValue];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([PCIAccount class], &count);
    for (int index = 0; index < count; index ++) {
        Ivar ivar = ivars[index];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([PCIAccount class], &count);
        for (int index = 0; index < count; index ++) {
            Ivar ivar = ivars[index];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    return self;
}

@end
