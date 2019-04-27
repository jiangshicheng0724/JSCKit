//
//  PCISave.m
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2018/12/11.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "PCISave.h"
#import "PCIAccount.h"

#define kMessagePath(path) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:path]

@implementation PCISave

+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    //存储数据
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    //立刻同步
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)objectForKey:(NSString *)defaultName
{
    //利用NSUserDefaults，就能直接访问软件的偏好设置（Lobarary/Preferences）
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}


/**
 *  存储帐号信息
 */
+ (void)save:(PCIAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:kMessagePath(@"account.plist")];
}

/**
 *  获得上次存储的帐号
 *
 */
+ (PCIAccount *)account
{
    PCIAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kMessagePath(@"account.plist")];
    
    return account;
}

@end
