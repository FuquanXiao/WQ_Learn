//
//  AViewController.m
//  BlockStudy
//
//  Created by apple on 2019/5/15.
//  Copyright © 2019 xfq. All rights reserved.
//

#import "AViewController.h"
#import "TestView.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)dealloc{
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor redColor];
    
    TestView *tea = [[TestView alloc] initWithFrame:CGRectMake(10, 10, 400, 400)];
    [self.view addSubview:tea];
    __weak typeof(self) weakSelf = self;
    tea.bbbblock = ^(NSString * _Nonnull a) {
        [weakSelf prit];
    };
    [self getFieldCompletion:^(int b) {
        NSLog(@"%@",self);
    }];
    
}

- (void)prit{
    NSLog(@"%@",@"block中调用self方法");
}
- (void)getFieldCompletion:(void (^)(int b))bbb{
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
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
