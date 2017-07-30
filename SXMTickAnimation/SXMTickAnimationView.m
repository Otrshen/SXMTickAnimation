//
//  SXMTickAnimationView.m
//  SXMTickAnimation
//
//  Created by 申铭 on 2017/7/29.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import "SXMTickAnimationView.h"

@interface SXMTickAnimationView ()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *animationLayer;
@property (nonatomic, assign) CGPoint arcCenter; // 圆心
@property (nonatomic, assign) CGFloat arcRadius; // 半径

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign) CGFloat progress;

@end

@implementation SXMTickAnimationView

@synthesize lineWidth = _lineWidth;

- (void)sxm_startLoading
{
    self.animationLayer.lineWidth = self.lineWidth;
    self.displayLink.paused = false;
}

- (void)sxm_finishedLoading
{
    self.displayLink.paused = true;
    [self darwTick];
}

// 转圈动画
- (void)displayLinkAction
{
    _progress += [self speed];
    
    if (_progress >= 1) {
        _progress = 0;
    }
    [self updateAnimationLayer];
}

-(void)updateAnimationLayer{
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 + _progress * (M_PI * 2);
    
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - _progress) / 0.25;
        _startAngle = -M_PI_2 + progress1 * (M_PI * 2);
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:_startAngle endAngle:_endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    
    _animationLayer.path = path.CGPath;
}

- (CGFloat)speed{
    if (_endAngle > M_PI) {
        return 0.45 / 60.0f;
    }
    return 3 / 60.0f;
}

// 对勾动画
- (void)darwTick
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:-M_PI / 2 endAngle:M_PI * 2 clockwise:YES];
    
    CGFloat a = _animationLayer.bounds.size.width;
    [path moveToPoint:CGPointMake(a * 2.7 / 10, a * 5.4 / 10)];
    [path addLineToPoint:CGPointMake(a * 4.5 / 10, a * 7 / 10)];
    [path addLineToPoint:CGPointMake(a * 7.8 / 10, a * 3.8 /10)];
    
    _animationLayer.path = path.CGPath;
    
    // 动画设置
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 1;
    [animation setValue:@"checkAnimation" forKey:@"animationName"];
    [_animationLayer addAnimation:animation forKey:nil];
    
    [self.layer addSublayer:_animationLayer];
}

- (CGPoint)arcCenter
{
    return CGPointMake(self.animationLayer.bounds.size.width / 2.0f, self.animationLayer.bounds.size.height / 2.0f);
}

- (CGFloat)arcRadius
{
    return self.animationLayer.bounds.size.width / 2.0f - _lineWidth / 2.0f;
}

#pragma mark - lazy

- (CAShapeLayer *)animationLayer
{
    if (!_animationLayer) {
        _animationLayer = [[CAShapeLayer alloc] init];
        _animationLayer.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _animationLayer.position = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0);
        _animationLayer.fillColor = [UIColor clearColor].CGColor;
        _animationLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:_animationLayer];
    }
    return _animationLayer;
}

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _displayLink.paused = true;
    }
    return _displayLink;
}

- (CGFloat)lineWidth
{
    return _lineWidth == 0 ? 4 : _lineWidth;
}

#pragma mark - setter

// 重写frame方法
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.animationLayer.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.animationLayer.position = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0);
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        self.animationLayer.lineWidth = _lineWidth;
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    if (_lineColor != lineColor) {
        _lineColor = lineColor;
        self.animationLayer.strokeColor = _lineColor.CGColor;
    }
}

@end
