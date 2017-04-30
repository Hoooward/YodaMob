//
//  ViewController.m
//  YDSDK-Demo
//
//  Created by Tychooo on 2017/3/18.
//  Copyright © 2017年 YodaMob. All rights reserved.
//

#import "RootViewController.h"
#import "YDDemoMarco.h"
#import "YDBannerViewController.h"
#import "YDInterstitialViewController.h"
#import "YDNativeTemplateViewController.h"
#import "YDNativeOneViewController.h"
#import "ListCell.h"
#import <YDSDK/YDSDK.h>
//#import "Person.h"

@interface RootViewController () <NSURLSessionDataDelegate, YDInterstitialDelegate, UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) YDContentManager *contentManager;
//@property (nonatomic, strong) YDResponseModel *responseModel;
//@property (nonatomic, strong) YDResponseAdlistModel *listModel;
//
//@property (nonatomic, strong) YDLoadingView *loadingView;
//
//@property (nonatomic, assign) BOOL loadingViewIsShowing;
//
//@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *adAPIListArray;
@property (nonatomic, strong) NSArray *adNameListArray;


@end

@implementation RootViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        [_tableView registerNib: [UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];
        
        _tableView.rowHeight = 72;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)adAPIListArray {
    
    if (!_adAPIListArray) {
        _adAPIListArray = @[@"getBannerAdswitchSlotId",
                            @"preloadInterstitialWithSlotId",
                            @"getNativeTmplateWithSlotId",
                            @"getNativeAdswitchSlotId",
//                            @"API:"
                         ];
    }
    return _adAPIListArray;
}

- (NSArray *)adNameListArray {
    if (!_adNameListArray) {
        _adNameListArray = @[@"Banner",
                             @"Interstitial",
                             @"NativeTemplate",
                             @"Native",
//                             @"NativeTableView"
                             ];
    }
    return _adNameListArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    NSLog(@"%@", PATH_OF_DOCUMENT);
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"YodaMob"]];
    
//    self.navigationItem.titleView = imageView;
    
//    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    self.webView.delegate = self;
//    [self.view addSubview: self.webView];
//    
//    NSString *string = @"http://tr.pubnative.net/click/bulk?aid=1014254&aaid=1017215&pid=7453529&nid=20&puid=1005968&affid=24712&pn_u=VO8FbxVUICFsGNZRIiTJ4giflu0FcPMaX97DfLEEm8rQrWw6usAcGldBSziL5d9GbACICZJ_i_VwXxbl3NLNkWnbAfBqnP6ozDjn3w61_W3Zp_y6ZxKTA_uGHw&pn_l=122&aff_sub=pbntv6339298_7453529_261_CN_hcvr.ecpm5_i-1.2.0_822-597-144_22_11785449787453529261_1489546261___FA708C4C-94D6-4102-9630-57F6A6627A58_VHljaG9vby5MdWN1YmVyLkRlbW8oc2RrMik%3D_iOS_0.130&pub_sub_id=261&ch=pbnt";
//    
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:string]];
    
    //    [self.webView loadRequest:request];
    
    //    self.loadingView = [[YDLoadingView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    //    [self testYDContentMananger];
    //    [self testServer];
    //    [self testObjectWithKeyValue];
    //    [self testYDService];
    //    self.logger = [[YDLogger alloc] init];
    //    [self testYDBanner];
   
    
}

#pragma mark - UITableViewDelegate&DataScore

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adAPIListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell" forIndexPath:indexPath];
    
    cell.nameLabel.text = self.adNameListArray[indexPath.row];
    cell.apiLabel.text = self.adAPIListArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self requestADsWithTypeIndex:indexPath.row];
}

- (void)requestADsWithTypeIndex:(NSInteger)index {
    
    YDBannerViewController *bannerVC = [[YDBannerViewController alloc] init];
    YDInterstitialViewController *interstitialVC = [[YDInterstitialViewController alloc] init];
    YDNativeTemplateViewController *nativeTemplateVC = [[YDNativeTemplateViewController alloc] init];
    YDNativeOneViewController *nativeOneVC = [[YDNativeOneViewController alloc] init];
//    YDNativeManyViewController *nativeManyVC = [[YDNativeManyViewController alloc] init];
    
//    YDNativeTableViewController *nativeTableVC = [[YDNativeTableViewController alloc] init];
    
    
    switch (index) {
        case 0:
            [self.navigationController pushViewController:bannerVC animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:interstitialVC animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:nativeTemplateVC animated:YES];
            break;
            
        case 3:
            [self.navigationController pushViewController:nativeOneVC animated:YES];
            break;
            
        case 4:
//            [self.navigationController pushViewController:nativeTableVC animated:YES];
            break;
            
        case 5:
//            [self.navigationController pushViewController:nativeTableVC animated:YES];
            break;
            
        default:
            break;
    }
}


/*
- (void)testYDBanner {
    
    [[YDService shareManager] getBannerADswitchSlotId:@"260" delegate:self frame:CGRectMake(0, 20, UI_SCREEN_WIDTH, 200) needCloseButton:YES keyWords:nil isTest:NO success:^(UIView *bannerView) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:bannerView];
        });
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [YDService interstitialShow];
    
    if (self.loadingViewIsShowing) {
        
        self.loadingViewIsShowing = NO;
        [self.loadingView forcedHideActivityIndicator];
        
    } else {
        
        [self.loadingView showActivityIndicatorInParentView:self.view];
        self.loadingViewIsShowing = YES;
    }
//    self.partitionView = nil;
}

- (void)testYDService {
   
    [[YDService shareManager] perloadInterstitialWithSlotId:@"261" delegate:self isFullScreen:YES keyWords:nil isTest:NO success:^(UIView *interstitialView) {
        
        NSLog(@"%@", [NSThread currentThread]);
        if (interstitialView) {
//            interstitialView.hidden = NO;
            [self.view addSubview:interstitialView];
        }
        
        [[YDService shareManager] interstitialShow];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)testYDContentMananger {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ListModel" ofType:@".json"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.responseModel = [YDResponseModel objectWithKeyValues:dict];
    
    self.listModel = self.responseModel.ad_list[0];
    
    NSLog(@"%@", self.listModel);
    
    _contentManager = [[YDContentManager alloc] init];
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 120);
    
    
    [self.contentManager showContentWithType:YDContentTypeHTML5 urlString:self.listModel.bak_creative.html atParentView:self.view contentFrame:rect trackArray:nil listModel:self.listModel success:^{
        
    } failed:^(NSError * _Nonnull error) {
        
    }];
}

- (void)testHorizontalLineView {
    
    YDHorizontalLineView *view = [[YDHorizontalLineView alloc] init];
    view.frame = CGRectMake(0, 200, UI_SCREEN_WIDTH, 2);
    
    [self.view addSubview:view];
}

- (void)testServer {
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8081/person"];
    
    YDURLSession *session = [YDURLSession session];
    
    [session GET:url isDecodeJSON:YES completion:^(id  _Nullable responseObjcet, NSError * _Nullable error) {
        
        if (error) {
            
            NSLog(@"error = %@", error);
            
        } else {
            
            NSLog(@"%@", responseObjcet);
            
            Person *person = [Person objectWithKeyValues:(NSDictionary *)responseObjcet[@"person"]];
            
            NSLog(@"%@", person);
        }
        
        NSLog(@"%@", [NSThread currentThread]);
        
    }];
}

- (void)testObjectWithKeyValue {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Person" ofType:@".json"];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSLog(@"%@", data);
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"%@", json);
    
    Person *person = [Person objectWithKeyValues:(NSDictionary *)json[@"person"]];
    
    NSLog(@"%@", person);
}
*/

@end
