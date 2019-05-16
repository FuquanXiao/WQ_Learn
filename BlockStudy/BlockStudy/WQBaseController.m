//
//  WQBaseController.m
//  BlockStudy
//
//  Created by apple on 2019/5/16.
//  Copyright © 2019 xfq. All rights reserved.
//

#import "WQBaseController.h"
#import "WQCloserStaticFunctionController.h"
#import "WQGCDViewController.h"

@interface WQBaseController ()

@end

@implementation WQBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    WQCloserStaticFunctionController *wq = [[WQCloserStaticFunctionController alloc] init];
//    [self.navigationController pushViewController:wq animated:YES];
    
    WQGCDViewController *wq = [[WQGCDViewController alloc] init];
    [self.navigationController pushViewController:wq animated:YES];
}


@end
