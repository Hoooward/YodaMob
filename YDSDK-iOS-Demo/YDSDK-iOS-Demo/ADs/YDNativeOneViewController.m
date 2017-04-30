//
//  YDNativeOneViewController.m
//  YDSDK-Demo
//
//  Created by Tychooo on 2017/4/5.
//  Copyright © 2017年 YodaMob. All rights reserved.
//

#import "YDNativeOneViewController.h"
#import "YDDemoMarco.h"
#import "CustomNativeView.h"
#import "YDHUD.h"
#import <YDSDK/YDSDK.h>

@interface YDNativeOneViewController () <YDNativeDelegate>

@property (nonatomic, strong) CustomNativeView *nativeView;

@property (nonatomic, strong) YDHUD *hud;

@end

@implementation YDNativeOneViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"NativeAD";
    self.view.backgroundColor = YDViewControllerDefaultBackgroupColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = REQUEST_BUTTON_BAK_COLOR;
    button.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 50, UI_SCREEN_WIDTH, 50);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"Request Native Ad"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getOneNativeAD:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.frame = CGRectMake(0, UI_SCREEN_HEIGHT - 100, UI_SCREEN_WIDTH, 50);
    closeButton.backgroundColor = CLOSE_BUTTON_BAK_COLOR;
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeADView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:closeButton];
}

#pragma mark - Action & Target

- (void)getOneNativeAD:(UIButton *)button {
    
    [self showGetAdWithHUDTitle:@"开始请求 Native 广告"];
    
    @weakify(self)
    [[YDService shareManager] getNativeElementsADswitchSlotId:OneNativeSlotId delegate:self imageWidthHightRate:YDImageWHRateOneToOne keywords:nil isTest:NO success:^(YDNativeElementAdModel *nativeModel) {
       @strongify(self)
        
        self.nativeView = [[CustomNativeView alloc] initWithFrame:CGRectMake(30, 130, UI_SCREEN_WIDTH - 60, (UI_SCREEN_WIDTH - 60) / 1.9 + 20)];
        
        self.nativeView.delegate = self;
        
        self.nativeView.nativeModel = nativeModel;
        
        self.nativeView.titleLable.text = nativeModel.title;
        
        [self getImageFromURL:nativeModel.icon img:^(UIImage *ig) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.nativeView.iconImage.image = ig;
            });
        }];
        
        [self getImageFromURL:nativeModel.image img:^(UIImage *ig) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.nativeView.imageImage.image = ig;
            });
        }];
        
        self.nativeView.descLable.text = nativeModel.desc;
        [self.nativeView.button setTitle:nativeModel.button forState:UIControlStateNormal];
        self.nativeView.starLable.text = [NSString stringWithFormat:@"%f",nativeModel.star];
        self.nativeView.logoImage.image = nativeModel.ADsignImage;
        
        [self.view addSubview:self.nativeView];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)dealloc
{
    debugMethod();
}

-(void)getImageFromURL:(NSString *)fileURL img:(void(^)(UIImage *ig))image
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage * result;
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        result = [UIImage imageWithData:data];
        image(result);
    });
}

- (void)closeADView:(UIButton *)button {
    
    [self.nativeView removeFromSuperview];
    self.nativeView.delegate = nil;
    self.nativeView.nativeModel = nil;
    self.nativeView = nil;
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

#pragma mark - YDNative Delegate

- (void)YDNativeAdDidClick:(UIView *)nativeAd {
    debugMethod();
}

- (void)YDNativeAdDidIntoLandingPage:(UIView *)nativeAd {
    debugMethod();
}

- (void)YDNativeAdDidLeaveLandingPage:(UIView *)nativeAd {
    debugMethod();
}

- (void)YDNativeAdWillLeaveApplication:(UIView *)nativeAd {
    debugMethod();
}


@end
