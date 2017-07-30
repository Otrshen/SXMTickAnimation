//
//  SXMTickAnimationBtn.h
//  SXMTickAnimation
//
//  Created by 申铭 on 2017/7/30.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXMTickAnimationBtn : UIButton

/**
 初始化方法

 @param tickViewWH 加载圈的宽高
 @return instancetype
 */
- (instancetype)initWithTickViewWH:(CGFloat)tickViewWH;

/**
 加载中

 @param text 提示语
 */
- (void)sxm_startLoadingWithText:(NSString *)text;

/**
 加载成功

 @param text 提示语
 */
- (void)sxm_loadSuccessWithText:(NSString *)text;

/**
 加载失败
 */
- (void)sxm_loadfailed;

@end
