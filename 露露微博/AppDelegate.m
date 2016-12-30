//
//  AppDelegate.m
//  露露微博
//
//  Created by lushuishasha on 15/8/9.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "AppDelegate.h"
#import "homeViewController.h"
#import "messageViewController.h"
#import "discoverViewController.h"
#import "profileViewController.h"
#import "mainTabBarViewController.h"
#import "FirstScrollView.h"
#import "TROAuthViewController.h"
#import "TRAccount.h"
#import "TRAccountTool.h"
#import "UIWindow+Extension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window = [[UIWindow  alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
     [self.window makeKeyAndVisible];
    
    //设置根控制器
     TRAccount *account = [TRAccountTool returnAccount];
    if (account) {
        [self.window changeRootViewController];
    
    }else {
     self.window.rootViewController = [[TROAuthViewController alloc] init];
    }
    return YES;
    
   // [self registerForRemoteNotification];
    
}
//
//- (void)registerForRemoteNotification {
//    if([[UIDevice currentDevice].systemVersion doubleValue] > 8.0) {
//        UIUserNotificationType types = UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert;
//        UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
//    } else {
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
//    }
//}
//
//#ifdef __IPHONE_8_0
//- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
//    [application registerForRemoteNotifications];
//}
//#endif



- (void) applicationDidEnterBackground:(UIApplication *)application {
    
}
@end
