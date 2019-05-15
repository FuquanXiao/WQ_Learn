//
//  ViewController.m
//  APPJump
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        label.text = @"App";
        [ self.view addSubview:label];
    label.backgroundColor = [UIColor cyanColor];
  
}


@end
