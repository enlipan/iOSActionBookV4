//
//  AppDelegate.m
//  Hypnosister
//
//  Created by Paullee on 2017/12/26.
//  Copyright © 2017年 Paullee. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRHypnosisView.h"

@interface AppDelegate ()  <UIScrollViewDelegate>

@property (nonatomic) BNRHypnosisView *hypnosisView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Override point for customization after application launch.
    // TODO: Substitute UIViewController with your own subclass.
    self.window.rootViewController = [[UIViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    CGRect screenRect = self.window.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *=2.0;
    //bigRect.size.height *=2.0;
    
    //设置 ScrollView 的尺寸 => 镜头尺寸  滚动时拖动的是镜头,不是 View
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:screenRect];
    scrollView.delegate = self;

    //CGRect 结构体 : 不属于 OC 对象
    //CGMake  origin.x origin.y width height  值是独立像素点
//    CGRect firstFrame = CGRectMake(160, 240, 100, 150);
    //CGRect firstFrame = self.window.bounds;
    
    //BNRHypnosisView *firstView = [[BNRHypnosisView alloc]initWithFrame:bigRect];
    BNRHypnosisView *firstView = [[BNRHypnosisView alloc]initWithFrame:screenRect];
    firstView.userInteractionEnabled = YES;
    [scrollView addSubview:firstView];
    
   
    // 第二个 View 的放置位置,利用 origin 控制其在第一个 View 右侧
    screenRect.origin.x = screenRect.size.width;
    //BNRHypnosisView *anotherView = [[BNRHypnosisView alloc]initWithFrame:screenRect];
    self.hypnosisView =[[BNRHypnosisView alloc]initWithFrame:screenRect];
    [scrollView addSubview:self.hypnosisView];
    
    //分页 根据 ScrollView bound 尺寸将其分割,拖动后 ScrollView 自动滚动只显示其中一个分割区域
    //[scrollView  setPagingEnabled:YES];
    
    [scrollView setPagingEnabled:NO];
    //组合实现多点触控 设置放大缩小 scale 倍数
    scrollView.maximumZoomScale = 2.0;
    scrollView.minimumZoomScale = 0.2;
    
    //设置 ScrollView 的取景范围,整个能显示的内容大小;
    scrollView.contentSize =  bigRect.size;
    
    //firstView.backgroundColor = [UIColor redColor];
    //add subView 需要在 Window Controller 设置以及makeKeyAndVisible 之后,否则 touch 事件不响应
    //[self.window addSubview:firstView];// 子 View 有一个弱引用的 superView 属性
    [self.window addSubview:scrollView];
    
    
//    CGRect secondFrame = CGRectMake(20, 30, 50, 50);
//    BNRHypnosisView *secondView = [[BNRHypnosisView alloc]initWithFrame:secondFrame];
//    secondView.backgroundColor = [UIColor yellowColor];
//    //[self.window addSubview:secondView];
//    [firstView addSubview:secondView];
    
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // 指定多点触控时缩放的 View
    return self.hypnosisView;
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
