//
//  HUD.h
//  WSProgressHUD
//
//  Created by cchuan on 15/12/30.
//  Copyright © 2015年 wilson-yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSProgressHUD.h"
#import "MMMaterialDesignSpinner.h"

@interface HUD : UIView

// 去除hud
+ (void)dismissToast;

// 显示一个转圈圈的hud，下一个方法显示seconds秒之后自动消失
+ (void)showToast;
+ (void)showToastDismissAfter:(int)seconds;

// 显示一个左边转圈圈右边文字的hud，下一个方法显示seconds秒之后自动消失
+ (void)showToast:(NSString *)toastStr;
+ (void)showToast:(NSString *)toastStr dismissAfter:(int)seconds;

// 显示一个文字闪烁的hud，下一个方法显示seconds秒之后自动消失
+ (void)showShimmeringToast:(NSString *)toastStr;
+ (void)showShimmeringToast:(NSString *)toastStr dismissAfter:(int)seconds;

@end
