//
//  ViewController.m
//  KVODemo
//
//  Created by apple on 2019/7/1.
//  Copyright © 2019 apple. All rights reserved.
//

/**
 代理一个对象告诉另外一个对象  1：1
 通知一个对象可以告诉多个对象 1：n
 
 
 KVC Key Value Coding 常见作用：为模型属性赋值
 KVO Key Value Observing 监听属性的变化
 **/


#import "ViewController.h"
#import "People.h"
@interface ViewController ()
@property (nonatomic,strong)People *people1;
@property (nonatomic,strong)People *people2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.people1 = [[People alloc] init];
    self.people2 = [[People alloc] init];

    [self.people1 addObserver:self forKeyPath:@"namea" options:NSKeyValueObservingOptionNew context:nil];
    [self.people2 addObserver:self forKeyPath:@"namea" options:NSKeyValueObservingOptionNew context:nil];
    self.people1.namea = @"1234";
    self.people2.namea = @"aaaaaa";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tototo:) name:@"vvvvvvvv" object:@{@"56":@"78"}];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"vvvvvvvv" object:@{@"12":@"34"}];

}

- (void)tototo:(NSNotification *)notify{
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self.people1 forKeyPath:@"namea"];
    [self removeObserver:self.people2 forKeyPath:@"namea"];

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"change===%@",change);
}

@end
