//
//  PCITabBarController.m
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2018/11/26.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "SUTabBarController.h"
#import "RYNavigationViewController.h"

#import "SNHomeViewController.h"
#import "SNFindViewController.h"
#import "SNShopCarViewController.h"
#import "SNMineViewController.h"

@interface SUTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, assign) NSUInteger selectItem;//选中的item


@end

@implementation SUTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.selectItem = 0; //默认选中第一个
    self.delegate = self;
    
    // Do any additional setup after loading the view.
    [self addChildVc:[SNHomeViewController new] title:@"首页" image:@"hd_tab_icon_cqxt" selectedImage:@"shouye_tab_icon_cqxt"];
    [self addChildVc:[SNFindViewController new] title:@"找货源" image:@"shouye_tab_icon_hd" selectedImage:@"hd_content_tab_hd"];
    [self addChildVc:[SNShopCarViewController new] title:@"购物车" image:@"shouye_tab_icon_sc" selectedImage:@"scym_content_tab_sc_selected"];
    [self addChildVc:[SNMineViewController new] title:@"我的" image:@"shouye_tab_icon_wd" selectedImage:@"grzx_tab_icon_wd"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = SecondColor;
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = FirstColor;
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    RYNavigationViewController *nav = [[RYNavigationViewController alloc] initWithRootViewController:childVc];//侧滑
    
    // 添加为子控制器
    [self addChildViewController:nav];
}


@end
