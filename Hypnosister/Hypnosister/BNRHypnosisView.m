//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Paullee on 2017/12/27.
//  Copyright © 2017年 Paullee. All rights reserved.
//

#import "BNRHypnosisView.h"

// m 文件中声明属性: 类扩展 : 隐藏内部细节
//头文件中的声明表明是对外可见属性,只会被类内部使用的属性和方法应当声明在类扩展中
//子类无法访问类扩展中声明的方法与属性
@interface BNRHypnosisView()

@property (strong,nonatomic) UIColor *circleColor;

@end

@implementation BNRHypnosisView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    //frame.origin x y
    //frame.size width height
    self = [super initWithFrame:frame];
    if (self) {
        self.circleColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) drawRect:(CGRect)rect
{
    NSLog(@"%@",self);
    CGRect bounds = self.bounds;//CGRect bounds View 绘制自身时的内容坐标系
    
    //计算中心
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width /2.0;
    center.y = bounds.origin.y + bounds.size.height/2.0;
    
    //半径
    float maxradius = (MIN(bounds.size.width, bounds.size.height)/2.0);
    
    //具体参见 Doc 文档
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    for (float currentradius = maxradius; currentradius > 0; currentradius -= 20) {
        //连续绘制时, pait move 否则造成连笔
        [path moveToPoint:CGPointMake(center.x + currentradius,center.y)];// 挪动绘制笔迹起点到对应圆右侧
        
        [path addArcWithCenter:center radius:currentradius startAngle:0.0 endAngle:M_PI *2.0 clockwise:YES];
    }
    
    path.lineWidth =  10;
    //绘制颜色设置
    [self.circleColor setStroke];
    [path stroke];

    
    //利用 UIImage 绘图
    UIImage *logoImage = [UIImage imageNamed:@"ic_snap_shot.png"];

    //context
    CGContextRef context =  UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //开启阴影
    CGContextSetShadow(context, CGSizeMake(4, 4), 3);
    //绘制带阴影效果的图像
    [logoImage drawInRect:CGRectMake(center.x - 25, center.y -25, 50, 50)];
    CGContextRestoreGState(context);//恢复初始不带阴影的状态
    
    
    CGFloat locations[2] = {0.0,1.0};
    CGFloat components[8] ={1.0,0.0,0.0,1.0,
                            1.0,1.0,0.0,1.0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    
    CGPoint startPoint = CGPointMake(0, center.y -100);
    CGPoint endpoint = CGPointMake(0, center.y + 100);
    
    CGContextSaveGState(context);
    //裁剪 clip 三角形 ,将剪裁 path 设置为当前渐变色的上下文图像
    //[path addClip];
     UIBezierPath *trianglepath = [[UIBezierPath alloc]init];
    [trianglepath moveToPoint:CGPointMake(center.x, center.y - 100)];
    [trianglepath addLineToPoint:CGPointMake(center.x - 50, center.y + 100)];
    [trianglepath addLineToPoint:CGPointMake(center.x + 50, center.y + 100)];
    [trianglepath closePath];
    [trianglepath addClip];
    CGContextDrawLinearGradient(context, gradient, startPoint, endpoint, 0);
    CGContextRestoreGState(context);
    
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched...",self);

    float red = (arc4random() % 100)/100.0;
    float green = (arc4random() % 100)/100.0;
    float blue = (arc4random() % 100)/100.0;

    UIColor * randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}



-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;// 不能使用  self.circleColor 无限循环
    [self setNeedsDisplay];
}

@end
