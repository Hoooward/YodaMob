//
//  YDBannerViewController.m
//  YDSDK-Demo
//
//  Created by Tychooo on 2017/4/5.
//  Copyright © 2017年 YodaMob. All rights reserved.
//

#import "YDBannerViewController.h"
#import "YDDemoMarco.h"
#import <YDSDK/YDSDK.h>
#import "YDHUD.h"

@interface YDBannerViewController () <YDBannerDelegate>

@property (nonatomic, strong) YDHUD *hud;

@end

@implementation YDBannerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Banner";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:1 alpha:1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    
    [button setTitle:@"Request Banner Ad" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor: REQUEST_BUTTON_BAK_COLOR];
    [button addTarget:self action:@selector(getYDBannderYD:) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)dealloc {
    debugMethod();
}

- (void)getYDBannderYD:(UIButton *)button {
    
    [self showGetAdWithHUDTitle:@"开始请求 Banner 广告"];
    
    CGRect bannerRect = CGRectMake(0, 150, [[UIScreen mainScreen] bounds].size.width, 50);
    
    __weak typeof(self) weakself = self;
    [[YDService shareManager] getBannerADswitchSlotId:bannerSlotId
                                             delegate:self
                                                frame:bannerRect
                                      needCloseButton:YES
                                             keywords:nil
                                               isTest:YES
                                              success:^(UIView *bannerView) {
                                                  
        
                                                  [weakself.view addSubview:bannerView];
                                                  
//                                                  NSAssert( 0 != 0, @"aaaa");
                                               
                                                  
                                                  
                                                  
                                              } failure:^(NSError *error) {
                                                  
                                              }];
}

- (void)done {
    [self.hud hide];
}

- (void)showGetAdWithHUDTitle:(NSString *)title {
    
    self.hud = [[YDHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    self.hud.labelText = title;
    [self.hud show];
    [self performSelector:@selector(done) withObject:nil afterDelay:0.5];
}

#pragma mark - YDBannderDelegate

- (void)YDBannerClosed:(YDBanner *)banner {

    debugMethod();
}

- (void)YDBannerDidClick:(YDBanner *)banner {
    debugMethod();
}

- (void)YDBannerHTML5Closed:(YDBanner *)banner {
    debugMethod();
}

- (void)YDBannerWillLeaveApplication:(YDBanner *)banner {
    debugMethod();
}

- (void)YDBannerDidIntoLandingPage:(YDBanner *)banner {
    debugMethod();
}

- (void)YDBannerDidLeaveLandingPage:(YDBanner *)banner {
    debugMethod();
}

@end
