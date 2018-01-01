//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Paullee on 2018/1/1.
//  Copyright © 2018年 Paullee. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItem.h";
#import "BNRItemStore.h"

@implementation BNRItemsViewController

-(instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i< 5; i++) {
            [[BNRItemStore shareStore] createItem];
        }
    }
    
    return self;
}


-(instancetype) initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore shareStore]allItems]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    //[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    NSArray *array = [[BNRItemStore shareStore]allItems];
    NSLog(@"%@",indexPath);
    BNRItem *item = array[indexPath.row];
    cell.textLabel.text = item.description;
    
    return cell;
}


@end
