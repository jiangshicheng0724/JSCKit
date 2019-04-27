//
//  PCISave.h
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2018/12/11.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PCIAccount;

@interface PCISave : NSObject


+ (void)setObject:(id)value forKey:(NSString *)defaultName;

+ (id)objectForKey:(NSString *)defaultName;


+ (PCIAccount *)account;

+ (void)save:(PCIAccount *)account;

@end


NS_ASSUME_NONNULL_END
