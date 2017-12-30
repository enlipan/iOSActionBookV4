//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Paullee on 2017/12/28.
//  Copyright © 2017年 Paullee. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

// 扩展属性
//<UITextFieldDelegate> 协议声明,以便编译器检查
@interface BNRHypnosisViewController () <UITextFieldDelegate>

-(void)drawHypnoticMessag;

@end

@implementation BNRHypnosisViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *i = [UIImage imageNamed:@"Hypno"];
        self.tabBarItem.image = i;
    }
    return self;
}


-(void)loadView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc]initWithFrame:frame];
    
    CGRect textFeildRect = CGRectMake(40, 70, 240, 50);
    UITextField *feild = [[UITextField alloc]initWithFrame:textFeildRect];
    
    feild.borderStyle = UITextBorderStyleRoundedRect;
    feild.placeholder = @"Hypnotize V me";
    feild.returnKeyType = UIReturnKeyDone;
    feild.autocapitalizationType = UITextAutocapitalizationTypeWords;//自动大写
    feild.keyboardType =  UIKeyboardTypeDefault;
    //feild.secureTextEntry = YES;
    
    //委托,与 Java 不同的是,不需要实现所有委托函数,运行时检查,如果委托没有实现则不调用改方法
    // 委托与对象之间的联系,通常使用弱联系,防止循环引用
    feild.delegate = self;//@interface BNRHypnosisViewController () <UITextFieldDelegate> 声明后,警告去除
    
    [backgroundView addSubview:feild];
    
    self.view = backgroundView;
}

//协议: 支持委托的对象,所声明的支持消息的类型,表明可以向改委托对象发送的消息;
// @protocol 协议类似 Java 接口和抽象类的混合,协议中可以声明可选与必须实现,默认必须实现
// responseToSelector
// 可选协议发送消息时,应该先检测是否实现,而必须实现的协议则可以直接发送消息,如果未实现必需协议编译时不能通过

// 委托的函数名一定要正确,否则无法触发委托
-(BOOL) textFieldShouldReturn :(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    [self drawHypnoticMessag:textField.text];
    textField.text = @"";
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void) drawHypnoticMessag : (NSString *)message
{
    for (int i= 0; i<20; i++) {
        UILabel *messageLabel = [[UILabel alloc]init];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text =message;
        
        //文字多少,调整 Label 大小
        [messageLabel sizeToFit];
        
        //
        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        int x = arc4random() % width;
        int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
        int y = arc4random() % height;
        
        //CGRect frame = messageLabel.frame;
        CGRect frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        // 视差效果
        //UIInterpolatingMotionEffect *motionEffect;
        
        
        [self.view addSubview:messageLabel];
    }
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
