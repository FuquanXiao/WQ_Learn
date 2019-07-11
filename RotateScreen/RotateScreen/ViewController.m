//
//  ViewController.m
//  RotateScreen
//
//  Created by apple on 2019/5/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    [self setInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
}

//// 方法1：
- (void)setInterfaceOrientation:(UIDeviceOrientation)orientation {
    if ([[UIDevice currentDevice]   respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:orientation]
                                    forKey:@"orientation"];
    }
}

// 方法2：
//- (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation {
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice
//                                                                                instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = orientation;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
//}

/**
 //1.决定当前界面是否开启可以转屏，如果返回NO，后面两个方法也不会被调用，只是会支持默认的方向
 */
- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight;
}

/**
 window.controller 中似乎显示不出来 preferredInterfaceOrientationForPresentation
 
 当使用 present的时候 present出来的默认方向
 */
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

/**
 当target中勾选上旋转方向时：
 
 */
@end
