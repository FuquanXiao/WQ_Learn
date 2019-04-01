//
//  main.m
//  MyStudy
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019年 apple. All rights reserved.
//   我是dev分支
/// dev 上面重新拉了分支
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        NSObject *obj = [[NSObject alloc] init];
//
//        id __weak obj1 = obj;
        
        
        void (^MyStudyBlk)(void) = ^{
            printf("Block\n");
        };
        MyStudyBlk();
        
    }
    return 0;
}
