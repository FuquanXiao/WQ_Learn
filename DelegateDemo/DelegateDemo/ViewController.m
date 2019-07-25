//
//  ViewController.m
//  DelegateDemo
//
//  Created by apple on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"
#import "ConverstationManager.h"
#import "Converstation+ShowVble.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ConverstationManager *man = [[ConverstationManager alloc] init];
    NSMutableArray *array =  [man getConversationList];
    for (int i = 0; i < array.count; i++) {
        id<ConverstationShowAble> tempCon = array[i];
        NSLog(@"%@",tempCon.showReuseIndentifier);
    }
    
}


@end
