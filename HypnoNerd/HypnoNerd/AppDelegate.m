//
//  AppDelegate.m
//  HypnoNerd
//
//  Created by Paullee on 2017/12/28.
//  Copyright © 2017年 Paullee. All rights reserved.
//


#import "AppDelegate.h"
#import "BNRHypnosisViewController.h"
#import "BNRReminderViewController.h"
#import "BNRQuizViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    // TODO: Substitute UIViewController with your own subclass.
    
    //window 的 ViewController 被设置后,进而加载 Controller 对应的 View 对象
    BNRHypnosisViewController *hyController = [[BNRHypnosisViewController alloc]init];
    
    //mainbundle 主程序包,代表代码文件以及资源文件
    NSBundle *appBundle = [NSBundle mainBundle];
    
    //指定nib name 初始化 Controller, 在 bundle 中查找对应 xib 文件
    //BNRReminderViewController *reminderController = [[BNRReminderViewController alloc]initWithNibName:@"BNRReminderViewController" bundle:appBundle];
    
    //由于 nib 文件名称与 ViewController 名称对应,所以无需明确指定 nib 文件名,构造函数能够自动加载对应的nib 文件
    BNRReminderViewController *reminderController = [[BNRReminderViewController alloc]init];
    
    BNRQuizViewController *quizController =[[BNRQuizViewController alloc]init];
    
    UITabBarController *tabController = [[UITabBarController alloc]init];
    tabController.viewControllers = @[hyController,reminderController,quizController];
    
    self.window.rootViewController = tabController;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //申请 本地通知权限
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!granted) {
                                  NSLog(@"Something went wrong");
                              }
                          }];
    application.applicationIconBadgeNumber = 0;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
