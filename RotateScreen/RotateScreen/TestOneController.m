//
//  TestOneController.m
//  RotateScreen
//
//  Created by apple on 2019/5/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TestOneController.h"
#import "ViewController.h"

@interface TestOneController ()

@end

@implementation TestOneController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 100, 70)];
    [self.view addSubview:imageView];
    imageView.backgroundColor = [UIColor redColor];
    
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
    [imageView addGestureRecognizer:tap];
    
}

- (void)tapHandle{
    ViewController *vvvv = [ViewController new];
    [self.navigationController presentViewController:vvvv animated:YES completion:nil];
//    [self.navigationController pushViewController:vvvv animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
