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

@property(nonatomic,strong) IBOutlet UIView *headerView;

@end


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
    
    UIView *headerView = self.headerView;
    [self.tableView setTableHeaderView:headerView];
}


-(IBAction)addNewItem :(id)sender
{
    //NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    BNRItem *newItem = [[BNRItemStore shareStore]createItem];
    
    //获取新建 Item 在 NSData 中索引,对应插入 path 二者需要相同
    NSInteger lastRow = [[[BNRItemStore shareStore]allItems] indexOfObject:newItem];
    
    // 在指定位置构建 indexPath 对象
    NSIndexPath *insertPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[insertPath] withRowAnimation:UITableViewRowAnimationTop];
}

-(IBAction)toggleEditModel:(id)sender
{
    if (self.isEditing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];// sender =>  UILabel
    }else{
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

-(UIView *)headerView
{
    if (!_headerView) {
        [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore shareStore]allItems];
        BNRItem *item = items[indexPath.row];
        
        [[BNRItemStore shareStore]removeItem:item];
        //删除UI 行元素
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore shareStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}


// 自定义编辑模式 删除 UI
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Remove" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSArray *items = [[BNRItemStore shareStore]allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore shareStore]removeItem:item];
       
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    return @[deleteAction];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [[[BNRItemStore shareStore]allItems]count] - 1) {
        return NO;
    }
    return YES;
}

@end
