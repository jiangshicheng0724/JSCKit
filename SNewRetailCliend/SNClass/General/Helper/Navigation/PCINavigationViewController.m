//
//  PCINavigationViewController.m
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2018/11/26.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "PCINavigationViewController.h"
#import "SUTabBarController.h"
#import "UIImage+RYImage.h"
//黄色导航栏
#define NavBarColor [UIColor colorWithRed:250/255.0 green:227/255.0 blue:111/255.0 alpha:1.0]

@interface PCINavigationViewController ()

@end

@implementation PCINavigationViewController



+ (void)load
{
    UIBarButtonItem *item=[UIBarButtonItem appearanceWhenContainedIn:self, nil ];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    dic[NSForegroundColorAttributeName]=[UIColor blackColor];
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    [bar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *dicBar=[NSMutableDictionary dictionary];
    
    dicBar[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    [bar setTitleTextAttributes:dic];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    return [super pushViewController:viewController animated:animated];
}


@end
