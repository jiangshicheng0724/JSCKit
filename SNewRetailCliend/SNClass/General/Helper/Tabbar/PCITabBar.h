//
//  PCITabBar.h
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2018/11/26.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCITabBar;

@protocol PCITabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(PCITabBar *)tabBar;
@end

@interface PCITabBar : UITabBar

/** tabbar的代理 */
@property (nonatomic, weak) id<PCITabBarDelegate> myDelegate ;

@end

