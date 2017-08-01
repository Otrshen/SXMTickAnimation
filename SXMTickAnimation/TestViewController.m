//
//  TestViewController.m
//  SXMTickAnimation
//
//  Created by 申铭 on 2017/7/30.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import "TestViewController.h"
#import "SXMTickAnimationView.h"
#import "SXMTickAnimationBtn.h"

@interface TestViewController ()
@property (nonatomic, strong) SXMTickAnimationView *tick;
@property (nonatomic, strong) SXMTickAnimationView *tick1;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, strong) SXMTickAnimationBtn *sxmbtn;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tick = [[SXMTickAnimationView alloc] init];
    _tick.frame = CGRectMake(0, 0, 100, 100);
    _tick.lineWidth = 8;
    _tick.lineColor = [UIColor blueColor];
    _tick.center = self.view.center;
//    _tick.backgroundColor = [UIColor greenColor];
    [_tick sxm_startLoadingWithType:SXMTickAnimationLinear];
    [self.view addSubview:_tick];
    
    SXMTickAnimationBtn *btn = [[SXMTickAnimationBtn alloc] initWithTickViewWH:21];
    btn.frame = CGRectMake(100, 100, 150, 55);
    btn.backgroundColor = [UIColor blueColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:@"支付" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clicksxmBtn) forControlEvents:UIControlEventTouchUpInside];
    _sxmbtn = btn;
}

- (void)clicksxmBtn
{
    [_sxmbtn sxm_startLoadingWithText:@"正在支付..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_sxmbtn sxm_loadSuccessWithText:@"支付成功"];
    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_sxmbtn sxm_loadfailed];
//    });
}

- (IBAction)finish:(id)sender {
    [self.tick sxm_finishedLoading];
}

- (void)dealloc
{
    NSLog(@"TestViewController_dealloc");
}

@end
