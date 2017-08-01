//
//  SXMTickAnimationView.h
//  SXMTickAnimation
//
//  Created by 申铭 on 2017/7/29.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SXMTickAnimation) {
    /** 匀速 */
    SXMTickAnimationLinear,
    /** 快进慢出 */
    SXMTickAnimationEaseOut,
};

@interface SXMTickAnimationView : UIView

/** 线条宽度 */
@property (nonatomic, assign) CGFloat lineWidth;
/** 线条颜色 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 开始加载动画
 */
- (void)sxm_startLoadingWithType:(SXMTickAnimation)type;

/**
 结束加载动画
 */
- (void)sxm_finishedLoading;

// 销毁函数

@end
