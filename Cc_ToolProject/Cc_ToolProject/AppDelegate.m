//
//  AppDelegate.m
//  Cc_ToolProject
//
//  Created by cchuan on 15/12/18.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setUpLogColor];
    
    return YES;
}

- (void)setUpLogColor
{
    // 实例化 lumberjack
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    // 允许颜色
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    // 配置以下内容在pch文件中
//#ifdef DEBUG
//    static const int ddLogLevel = DDLogLevelVerbose;
//#else
//    static const int ddLogLevel = DDLogLevelError;
//#endif
    
    // 然后运行 xcodeColors工程，配置scheme的run中的environment添加“XcodeColors”设置为YES
    
//    DDLogError(@"错误信息"); // 红色
//    DDLogWarn(@"警告"); // 橙色
//    DDLogInfo(@"提示信息"); // 默认是黑色
//    DDLogVerbose(@"详细信息"); // 默认是黑色
    // 以下方法可以修改各种状态的颜色
//    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:LOG_FLAG_INFO];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
