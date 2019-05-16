//
//  WQGCDViewController.m
//  BlockStudy
//
//  Created by apple on 2019/5/16.
//  Copyright © 2019 xfq. All rights reserved.
//

#import "WQGCDViewController.h"

@interface WQGCDViewController ()
@property (nonatomic,strong)void (^gcdBlock)(NSString *par1);
@property (nonatomic,strong)NSString *nameaa;
@property (nonatomic,strong)dispatch_group_t group ;
@property (nonatomic,strong)dispatch_queue_t queue;

@end

@implementation WQGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameaa = @"1234567890:";
    self.group = dispatch_group_create();
    
    self.queue = dispatch_queue_create("com.SerialQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_enter(self.group);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"%@",self.nameaa);
//    });
    
    dispatch_group_async(self.group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSLog(@"%@",@"==00001");
        [self fetchDataWith:^(int page) {
            dispatch_group_leave(self.group);
        }];
    });
    
    dispatch_group_enter(self.group);
    dispatch_group_async(self.group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSLog(@"%@",@"00002");
        
        [self fetchDataWith:^(int page) {
            dispatch_group_leave(self.group);
        }];
        
        
    });
    
    
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        self.nameaa = @"1111111=";
         NSLog(@"%@",self.nameaa);
    });
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}
- (void)fetchDataWith:(void (^)(int page))callBack{
    
    NSLog(@"callBack1111=== %@",callBack);
    int pageP = 33;
    callBack(pageP);
}


@end
