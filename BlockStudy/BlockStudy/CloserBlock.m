//
//  CloserBlock.m
//  BlockStudy
//
//  Created by apple on 2019/5/16.
//  Copyright © 2019 xfq. All rights reserved.
//

#import "CloserBlock.h"

@implementation CloserBlock
- (void)fetchDataWith:(ClassBuy)callBack{
    int pageP = 33;
    NSLog(@"callBack=== %@",callBack);
    callBack(pageP);
}

@end
