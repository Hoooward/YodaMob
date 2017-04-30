//
//  YDHUD.m
//  YDSDK-Demo
//
//  Created by Tychooo on 2017/4/24.
//  Copyright © 2017年 YodaMob. All rights reserved.
//

#import "YDHUD.h"

static CGFloat const kMargin = 20;
static CGFloat const kPadding = 4;

#define MB_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;

@interface YDHUD()

{
    CGSize originSize;
}

@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) UILabel *label;

@end


@implementation YDHUD

- (instancetype)initWithView:(UIView *)view {
    return [self initWithFrame:view.bounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _mode = YDHUDModeIndeterminate;
        _labelText = nil;
        originSize = CGSizeZero;
        
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        
        [self makeUI];
        [self updateIndicators];
        [self registerForKVO];
    }
    
    return self;
}

- (void)dealloc
{
    [self unregisterFromKVO];
}

- (void)makeUI {
    _label = [[UILabel alloc] initWithFrame:self.bounds];
    _label.adjustsFontSizeToFitWidth = NO;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.opaque = NO;
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.text = self.labelText;
    [self addSubview:_label];
}

- (void)updateIndicators {
    
    BOOL isActivityIndicator = [_indicator isKindOfClass:[UIActivityIndicatorView class]];
    
    if (_mode == YDHUDModeIndeterminate) {
        
        if (!isActivityIndicator) {
            [_indicator removeFromSuperview];
            
            self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [(UIActivityIndicatorView *)_indicator startAnimating];
            
            [self addSubview:_indicator];
        }
        
    } else if (_mode == YDHUDModeText){
        [_indicator removeFromSuperview];
        self.indicator = nil;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 覆盖整个视图，屏蔽交互操作
    UIView *parent = self.superview;
    if (parent) {
        self.frame = parent.bounds;
    }
    CGRect bounds = self.bounds;
    
    
    CGFloat maxWidth = bounds.size.width - 4 * kMargin;
    CGSize totalSize = CGSizeZero;
    
    CGRect indicatorF = _indicator.bounds;
    indicatorF.size.width = MIN(indicatorF.size.width, maxWidth);
    totalSize.width = MAX(totalSize.width, indicatorF.size.width);
    totalSize.height += indicatorF.size.height;
    
    CGSize labelSize = MB_TEXTSIZE(_label.text, _label.font);
    labelSize.width = MIN(labelSize.width, maxWidth);
    totalSize.width = MAX(totalSize.width, labelSize.width);
    totalSize.height += labelSize.height;
    if (labelSize.height > 0.f && indicatorF.size.height > 0.f) {
        totalSize.height += kPadding;
    }
    
    totalSize.width += 2 * kMargin;
    totalSize.height += 2 * kMargin;
    
    CGFloat yPos = round(((bounds.size.height - totalSize.height) / 2)) + kMargin;
    CGFloat xPos = 0;
    
    indicatorF.origin.y = yPos;
    indicatorF.origin.x = round((bounds.size.width - indicatorF.size.width) / 2) + xPos;
    _indicator.frame = indicatorF;
    yPos += indicatorF.size.height;
    
    if (labelSize.height > 0.f && indicatorF.size.height > 0.f) {
        yPos += kPadding;
    }
    
    CGRect labelF;
    labelF.origin.y = yPos;
    labelF.origin.x = round((bounds.size.width - labelSize.width) / 2) + xPos;
    labelF.size = labelSize;
    _label.frame = labelF;
    
    originSize = totalSize;
    
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    CGContextSetGrayFillColor(context, 0.0f, 0.8);
    
    CGRect allRect = self.bounds;
    
    CGRect boxRect = CGRectMake(round((allRect.size.width - originSize.width) / 2), round((allRect.size.height - originSize.height) / 2), originSize.width, originSize.height);
    
    
    float radius = 10;
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * (float)M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMaxY(boxRect) - radius, radius, 0, (float)M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect) + radius, radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    UIGraphicsPopContext();
}

-(void)show {
    self.alpha = 1;
}

- (void)hide {
    self.alpha = 0;
    [self removeFromSuperview];
}

#pragma mark - KVO


- (NSArray *)observableKeypaths {
    return [NSArray arrayWithObjects:@"mode", @"labelText", nil];
}

- (void)registerForKVO {
    for (NSString *keyPath in  [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeyPath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self updateUIForKeyPath:keyPath];
    }
}

- (void)updateUIForKeyPath:(NSString *)keyPath {
    
    if ([keyPath isEqualToString:@"mode"]) {
        [self updateIndicators];
    } else if ([keyPath isEqualToString:@"labelText"]) {
        _label.text = self.labelText;
    }
}

@end
