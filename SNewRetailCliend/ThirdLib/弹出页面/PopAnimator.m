//
//  PopAnimator.m
//  Transition
//
//  Created by WenhuaLuo on 17/3/17.
//  Copyright © 2017年 Nado. All rights reserved.
//

#import "PopAnimator.h"
#import "PopoverPresentationController.h"

@interface PopAnimator()
{
    CGRect _presentedFrame;
    CGRect _coverFrame;
    CGPoint _startPoint;
    CGAffineTransform _startTransform;
    CGAffineTransform _endTransform;
    
    PopoverPresentationController *popoverPresentationController;
}

@end

@implementation PopAnimator

- (instancetype)initWithCoverFrame:(CGRect)coverFrame presentedFrame:(CGRect)presentedFrame startPoint:(CGPoint)startPoint startTransform:(CGAffineTransform)startTransform endTransform:(CGAffineTransform)endTransform
{
    if (self = [super init]) {
        _presentedFrame = presentedFrame;
        _coverFrame = coverFrame;
        _startPoint = startPoint;
        _startTransform = startTransform;
        _endTransform = endTransform;
    }
    return self;
}

- (void)setChangeCoverFrame:(CGRect)changeCoverFrame
{
    _coverFrame = changeCoverFrame;
}

- (void)setChangePresentFrame:(CGRect)changePresentFrame
{
    _presentedFrame = changePresentFrame;
}

- (void)setChangeStartTransform:(CGAffineTransform)changeStartTransform
{
    _startTransform = changeStartTransform;
}

- (void)setChangeEndTransform:(CGAffineTransform)changeEndTransform
{
    _endTransform = changeEndTransform;
}

- (void)setChangeStartPoint:(CGPoint)changeStartPoint
{
    _startPoint = changeStartPoint;
}

- (void)setIsClose:(BOOL)isClose
{
    _isClose = isClose;
}

//返回负责转场的控制器对象
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    //PopoverPresentationController *
    popoverPresentationController = [[PopoverPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    
    popoverPresentationController.coverFrame = _coverFrame;
    
    popoverPresentationController.isClose = _isClose;
    
    popoverPresentationController.presentedFrame = _presentedFrame;
    
    __weak typeof(self) weakSelf = self;
    
    popoverPresentationController.popPresentBlock = ^{
        
        if (weakSelf.animatorBlcok) {
            weakSelf.animatorBlcok();
        }
    };
    
    return popoverPresentationController;
    
}

//只要实现了以下方法，系统自带的动画就没有效果了，“所有”东西都需要程序员自己实现

/**
 告诉系统谁来负责model的展现动画
 presented：被展现视图
 presenting：发起的视图
 return：谁来负责
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

/**
 告诉系统谁来负责model的消失动画
 
 dismissed：被关闭的视图
 return：谁来负责
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}


#pragma mark  - UIViewControllerAnimatedTransitioning
/**
 动画时长
 transitionContext:上下文，里面保存了动画所需要的参数
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

/**
 告诉系统实现怎样的动画效果，展现｜消失都调用这个方法
 transitionContext:上下文，里面保存了动画所需要的参数
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //如果是展现，应该操作toview
    //如果是消失。应该操作fromview（toview没有值）
    
    UIView *toview = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    if (toview) {
        //（缩放:设置缩放比例）仅通过设置缩放比例就可实现视图扑面而来和缩进频幕的效果。
        toview.transform = _startTransform;//CGAffineTransformMakeScale(0.0, 1.0);
        
        //注意：一定要将视图添加到容器上
        [transitionContext.containerView addSubview:toview];
        
        //设置锚点，动画开始的点
        toview.layer.anchorPoint = _startPoint;//CGPointMake(1, 0.5);
        
        //执行动画
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            //清空transform
            toview.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            //动画结束之后一定要告诉系统，
            //如果不写会出现一些未知的错误
            [transitionContext completeTransition:YES];
        }];
        
    }
    else
    {
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromView.transform = _endTransform;//CGAffineTransformMakeScale(0.0001, 1.0);
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}



@end
