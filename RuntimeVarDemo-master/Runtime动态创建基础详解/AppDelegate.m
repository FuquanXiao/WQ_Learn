//
//  AppDelegate.m
//  Runtime动态创建基础详解
//
//  Created by apple on 2017/7/14.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (void)addLoactionNotification{
    
    if (@available(iOS 10.0,*)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"1212";
        content.subtitle = @"测试通知副标题";
        // 内容
        content.body = @"测试通知的具体内容";
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
        NSString *identifier = @"noticeId";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            NSLog(@"成功添加推送");
        }];
    }else{
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        
        localNotification.alertBody = @"aaaaaa";
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];

        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}


- (void)registerAPN{
    
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
         center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge+ UNAuthorizationOptionSound + UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
    }else{
         [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert  categories:nil]];
    }
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

/**
 程序启动注册本地通知   //app启动完毕后就会调用  //点击通知打开app 的Key，UIApplicationDidFinishLaunchingNotification
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerAPN];
    [self addLoactionNotification];
    return YES;
}


/**
 
 iOS 8——10 收到本地通知会调用这个方法；但是没有弹窗提示； 点击后台收到的消息也会执行这一个
 NS_DEPRECATED_IOS(4_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //方法执行
}

/**
 
 iOS 10 之后 收到本地通知会调用这个方法；  有弹窗提示；
 **/
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10.0, *)) {
        completionHandler( UNNotificationPresentationOptionSound |
                          UNNotificationPresentationOptionAlert
                          );
    } else {
        // Fallback on earlier versions
    }
}
/**
 ios 10 前台后台收到本地通知   点击通知之后调用    The method will be called on the delegate when the user responded to the notification by opening the application
 **/
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    completionHandler();
}

/**
 这个方法也不知道什么时候开始调用
 */

- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    
}

/**
  NS_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    
    
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    } else {
        
    }
}


/***
 下面这四个方法目前不知道什么时候执行
 **/


- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler{
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    
}


- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler{
    
};

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    
};
















///应用程序将要进入非活动状态执行，在此期间，应用程序不接收消息或事件（app进入后台、下拉系统状态栏、来电话了等）
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%s",__func__);
}


///当程序被推送到后台的时候调用。要设置后台继续运行，则在这个方法里面设置
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%s",__func__);

}
/*
从后台打开app 先调用该函数   再执行applicationDidBecomeActive

 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s",__func__);

}

/*应用程序入活动状态执行(app首次启动、从后台打开app都会调用)
双击home键app变小的转态
 挂电话 applicationDidBecomeActive
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    //多次执行
    NSLog(@"%s",__func__);

}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%s",__func__);

}


// 启动 ->applicationDidBecomeActive（活跃状态） ->按下Home键 applicationWillResignActive(将要处于非活跃状态) -马上进入> applicationDidEnterBackground（后台状态） -点击APP重新打开> applicationWillEnterForeground(将要进入前台) -马上进入>applicationDidBecomeActive


@end
