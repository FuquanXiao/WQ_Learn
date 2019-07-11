//
//  main.m
//  KVODemo
//
//  Created by apple on 2019/7/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/message.h>
#import "People.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
        
     People *p = objc_msgSend(objc_msgSend(objc_getClass("People"), sel_registerName("alloc")), sel_registerName("init"));
        
        [p setValue:@"liu" forKey:@"namea"];
        
        NSLog(@"%@",p.namea);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
