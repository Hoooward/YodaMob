//
//  YDHUD.h
//  YDSDK-Demo
//
//  Created by Tychooo on 2017/4/24.
//  Copyright © 2017年 YodaMob. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YDHUDMode) {
    /// 转圈动画模式, 默认值
    YDHUDModeIndeterminate,
    /// 只显示标题
    YDHUDModeText
};

@interface YDHUD : UIView

@property (nonatomic, assign) YDHUDMode mode;
@property (nonatomic, strong) NSString *labelText;

- (instancetype)initWithView:(UIView *)view;

- (void)show;
- (void)hide;

@end
