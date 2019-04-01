//
//  ViewController.m
//  ThreedStudy
//
//  Created by apple on 2019/3/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,assign)int bbbb;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    dispatch_async(queue, ^{
//        NSData * queData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://img.jbwl66.com/iOSAppConfig.xml"]];
//        NSLog(@"queData=====%@",queData);
//    });
//
//    NSLog(@"一个三四");
    [self _createStackBlock];
    [self _createGlobalBlock];
}
- (void)_createGlobalBlock{
    int aaa = 16;
    _bbbb = 15;
    void (^globalBlock)(int a) = ^(int a){
        NSLog(@"globalBlock 局部变量 = %d",a);
    };
    NSLog(@"globalBlock 局部变量 = %@",globalBlock);
    globalBlock(aaa);
    
    void (^globalBlockA)(void) = ^(void){
        NSLog(@"globalBlockA 局部变量 = %d",aaa);
    };
    NSLog(@"globalBlockA 局部变量 = %@",globalBlockA);
    globalBlockA();
    
    
    
//    void (^globalBlock1)(int a) = ^(int a){
//        NSLog(@"globalBlock 全局变量 = %d",self.bbbb);
//    };
//    NSLog(@"globalBlock 全局变量 = %@",globalBlock1);
//    globalBlock1(_bbbb);
    
    
}


- (void)_createStackBlock{
    
}

@end
