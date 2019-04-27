//
//  PopAnimator.h
//  Transition
//
//  Created by WenhuaLuo on 17/3/17.
//  Copyright © 2017年 Nado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AnimatorBlcok)(void);

@interface PopAnimator : NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

//@property (nonatomic, assign) CGRect presentedFrame;

//是否是提醒弹出框
//@property (nonatomic, assign) BOOL isPopAlert;

/**
 初始化并传参数
 
 @param coverFrame 黑色有透明度的view的尺寸
 @param presentedFrame 弹出页面的位置
 @param startPoint 动画开始的锚点
 @param startTransform 动画开始的缩放比例
 @param endTransform 动画结束的缩放比例
 @return 转场动画
 */
- (instancetype)initWithCoverFrame:(CGRect)coverFrame presentedFrame:(CGRect)presentedFrame startPoint:(CGPoint)startPoint startTransform:(CGAffineTransform)startTransform endTransform:(CGAffineTransform)endTransform;

//点击非弹出框页面隐藏的时候调用，
@property (nonatomic, copy) AnimatorBlcok animatorBlcok;

@property (nonatomic, assign) CGRect changeCoverFrame;

@property (nonatomic, assign) CGRect changePresentFrame;

/**
 点击背景是否消失
 */
@property (nonatomic, assign) BOOL isClose;


@property (nonatomic, assign) CGAffineTransform changeStartTransform;
@property (nonatomic, assign) CGAffineTransform changeEndTransform;
@property (nonatomic, assign) CGPoint changeStartPoint;

@end
