//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Paullee on 2018/1/1.
//  Copyright © 2018年 Paullee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property(nonatomic,readonly) NSArray *allItems;

//类方法
+(instancetype) shareStore;

-(BNRItem *)createItem;

-(void) removeItem:(BNRItem *)item;

-(void) moveItemAtIndex :(NSUInteger) fromIndex
                toIndex : (NSUInteger) toIndex;

@end
