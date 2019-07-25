//
//  ConverstationManager.m
//  DelegateDemo
//
//  Created by apple on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ConverstationManager.h"
#import "Converstation.h"
@implementation ConverstationManager
- (NSMutableArray *)getConversationList{
    Converstation *con = [[Converstation alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:con];
    return array;
}

@end
