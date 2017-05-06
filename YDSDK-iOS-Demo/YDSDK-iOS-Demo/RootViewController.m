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
@property (nonatomic, strong) NSArray *adChNameListArray;


@end

@implementation RootViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        [_tableView registerNib: [UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];
        
        _tableView.rowHeight = 80;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)adAPIListArray {
    
    if (!_adAPIListArray) {
        _adAPIListArray = @[
                            @"getBannerAdswitchSlotId",
                            @"preloadInterstitialWithSlotId",
                            @"getNativeTemplateWithSlotId",
                            @"getNativeElementAdswitchSlotId",
                         ];
    }
    return _adAPIListArray;
}

- (NSArray *)adNameListArray {
    if (!_adNameListArray) {
        _adNameListArray = @[
                             @"Banner",
                             @"Interstitial",
                             @"NativeTemplate",
                             @"NativeElement",
                             ];
    }
    return _adNameListArray;
}

- (NSArray *)adChNameListArray {
    
    if (!_adChNameListArray) {
        _adChNameListArray = @[
                               @"横幅广告",
                               @"插屏广告",
                               @"原生广告 - 使用自定义 HTML5 模板",
                               @"原生广告 - 元素",
                             ];
    }
    return _adChNameListArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    NSLog(@"%@", PATH_OF_DOCUMENT);
    NSArray *array = @[@"1", @"2", @"3"];
    NSString *result = [array objectAtIndex:100];
}

#pragma mark - UITableViewDelegate&DataScore

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adAPIListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell" forIndexPath:indexPath];
    
    cell.nameLabel.text = self.adNameListArray[indexPath.row];
    cell.apiLabel.text = self.adAPIListArray[indexPath.row];
    cell.chNameLabel.text = self.adChNameListArray[indexPath.row];
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
            
            
        default:
            break;
    }
}



@end
