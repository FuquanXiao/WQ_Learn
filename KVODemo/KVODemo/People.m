//
//  People.m
//  KVODemo
//
//  Created by apple on 2019/7/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "People.h"
#import <objc/runtime.h>
/**
 Method 成员方法
 Ivar 成员变量
 */
@implementation People

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (BOOL)accessInstanceVariablesDirectly{
    return YES;
}

- (void)setMyAge{
    
}









/**
 每个OC方法内部都他有这两个隐式参数
 objc ：调用者对象
 sel ：方法instanceEat的编号
 */
void instanceEat(id objc,SEL sel){
    NSLog(@"%@",NSStringFromSelector(sel));
    fun();
};

////
void fun(){
    
}
/**
 当一个类x调用了未实现的实例方法，就会调用这里
 */

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    
// 如果没有实现这个方法 使用runtime添加这个方法
    /**
     1、cls  : Class  _Nullable __unsafe_unretained  类类型
     2、name ： SEL  _Nonnull name 方法编号
     3、imp ：IMP  _Nonnull imp  方法实现，就是一个函数指针 指向一个实现
     4、types ： const char * _Nullable types  方法返回值类型 instanceEat是void类型所以此时应该是v
     v    A void
     :    A method selector (SEL)
     @    An object (whether statically typed or typed id)
     
     eg:
     void myMethodIMP(id self, SEL _cmd)
     {
     // implementation ....
     }
     you can dynamically add it to a class as a method (called resolveThisMethodDynamically) like this:
     
     class_addMethod([self class], @selector(resolveThisMethodDynamically), (IMP) myMethodIMP, "v@:");
     
     "v@:" : 返回类型void 参数1：@  参数二 ：
     
     */
    class_addMethod([People class], sel, (IMP)instanceEat, "");
    
    return [super resolveInstanceMethod:sel];
}

/**
 当一个类x调用了未实现的类方法，就会调用这里
 */

+ (BOOL)resolveClassMethod:(SEL)sel{
    return [super resolveClassMethod:sel];
}



- (void)eat{
    NSLog(@"吃东西");
}
@end
