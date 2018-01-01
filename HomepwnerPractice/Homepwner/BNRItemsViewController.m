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
@interface BNRItemsViewController()

@property (nonatomic) NSDictionary *dataDictionary;
@property(nonatomic) NSArray *sectionTitle;

@end


@implementation BNRItemsViewController

-(instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
        [self setDataDictionary:@{@"more than 50":[[NSMutableArray alloc]init],
                                  @"less than 50":[[NSMutableArray alloc]init]}];
        for (int i = 0; i< 20; i++) {
            BNRItem *item = [[BNRItemStore shareStore] createItem];
            if (item.valueInDollars >= 50) {
                [self.dataDictionary[@"more than 50"] addObject:item];
            }else{
                [self.dataDictionary[@"less than 50"] addObject:item];
            }
        }
        [self setSectionTitle:[[self.dataDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NoMoreCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.sectionTitle objectAtIndex:section];
    NSArray *items = [self.dataDictionary objectForKey:key];
    NSInteger count = [items count];
    if (section == ([self.sectionTitle count] - 1)) {
        count += 1;
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.sectionTitle objectAtIndex:indexPath.section];
    NSArray *items = [self.dataDictionary objectForKey:key];
    
    NSString *identifier = nil;
    if (indexPath.row == ([items count])) {
        identifier = @"NoMoreCell";
    }else{
        identifier = @"UITableViewCell";
    }
    
    // dequeueReusableCellWithIdentifier:forIndexPath: 从已注册的class/nib 中创建 cell ,不为 nil
    //dequeueReusableCellWithIdentifier 若注册的 cell 无可用 cell 时,返回 nil
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    
   
    if (indexPath.row == ([items count])) {
        cell.textLabel.text = @"No More Items";
    } else{
        BNRItem *item = items[indexPath.row];
        cell.textLabel.text = item.description;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.sectionTitle objectAtIndex:indexPath.section];
    NSArray *items = [self.dataDictionary objectForKey:key];
    
    if (indexPath.row == ([items count])) {
        return 44;
    }else{
         return 80;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionTitle objectAtIndex:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sectionTitle count];
}

@end
