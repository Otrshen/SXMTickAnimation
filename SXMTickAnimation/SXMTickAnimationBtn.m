//
//  SXMTickAnimationBtn.m
//  SXMTickAnimation
//
//  Created by 申铭 on 2017/7/30.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import "SXMTickAnimationBtn.h"
#import "SXMTickAnimationView.h"

#define btnW self.bounds.size.width
#define btnH self.bounds.size.height

@interface SXMTickAnimationBtn ()
@property (nonatomic, copy) NSString *originalTitle; // 原标题
@property (nonatomic, strong) SXMTickAnimationView *tickView;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, assign) CGFloat tickViewWH;
@end

@implementation SXMTickAnimationBtn

- (instancetype)init
{
    return [self initWithTickViewWH:20.0f];
}

- (instancetype)initWithTickViewWH:(CGFloat)tickViewWH
{
    if (self = [super init]) {
        _tickViewWH = tickViewWH;
    }
    return self;
}

- (void)sxm_startLoadingWithText:(NSString *)text
{
    self.userInteractionEnabled = NO;
    
    // 保留原始标题
    self.originalTitle = self.titleLabel.text;
    // 隐藏btn标题
    [self setTitle:@"" forState:UIControlStateNormal];
    
    self.loadingView = [[UIView alloc] init];

    CGFloat tickViewY = (btnH - _tickViewWH) / 2; // 加载圈高度居中
    self.tickView.frame = CGRectMake(0, tickViewY, _tickViewWH, _tickViewWH);
    [self.tickView sxm_startLoadingWithType:SXMTickAnimationEaseOut];

    self.textLabel.text = text; // 设置提示语
    [self calcLoadingViewFrame:text];
    
    [self.loadingView addSubview:_tickView];
    [self.loadingView addSubview:_textLabel];
    
    [self addSubview:self.loadingView];
}

- (void)sxm_loadSuccessWithText:(NSString *)text
{
    self.textLabel.text = text;
    [self calcLoadingViewFrame:text];
    [self.tickView sxm_finishedLoading];
}

// 加载失败还原btn的样式
- (void)sxm_loadfailed
{
    self.userInteractionEnabled = YES;
    [self.loadingView removeFromSuperview];
    [self setTitle:self.originalTitle forState:UIControlStateNormal];
}

- (void)calcLoadingViewFrame:(NSString *)text
{
    // 提示语的位置
    CGSize fontSize = [text sizeWithAttributes:@{NSFontAttributeName:self.textLabel.font}];
    _textLabel.frame = CGRectMake(_tickViewWH + 5, (btnH - fontSize.height) / 2, fontSize.width, fontSize.height);
    
    // LoadingView的位置
    CGFloat loadingViewW = _tickViewWH + fontSize.width + (2 * _tickView.lineWidth);
    CGFloat loadingViewX = (btnW - loadingViewW) / 2;
    _loadingView.frame = CGRectMake(loadingViewX, 0, loadingViewW, btnH);
}

#pragma mark - lazy

- (SXMTickAnimationView *)tickView
{
    if (!_tickView) {
        _tickView = [[SXMTickAnimationView alloc] init];
        _tickView.lineColor = self.titleLabel.textColor;
        _tickView.lineWidth = 2.5f;
    }
    return _tickView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = self.titleLabel.font;
        _textLabel.textColor = self.titleLabel.textColor;
    }
    return _textLabel;
}

- (void)dealloc
{
    NSLog(@"dealloc__btn");
}

@end
