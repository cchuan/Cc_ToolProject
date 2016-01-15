//
//  HUD.m
//  WSProgressHUD
//
//  Created by cchuan on 15/12/30.
//  Copyright © 2015年 wilson-yuan. All rights reserved.
//

#import "HUD.h"

@implementation HUD

+ (void)dismissToast
{
    [WSProgressHUD dismiss];
}

+ (void)showToast
{
    [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeBlack];
}

+ (void)showToastDismissAfter:(int)seconds
{
    [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeBlack];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WSProgressHUD dismiss];
    });
}

+ (void)showToast:(NSString *)toastStr
{
    [WSProgressHUD showWithStatus:toastStr maskType:WSProgressHUDMaskTypeBlack maskWithout:WSProgressHUDMaskWithoutDefault];
}

+ (void)showToast:(NSString *)toastStr dismissAfter:(int)seconds
{
    [WSProgressHUD showWithStatus:toastStr maskType:WSProgressHUDMaskTypeBlack maskWithout:WSProgressHUDMaskWithoutDefault];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WSProgressHUD dismiss];
    });
}

+ (void)showShimmeringToast:(NSString *)toastStr
{
    [WSProgressHUD showShimmeringString:toastStr];
}

+ (void)showShimmeringToast:(NSString *)toastStr dismissAfter:(int)seconds
{
    [WSProgressHUD showShimmeringString:toastStr];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WSProgressHUD dismiss];
    });
}

@end
