//
//  RunTimeController.m
//  KVODemo
//
//  Created by apple on 2019/7/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RunTimeController.h"
#import "People.h"
#import <objc/message.h>
@interface RunTimeController ()

@end
/*
IMP 指针  指向代码块的实现  方法实现代码块
SEL 标号 一个标号对应着一个IMP
 */
@implementation RunTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    People *pp = [[People alloc] init];
///使用pp 调用一个没有声明也没有实现的方法；
//    [pp performSelector:@selector(eat)];
//   苹果不允许使用消息机制发送消息 所以我们去关闭这个 见qq 截图
//    objc_msgSend(pp,@selector(eat));
    [pp instanceEat];
//    objc_msgSend(pp, <#SEL  _Nonnull op, ...#>)
}



@end
