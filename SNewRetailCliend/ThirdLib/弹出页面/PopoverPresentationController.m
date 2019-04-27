//
//  PopoverPresentationController.m
//  Transition
//
//  Created by WenhuaLuo on 17/3/17.
//  Copyright © 2017年 Nado. All rights reserved.
//

#import "PopoverPresentationController.h"

@interface PopoverPresentationController()

@property (nonatomic, strong) UIView *coverView;

//针对指定页面的处理
@property (nonatomic, strong) UIView *clearView;

@end

@implementation PopoverPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        
    }
    return self;
}

- (void)containerViewWillLayoutSubviews
{
    self.presentedView.frame = self.presentedFrame;
    
    [self.containerView insertSubview:self.clearView atIndex:0];
    [self.containerView insertSubview:self.coverView atIndex:1];
    
    self.coverView.frame = self.coverFrame;
    
    //针对指定页面的处理
    self.clearView.frame = self.containerView.frame;
    
}

- (void)setIsClose:(BOOL)isClose
{
    _isClose = isClose;
}


- (UIView *)coverView
{
    if (!_coverView) {
        
        UIView *view = [[UIView alloc]init];
        
        view.backgroundColor = [UIColor blackColor];
        
        view.alpha = 0.5;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
        
        [view addGestureRecognizer:tap];
        
        _coverView = view;
        
    }
    return _coverView;
}

- (UIView *)clearView
{
    if (!_clearView) {
        
        _clearView = [UIView viewWithBackgroundColor:ClearColor superView:nil];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
        
        [_clearView addGestureRecognizer:tap];
        
    }
    return _clearView;
}

- (void)close
{
    
    if (_popPresentBlock) {
        _popPresentBlock();
        
        if (_isClose) {
            
            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }else{
            
        }
    }
    
}

@end
