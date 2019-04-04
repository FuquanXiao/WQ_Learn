//
//  ViewController.m
//  BlockStudy
//
//  Created by xfq on 2019/3/19.
//  Copyright © 2019年 xfq. All rights reserved.
//

#import "ViewController.h"

//#import "MMMMPeople.h"
NSInteger cellHeight  = 100;

@interface ViewController ()

@property (nonatomic,strong)NSString *testString;
//@property (nonatomic,strong);
@property (nonatomic,strong)NSMutableArray *arrr;
@end

@implementation ViewController


static NSString *staticGlobalStr  = @"静态全局变量";

NSString *globalStr = @"全局变量";




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    ^{ printf("Hello, World!\n"); };
    _arrr = [[NSMutableArray alloc] init];
    ();
    
//
//    void (^stackBlock)(NSString *str) = ^(NSString *str) {
//        NSLog(@"%@", str);
//    };
//    [_arrr addObject:stackBlock];
//
//    [self test];
}

- (void)test{
    void (^stackBlock1)(NSString *str) = _arrr.firstObject;
    if (stackBlock1) {
        stackBlock1(@"212121");
    }
}


@end
