//
//  TestView.m
//  BlockStudy
//
//  Created by apple on 2019/5/15.
//  Copyright © 2019 xfq. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
        [self addSubview:button];
        button.backgroundColor = [UIColor magentaColor];
        [button addTarget:self action:@selector(aaaaaaa) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)aaaaaaa{
    if (self.bbbblock) {
        self.bbbblock(@"1234567890");
    }
}
@end
