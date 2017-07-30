//
//  SXMTickAnimationView.h
//  SXMTickAnimation
//
//  Created by 申铭 on 2017/7/29.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXMTickAnimationView : UIView

/** 线条宽度 */
@property (nonatomic, assign) CGFloat lineWidth;
/** 线条颜色 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 开始加载动画
 */
- (void)sxm_startLoading;

/**
 结束加载动画
 */
- (void)sxm_finishedLoading;

@end
