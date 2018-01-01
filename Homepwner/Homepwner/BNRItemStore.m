//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Paullee on 2018/1/1.
//  Copyright © 2018年 Paullee. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore()

@property(nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+(instancetype)shareStore
{
    //静态变量 => 等同于全局变量,程序指向改变量是强引用,在程序运行的生命周期内永远不会释放
    static BNRItemStore *shareStore = nil;
    if (!shareStore) {
        shareStore = [[self alloc]initPrivate];
    }
    return shareStore;
}

-(instancetype)initPrivate
{
    self = [super init];
    if (!_privateItems) {
        _privateItems = [[NSMutableArray alloc]init];
    }
    return self;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

// property 中的只读属性,以及取方法的覆盖,影响 property 的变量生成,编译器不会自动生成 _allItems 实例变量与取方法
-(NSArray *)allItems
{
    return self.privateItems;
}

-(BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];// 使用到了类的函数实现细节,需要用 import 导入, 与 @class 不同
    [self.privateItems addObject: item];
    //NSLog(@"%@",item);
    return item;
}



@end
