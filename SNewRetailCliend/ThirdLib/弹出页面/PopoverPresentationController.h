//
//  PopoverPresentationController.h
//  Transition
//
//  Created by WenhuaLuo on 17/3/17.
//  Copyright © 2017年 Nado. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopPresentBlock)(void);

@interface PopoverPresentationController : UIPresentationController


@property (nonatomic, assign) CGRect presentedFrame;

//黑色有透明度的view的尺寸
@property (nonatomic, assign) CGRect coverFrame;

//点击背景是否关闭  
@property (nonatomic, assign) BOOL isClose;

//改变黑色有透明度的view的尺寸
//@property (nonatomic, assign) CGRect changeCoverFrame;

//点击非弹出框页面隐藏的时候调用，
@property (nonatomic, copy) PopPresentBlock popPresentBlock;

@end
