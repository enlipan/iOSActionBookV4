//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by Paullee on 2017/12/28.
//  Copyright © 2017年 Paullee. All rights reserved.
//

#import "BNRReminderViewController.h"
#import <UserNotifications/UserNotifications.h>
//@import UserNotifications;

@interface BNRReminderViewController ()

//IBOutlet|| IBAction 属性表示属性或者方法会在 Interface Builder 中关联
//插座变量声明为弱引用: 当系统内存偏少时,视图控制器会自动释放其视图并在之后需要显示的时候再创建
//因而控制器利用弱引用插座变量指向 子 View,以便在 Controller 对应的 View 释放时,释放所有子 View

// 插座变量的存取,在nib 文件载入后通过键值编码方式设置
// 插座变量需要构建对应的 setter 函数或设置对应的实例变量,否则nib 文件加载时会抛出异常
// 同时 Action 函数的命名需要有对应规范,不能随意占用 setter 函数,否则将导致奇怪的问题,在这类问题上浪费大量时间
@property(nonatomic,weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

//方法是 ViewController 的指定初始化函数,最终会通过该函数完成初始化
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //设置 Controller 对应的 TabBar
        self.tabBarItem.title = @"Reminder";
        
        UIImage *i = [UIImage imageNamed:@"Time"];
        self.tabBarItem.image = i;
    }
    return self;
}


-(IBAction)sendReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting Date for : %@",date);
    
    // https://useyourloaf.com/blog/local-notifications-with-ios-10/
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //校验用户是否开启了权限
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
            // Notifications not allowed
        }
    }];
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Hypnotize";
    content.body = @"Hypnotize me!";
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] +1);// 桌面 app icon 右上角的角标数字
    
    //可以设置特定触发时间
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                     components:NSCalendarUnitYear +
                                     NSCalendarUnitMonth + NSCalendarUnitDay +
                                     NSCalendarUnitHour + NSCalendarUnitMinute +
                                     NSCalendarUnitSecond fromDate:date];
    [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
    
    //
    UNTimeIntervalNotificationTrigger *triger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    
    
    //schedular
    // 如果当前已有对应identifier 通知显示,下一个会替代上一个
    NSString *identifier = @"BNRHypnotize";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:triger];
    //注意: 務必切換至桌面才能接收到通知,应用中的前景通知
    [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error){
        if (error != nil) {
            NSLog(@"%@",error);
        }
    }];
    
//    UILocalNotification *notetification = [[UILocalNotification alloc] init];
//
//    notetification.timeZone = [NSTimeZone defaultTimeZone]; //使用本地时区
//    notetification.fireDate = date;
//
//    notetification.alertBody = @"Hypnotize me!"; //设置提醒的文字内容
//    //    notetification.fireDate = date;
//
//    notetification.soundName = UILocalNotificationDefaultSoundName; //通知提示音，使用默认的
//
//    [[UIApplication sharedApplication] scheduleLocalNotification:notetification]; //将通知添加到系统中
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //只有视图被加载完成后才会被调用,视图相关的代码在此实现,进而实现懒加载,如果视图未被显示,视图就不会被加载,相关的子 View 也不会被处理
    //只在初次加载时触发一次
    NSLog(@"Reminder has been loaded");
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 用户每次看到 Controller 对应的 View 时都会执行
    NSLog(@"Reminder will Appeared");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
