//
//  YDInterstitialViewController.m
//  YDSDK-Demo
//
//  Created by Tychooo on 2017/4/5.
//  Copyright © 2017年 YodaMob. All rights reserved.
//

#import "YDInterstitialViewController.h"
#import "YDDemoMarco.h"
#import "YDHUD.h"
#import <YDSDK/YDSDK.h>

@interface YDInterstitialViewController () <YDInterstitialDelegate>

@property (nonatomic, assign) BOOL isSuccess;

@property (nonatomic, strong) YDHUD *hud;

@end

@implementation YDInterstitialViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isSuccess = NO;
    self.title = @"Interstitial";
    self.view.backgroundColor = YDViewControllerDefaultBackgroupColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 50, UI_SCREEN_WIDTH / 3.0, 50);
    button.backgroundColor = REQUEST_BUTTON_BAK_COLOR;
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"Request Ad"] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(getYDInterstitialAD:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *showAD = [UIButton buttonWithType:UIButtonTypeCustom];
    showAD.backgroundColor = [UIColor colorWithRed:118/255.0 green:218/255.0 blue:143/255.0 alpha:1];
    showAD.frame = CGRectMake(UI_SCREEN_WIDTH/3.0, UI_SCREEN_HEIGHT - 50, UI_SCREEN_WIDTH/3.0, 50);
    [showAD setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showAD setTitle:[NSString stringWithFormat:@"Show VC"] forState:UIControlStateNormal];
    [showAD addTarget:self action:@selector(showADWithViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:showAD];
    
    UIButton *vcShowAD = [UIButton buttonWithType:UIButtonTypeCustom];
    vcShowAD.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:235/255.0 alpha:1];
    vcShowAD.frame = CGRectMake(UI_SCREEN_WIDTH / 3.0 * 2, UI_SCREEN_HEIGHT - 50, UI_SCREEN_WIDTH / 3.0, 50);
    [vcShowAD setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vcShowAD setTitle:[NSString stringWithFormat:@"Show Normal"] forState:UIControlStateNormal];
    
    [vcShowAD addTarget:self action:@selector(showADByAddSubview:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:vcShowAD];
    
}

- (void)dealloc {
    debugMethod();
}

#pragma mark - Action & Target

- (void)getYDInterstitialAD:(UIButton *)button {
    
    [self showGetAdWithHUDTitle:@"开始请求插屏广告"];
    
     __weak typeof(self) weakself = self;
    [[YDService shareManager] perloadInterstitialWithSlotId:interstitilaSlotId
                                                   delegate:self
                                               isFullScreen:NO
                                                   keywords:nil
                                                     isTest:NO
                                                    success:^(UIView *interstitialView) {
        
        weakself.isSuccess = YES;
        [weakself.view addSubview:interstitialView];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)showADWithViewController:(UIButton *)button {
    
    if (self.isSuccess) {
        [[YDService shareManager] interstitialShowWithViewController];
        self.isSuccess = NO;
    } else {
        [self showGetAdWithHUDTitle:@"请先调用 RequestAd 请求广告"];
    }
}

- (void)showADByAddSubview:(UIButton *)button {
    
    if (self.isSuccess) {
        [[YDService shareManager] interstitialShow];
        self.isSuccess = NO;
    } else {
        [self showGetAdWithHUDTitle:@"请先调用 RequestAd 请求广告"];
    }
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

#pragma mark - YDInterstitialDelegate

- (void)YDInterstitialDidClosed:(YDInterstitial *)interstitialAd {
    debugMethod();
}

- (void)YDInterstitialDidClick:(YDInterstitial *)interstitialAd {
    debugMethod();
}

- (void)YDInterstitialWillLeaveApplication:(YDInterstitial *)interstitialAd {
    debugMethod();
}

- (void)YDInterstitialDidIntoLandingPage:(YDInterstitial *)interstitialAd {
    debugMethod();
}

- (void)YDInterstitialDidLeaveLandingPage:(YDInterstitial *)interstitialAd {
    debugMethod();
}

@end
