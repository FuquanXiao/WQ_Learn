//
//  ViewController.m
//  BlockStudy
//
//  Created by xfq on 2019/3/19.
//  Copyright © 2019年 xfq. All rights reserved.
//

#import "ViewController.h"
#import "AViewController.h"
#define mas_tttt(...) tttt(_MASBoxValue(value))

//#import "MMMMPeople.h"
NSInteger cellHeight  = 100;

@interface ViewController ()

@property (nonatomic,strong)NSString *testString;
//@property (nonatomic,strong);
@property (nonatomic,strong)NSMutableArray *arrr;

@property (nonatomic,strong)void (^bbbbb)(NSString *);
- (NSString * (^)(int))tttt;
@end

@implementation ViewController

- (void)dealloc{
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    
    
}

- (void)getFieldCompletion:(void (^)(int b))bbb{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    AViewController *av = [[AViewController alloc] init];
    [self presentViewController:av animated:YES completion:nil];
}

/*
static NSString *staticGlobalStr  = @"静态全局变量";

NSString *globalStr = @"全局变量";


static inline int _MASBoxValue(int  d){
    return d * d;
}


- (NSString * (^)(int))tttt{
    
    
    return ^NSString *(int dd){
        
        return [NSString stringWithFormat:@"%d",dd];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  NSString *bbbbbb = self.mas_ttttt(111);
    
    
    _bbbbb = ^(NSString *bbb){
        
    };
    
    
    void(^myBlock_2)(int, int) = ^(int a, int b){
        int c = a + b;
        NSLog(@" a + b = %d", c);
    };
    myBlock_2(2 ,3);
    
    
    
    
    
    
    NSObject *objjjjjjj = [NSObject new];
    
    __weak NSObject *obj2222222 = objjjjjjj;
    
//    ^{ printf("Hello, World!\n"); };
//    _arrr = [[NSMutableArray alloc] init];
//    ();
    
//
//    void (^stackBlock)(NSString *str) = ^(NSString *str) {
//        NSLog(@"%@", str);
//    };
//    [_arrr addObject:stackBlock];
//
//    [self test];
}

- (void)test{
    void (^stackBlock1)(NSString *str) = _arrr.firstObject;
    if (stackBlock1) {
        stackBlock1(@"212121");
    }
}

*/
@end
