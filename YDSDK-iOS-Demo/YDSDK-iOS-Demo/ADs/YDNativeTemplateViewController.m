//
//  YDNativeTemplateViewController.m
//  YDSDK-Demo
//
//  Created by Tychooo on 2017/4/5.
//  Copyright © 2017年 YodaMob. All rights reserved.
//

#import "YDNativeTemplateViewController.h"
#import "YDDemoMarco.h"
#import "YDHUD.h"
#import <YDSDK/YDSDK.h>

@interface YDNativeTemplateViewController () <YDNativeTemplateDelegate>

@property (nonatomic, strong) YDHUD *hud;

@end

@implementation YDNativeTemplateViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"NaTemplate";
    self.view.backgroundColor = YDViewControllerDefaultBackgroupColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = REQUEST_BUTTON_BAK_COLOR;
    button.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 50, UI_SCREEN_WIDTH, 50);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"Request Native Template Ad"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getNativeTemplateAD:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}

- (void)dealloc {
    debugMethod();
}

#pragma mark - Action & Target

- (void)getNativeTemplateAD:(UIButton *)button {
    
    CGFloat width = self.view.frame.size.width * 0.8;
    CGRect rect = CGRectMake((self.view.frame.size.width - width) * 0.5, 200, width, width / 1.9 + 40);
    
    [self showGetAdWithHUDTitle:@"开始请求 Native Template 广告"];
    
    __weak typeof(self) weakself = self;
    [[YDService shareManager] getNativeTemplateADswitchSlotId:nativeTemplateSlotId
                                                     delegate:self
                                                        frame:rect
                                              needCloseButton:YES
                                                       isTest:YES
                                                     keywords:nil
                                                      success:^(UIView *naTemplateView) {
        
        [weakself.view addSubview:naTemplateView];
        
    } failure:^(NSError *error) {
        debugLog(@"%@",error);
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

#pragma mark - YDNativeTemplate Delegate

- (void)YDNativeTemplateDidClick:(YDNativeTemplate *)native {
    debugMethod();
}

- (void)YDNativeTemplateClosed:(YDNativeTemplate *)native {
    debugMethod();
}

- (void)YDNativeTemplateHTML5Closed:(YDNativeTemplate *)native {
    debugMethod();
}

- (void)YDNativeTemplateWillLeaveApplication:(YDNativeTemplate *)native {
    debugMethod();
}

- (void)YDNativeTemplateDidIntoLandingPage:(YDNativeTemplate *)native {
    debugMethod();
}

- (void)YDNativeTemplateDidLeaveLandingPage:(YDNativeTemplate *)native {
    debugMethod();
}

@end
