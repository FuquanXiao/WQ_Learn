//
//  WQCloserStaticFunctionController.m
//  BlockStudy
//
//  Created by apple on 2019/5/16.
//  Copyright © 2019 xfq. All rights reserved.
//

#import "WQCloserStaticFunctionController.h"
#import "CloserBlock.h"

@interface WQCloserStaticFunctionController ()
@property (nonatomic,strong)CloserBlock *blocka;
@property (nonatomic,strong)NSString *nameaa;
@end

@implementation WQCloserStaticFunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _blocka = [[CloserBlock alloc] init];
    _nameaa = @"_nameaa";
    
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    self->_blocka->chatBlock ->self
//    _blocka.chatBlock = ^{
//       NSLog(@"%@===",self.nameaa);
//    };
    
   
//    [_blocka fetchDataWith:^(int page) {
//        self.nameaa = @"2333333";
//        NSLog(@"%@%d",self.nameaa,page);
//    }];
    [self fetchDataWith:^(int page) {
         NSLog(@"%@%d",self.nameaa,page);
    }];
}
- (void)fetchDataWith:(void (^)(int page))callBack{
    
    
      NSLog(@"callBack1111=== %@",callBack);
    int pageP = 33;
    
    [_blocka fetchDataWith:^(int page) {
        NSLog(@"%@",self.nameaa);
        callBack(pageP);
    }];  
}
@end
