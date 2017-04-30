<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

![](http://7xrfzx.com1.z0.glb.clouddn.com/logo+name_4.png)


## YodaMob - Mobile Advertising Integration Platform
[![Build Status](https://travis-ci.org/meolu/walle-web.svg?branch=master)]()

We mediate the most popular mobile Ad networks to ensure high fill rate and high eCPM. Our    lightweight SDK, Flexible API and JS Tag for all developers, turn non-paying users into your  outstanding income source.

 [Home Page](http://www.yodamob.com)

We know building great apps takes time. So we have the easiest way for integration. Let us get started now.

## iOS SDK Guide 


- [SDK Basic API reference](#sdk-basic-api-reference)
  - [Get Banner Ad view](#get-banner-ad-view)
    - [Banner Delegate](#banner-delegate)
    - [Bannder Demo](#bannder-demo)
  - [Get Interstitial Ad View](#get-interstitial-ad-view)
    - [Interstitial Delegate](#interstitial-delegate)
    - [Interstitial Demo](#interstitial-demo)
  - [Get Native Template Ad View](#get-native-template-ad-view)
    - [Native Template Delegate](#native-template-delegate)
    - [Native Template Demo](#native-template-demo)
  - [Get Native Elements Ad](#get-native-elements-ad)
    - [Native Elements Delegate](#native-elements-delegate)
    - [Native Elements Demo](#native-elements-demo)
- [How To Apply Facebook & Admob Advertisement](#how-to-apply-facebook--admob-advertisement)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->



## SDK Download And Setup

* According to the [How To Apply Facebook & Admob Advertisement](#how-to-apply-facebook--admob-advertisement) import relevant Framework.
 
  you can import the following three items directly.
  
  ```
  FBAudienceNetwork.framework
  GoogleMobileAds.framework
  YDSDK.framework
  ```

* Select your target add a static link to `Build Settings` -> `Other Linker Flags` enter:  `$(OTHER_LDFLAGS) -ObjC`.

![屏幕快照 2017-04-30 下午3.03.18](http://7xrfzx.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-04-30%20%E4%B8%8B%E5%8D%883.03.18.png)

*  Select your target In `Build Phases` -> `Link Binary With Libraries` add `AdSupport.framework` and `libsqlite3.0.tbd`.

![屏幕快照 2017-04-30 下午3.09.04](http://7xrfzx.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-04-30%20%E4%B8%8B%E5%8D%883.09.04.png)

* In `Info.plist` file, add the `NSAppTransportSecurity` , the type for Dictionary,  In `NSAppTransportSecurity` added the `NSAllowsArbitraryLoads` the Boolean, setting the YES.

  ![屏幕快照 2017-04-30 下午3.11.40-w500](http://7xrfzx.com1.z0.glb.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-04-30%20%E4%B8%8B%E5%8D%883.11.40.png)


* Import the hearder file `#import <CTSDK/CTService.h>`

## SDK Basic API reference

### Get Banner Ad view

```objc
/**
 
 @param slot_id : cloud tech banner Ad Id.
 @param delegate : set delegate of Ad event.
 @param frame : set Ad view's frame.
 @param isNeedButton : show close button at the top-right corner of the advertisement.
 @param keywords : set Ad keywords or nil.
 @param isTest : use test advertisement or not.
 @param success : the request is successful block, return interstitial Ad view.
 @param failure : the request if failed block, return error.
 */
- (void)getBannerADswitchSlotId:(NSString *)slot_id
                       delegate:(id)delegate
                          frame:(CGRect)frame
                needCloseButton:(BOOL)isNeedButton
                       keywords:(NSString *)keywords
                         isTest:(BOOL)isTest
                        success:(void (^)(UIView * bannerView))success
                        failure:(void (^)(NSError *error))failure;
                        
```

#### Banner Delegate

```objc

@protocol YDBannerDelegate <NSObject>

@optional

/// User click the advertisement.
- (void)YDBannerDidClick:(YDBanner *)banner;

/// Advertisement landing page will show.
- (void)YDBannerDidIntoLandingPage:(YDBanner *)banner;

/// User left the advertisement landing page.
- (void)YDBannerDidLeaveLandingPage:(YDBanner *)banner;

/// User close the advertisement.
- (void)YDBannerClosed:(YDBanner *)banner;

/// Leave Application.
- (void)YDBannerWillLeaveApplication:(YDBanner *)banner;

/// User close the HTML5.
- (void)YDBannerHTML5Closed:(YDBanner *)banner;

@end                     
```


#### Bannder Demo

```objc
CGRect bannerRect = CGRectMake(0, 150, [[UIScreen mainScreen] bounds].size.width, 50);
    
__weak typeof(self) weakself = self;
[[YDService shareManager] getBannerADswitchSlotId:bannerSlotId
                                             delegate:self
                                                frame:bannerRect
                                      needCloseButton:YES
                                             keywords:nil
                                               isTest:NO
                                              success:^(UIView *bannerView) {
                                                  
        
    [weakself.view addSubview:bannerView];
        
} failure:^(NSError *error) {
        
}];

```

### Get Interstitial Ad View

```objc
/**

 @param slot_id : cloud teck intersitital Ad Id.
 @param delegate : set delegate of Ad event.
 @param isFull : if is screen, set YES, else set NO.
 @param keywords : aaaasss.
 @param isTest : use test advertisement or not.
 @param success : the request is successful block, return interstitial Ad view.
 @param failure : the request if failed block, return error.
 */
- (void)perloadInterstitialWithSlotId:(NSString *)slot_id
                             delegate:(id)delegate
                         isFullScreen:(BOOL)isFull
                             keywords:(NSString *)keywords
                               isTest:(BOOL)isTest
                              success:(void (^)(UIView *interstitialView))success
                              failure:(void (^)(NSError *error))failure;
                              
                              
/// Show interstitial advertisement.
/// Request success, then call this method show Ad view on current root view controller's view.
- (BOOL)interstitialShow;

/// Show interstitial advertisement.
/// Request success, the call this method show advertisement by present view controller style.
- (BOOL)interstitialShowWithViewController;
```

#### Interstitial Delegate

```objc

@protocol YDInterstitialDelegate <NSObject>

@optional

/// User click the advertisement.
- (void)YDInterstitialDidClick:(YDInterstitial *)interstitialAd;

/// User close the advertisement.
- (void)YDInterstitialDidClosed:(YDInterstitial *)interstitialAd;

/// Advertisement landing page will show.
- (void)YDInterstitialDidIntoLandingPage:(YDInterstitial *)interstitialAd;

/// User left the advertisement landing page.
- (void)YDInterstitialDidLeaveLandingPage:(YDInterstitial *)interstitialAd;

/// Leave App.
- (void)YDInterstitialWillLeaveApplication:(YDInterstitial *)interstitialAd;

@end
```

#### Interstitial Demo

```objc
 __weak typeof(self) weakself = self;
[[YDService shareManager] perloadInterstitialWithSlotId:interstitilaSlotId
                                                   delegate:self
                                               isFullScreen:NO
                                                   keywords:nil
                                                     isTest:YES
                                                    success:^(UIView *interstitialView) {
        
     weakself.isSuccess = YES;
    [weakself.view addSubview:interstitialView];
        
} failure:^(NSError *error) {
     NSLog(@"%@",error);
}];
    
- (void)showADWithViewController:(UIButton *)button {
    
    if (self.isSuccess) {
        [[YDService shareManager] interstitialShowWithViewController];
        self.isSuccess = NO;
    } else 
}

- (void)showADByAddSubview:(UIButton *)button {
    
    if (self.isSuccess) {
        [[YDService shareManager] interstitialShow];
        self.isSuccess = NO;
    } 
}
```

### Get Native Template Ad View

```objc
/**
 You can upload custom html5 template on PUBYODA website

 @param slot_id cloud tech NativeTemlate Ad Id
 @param delegate set delegate of Ad event.
 @param frame set Ad view's frame.
 @param isNeedButton : show close button at the top-right corner of the advertisement.
 @param keywords : set Ad keywords.
 @param isTest : use test advertisement or not.
 @param success : the request is successful block, return interstitial Ad view.
 @param failure : the request if failed block, return error.
 */
- (void)getNativeTemplateADswitchSlotId:(NSString *)slot_id
                           delegate:(id)delegate
                              frame:(CGRect)frame
                    needCloseButton:(BOOL)isNeedButton
                             isTest:(BOOL)isTest
                           keywords:(NSString *)keywords
                            success:(void (^)(UIView *naTemplateView))success
                            failure:(void (^)(NSError *error))failure;
                            
```
#### Native Template Delegate

```objc

@protocol YDNativeTemplateDelegate <NSObject>

@optional

/// User click the advertisement.
- (void)YDNativeTemplateDidClick:(YDNativeTemplate *)native;

/// Advertisement landing page will show.
- (void)YDNativeTemplateDidIntoLandingPage:(YDNativeTemplate *)native;

/// User left the advertisement landing page.
- (void)YDNativeTemplateDidLeaveLandingPage:(YDNativeTemplate *)native;

/// User close the advertisement.
- (void)YDNativeTemplateClosed:(YDNativeTemplate *)native;

/// Leave App.
- (void)YDNativeTemplateWillLeaveApplication:(YDNativeTemplate *)native;

/// User close the HTML5.
- (void)YDNativeTemplateHTML5Closed:(YDNativeTemplate *)native;

@end

```

#### Native Template Demo

```objc
CGFloat width = self.view.frame.size.width * 0.8;
CGRect rect = CGRectMake((self.view.frame.size.width - width) * 0.5, 200, width, width / 1.9 + 40);
    
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

```

### Get Native Elements Ad

```objc

/**

 @param slot_id cloud tech Native Ad Id
 @param delegate set delgate of Ad event
 @param WHRate set Image Rate
 @param keywords set Ad keywords
 @param isTest use test advertisement or not.
 @param success The request is successful Block, return Native Element Ad
 @param failure The request failed Block, retuen error
 */
- (void)getNativeElementsADswitchSlotId:(NSString *)slot_id
                       delegate:(id)delegate
            imageWidthHightRate: (YDImageWidthHeightRate)WHRate
                       keywords:(NSString *)keywords
                         isTest:(BOOL)isTest
                        success:(void (^)(YDNativeElementAdModel *))success
                        failure:(void (^)(NSError *))failure;


```

#### Native Elements Delegate

```objc

@protocol YDNativeDelegate <NSObject>

@optional

/// User click the advertisement.
- (void)YDNativeAdDidClick:(UIView *)nativeAd;

/// Advertisement landing page will show.
- (void)YDNativeAdDidIntoLandingPage:(UIView *)nativeAd;

/// User left the advertisement landing page.
- (void)YDNativeAdDidLeaveLandingPage:(UIView *)nativeAd;

/// Leave App.
- (void)YDNativeAdWillLeaveApplication:(UIView *)nativeAd;

@end
```

#### Native Elements Demo

First, you should create an inheritance in `YDNativeView` , and carries on the controls within the view layout.

```objc 
#import <YDSDK/YDSDK.h>

@interface CustomNativeView : YDNativeView

@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIImageView *imageImage;
@property (nonatomic, strong) UILabel *descLable;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *starLable;

@end
```

layout:

```objc
#import "CustomNativeView.h"

@implementation CustomNativeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imageImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width / 1.9)];
        self.logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 60, 0, 60, 16)];//广告标识
        self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(7, frame.size.width / 1.9 - 23, 40, 40)];//icon
        self.iconImage.layer.cornerRadius = 6.5;
        [self.iconImage.layer setMasksToBounds:YES];
        self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(55, frame.size.width / 1.9 - 20, frame.size.width-200, 20)];//标题
        self.titleLable.font = [UIFont systemFontOfSize:14];
        self.titleLable.textColor = [UIColor whiteColor];
        self.button.frame = CGRectMake(frame.size.width-60, frame.size.width / 1.9 - 23, 60, 20);
        self.button.titleLabel.font = [UIFont systemFontOfSize:14];
        self.descLable = [[UILabel alloc]initWithFrame:CGRectMake(55, frame.size.width / 1.9 - 3 , frame.size.width - 55, 20)];
        self.descLable.textColor = [UIColor blackColor];
        self.descLable.font = [UIFont systemFontOfSize:14];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.imageImage];
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.width / 1.9 - 23, frame.size.width, 43)];
        back.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];;
        [self addSubview:back];
        [self addSubview:self.logoImage];
        [self addSubview:self.titleLable];
        [self addSubview:self.iconImage];
        [self addSubview:self.descLable];
        [self addSubview:self.button];
        
    }
    
    return self;
}

- (void)dealloc {
//    debugMethod();
}

@end
```

Then call to The method to load ads:

```objc
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
```



## How To Apply Facebook & Admob Advertisement

* [Facebook Ad SDK inset description.](https://developers.facebook.com/docs/audience-network)
* [Google Admob Ad SDK insert description.](https://firebase.google.com/docs/ios/setup)


