//
//  YDDemoMarco.h
//  YDSDK-Demo
//
//  Created by Tychooo on 2017/4/5.
//  Copyright © 2017年 YodaMob. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef YDDemoMarco_h
#define YDDemoMarco_h

// YodaMob SlotId

// YodaMob 优先
#define bannerSlotId            @"590ed278e4b0c474d1a04b00"
#define interstitilaSlotId      @"590fd0a5e4b0c474d1a04b01"
#define OneNativeSlotId         @"590fd0dae4b0c474d1a04b02"
#define nativeTemplateSlotId    @"590fd0fde4b0c474d1a04b03"

// Facebook 优先
/*
#define bannerSlotId            @"59040a2de4b00d54f1646933"
#define interstitilaSlotId      @"59040a54e4b00d54f1646934"
#define nativeTemplateSlotId    @"59040a80e4b00d54f1646935"
#define OneNativeSlotId         @"59041660e4b00d54f1646936"
 */

// Google 优先
/*
#define bannerSlotId            @"59040a2de4b00d54f1646933"
#define interstitilaSlotId      @"59040a54e4b00d54f1646934"
#define nativeTemplateSlotId    @"59040a80e4b00d54f1646935"
#define OneNativeSlotId         @"59041660e4b00d54f1646936"
 */


#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)

#else

#define debugLog(...)
#define debugMethod()

#endif

#define EMPTY_STRING        @""

#define STR(key)            NSLocalizedString(key, nil)

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// UIConstants provides contants variables for UI control.
#define UI_NAVIGATION_BAR_HEIGHT    44
#define UI_TAB_BAR_HEIGHT           49
#define UI_STATUS_BAR_HEIGHT        20
#define UI_SCREEN_WIDTH             ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT            ([[UIScreen mainScreen] bounds].size.height)

#define UI_LABEL_LENGTH             200
#define UI_LABEL_HEIGHT             15
#define UI_LABEL_FONT_SIZE          12
#define UI_LABEL_FONT               [UIFont systemFontOfSize:UI_LABEL_FONT_SIZE]

#define YDViewControllerDefaultBackgroupColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:1 alpha:1]
#define REQUEST_BUTTON_BAK_COLOR [UIColor colorWithRed:1.0 green:143/255.0 blue:0 alpha:1]
#define CLOSE_BUTTON_BAK_COLOR [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]
#define SHOW_BUTTON_BAK_COLOR

/*
 *  System Versioning Preprocessor Macros
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/*
 
 Usage sample:
 
 if (SYSTEM_VERSION_LESS_THAN(@"4.0")) {
 ...
 }
 
 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"3.1.1")) {
 ...
 }
 
 */

//solve block Circular referencT
#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

#endif /* YDDemoMarco_h */
