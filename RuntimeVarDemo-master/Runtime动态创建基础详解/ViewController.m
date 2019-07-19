//
//  ViewController.m
//  Runtime动态创建基础详解
//
//  Created by apple on 2017/7/14.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self creatHeroClass];
    
      [self createPeopleClass];
    
//    [self fetchPropertyAttributeType];
   
    
    
//    [self createdBasePeopeleClass];
    
    
}

/**
 获取属性的 修饰值
 Property Type String
 
 You can use the property_getAttributes function to discover the name, the @encode type string of a property, and other attributes of the property.
 
 The string starts with a T followed by the @encode type and a comma, and finishes with a V followed by the name of the backing instance variable. Between these, the attributes are specified by the following descriptors, separated by commas
 
 **/

- (void)fetchPropertyAttributeType{
    Person *pp = [[Person alloc] init];
    unsigned int  count = 0;
    objc_property_t *propertys = class_copyPropertyList([Person class], &count);
    for (int i = 0 ; i < count ; i++) {
        objc_property_t pp = propertys[i];
        
        const char *prName = property_getName(pp);
        NSLog(@"%s",prName);
        NSString* attrs = @(property_getAttributes(pp));
        NSLog(@"code: %@", attrs);
    }
    /**
     NSLog:     myTestName
     NSLog:     code: T@"NSString",&,N,V_myTestName
     */
}


- (void)createdBasePeopeleClass{
    
     ///创建一个类名为BasePeople 的类
     Class BasePeople = object_getClass(@"BasePeople");
    
    /**
     <#Class  _Nullable __unsafe_unretained superclass#>
     将要注册类的父类
     <#const char * _Nonnull name#>
     将要注册类的类名字
     <#size_t extraBytes#>
     0
     */
    
  
    // 分配（一组）类，让父类与类相关联
    if (!BasePeople) {
         BasePeople = objc_allocateClassPair([NSObject class], "BasePeople", 0);
    }
    
  

    ///注册类
    objc_registerClassPair(BasePeople);
    ///为BasePeople 类添加属性
    NSString *proName = @"pageString";
    class_addIvar(BasePeople, [proName cStringUsingEncoding:NSUTF8StringEncoding], sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));

    objc_property_attribute_t ownerShip0 = {"T","@\"NSString\""};
    objc_property_attribute_t ownerShip1 = {"N",""};
    objc_property_attribute_t ownerShip2 = {"C",""};
    objc_property_attribute_t ownerShip3 = {"V",[proName cStringUsingEncoding:NSUTF8StringEncoding]};

    objc_property_attribute_t attr[] = {ownerShip0,ownerShip1,ownerShip2,ownerShip3};
    

    
    if (class_addProperty(BasePeople, [proName cStringUsingEncoding:NSUTF8StringEncoding], attr, 4)) {
        /**
         <#const char * _Nullable types#>
         */
        
//        class_addMethod([People class], NSSelectorFromString(@"AAAA"), (IMP)AAAA, "@@:");
//        class_addMethod([People class], NSSelectorFromString(s), (IMP)setter, "v@:@");
        
        class_addMethod([BasePeople class], NSSelectorFromString(@"AAAAA"), (IMP)AAAAA, "@@:");
        class_addMethod([BasePeople class], NSSelectorFromString(@"setAAAAA"), (IMP)setAAAAA, "v@:@");
    }
    
    id instance = [[BasePeople alloc] init];
    
    [instance setValue:@"加油l距离目标不远了" forKey:proName];
    NSLog(@"%@", [instance valueForKey:proName]);
    
}


id  AAAAA (id objc ,SEL sel){
    NSString *key = NSStringFromSelector(sel);
    Ivar ivar = class_getInstanceVariable([objc class], [key cStringUsingEncoding:NSUTF8StringEncoding]);
    NSString *s = object_getIvar(objc, ivar);
    return s;
    
//    Ivar var = class_getInstanceVariable([objc class], [NSStringFromSelector(sel) cStringUsingEncoding:NSUTF8StringEncoding]);
//    NSString *s = object_getIvar(objc, var);
//    return s;
    
}
void setAAAAA(id objc,SEL sel,NSString *newData){
    NSString *key = NSStringFromSelector(sel);

    Ivar ivar = class_getInstanceVariable([objc class], [key cStringUsingEncoding:NSUTF8StringEncoding]);
    object_setIvar(objc, ivar, newData);
    

}









- (void)createPeopleClass{
    //定义一个 Person 类, 继承自 NSObject
    Class People = objc_allocateClassPair([NSObject class], "People", 0);
    NSString *proName = @"name111";
    /**
     [<People 0x6000008cc380> valueForUndefinedKey:]: this class is not key value coding-compliant for the key name111.'
     */
    class_addIvar(People, [proName cStringUsingEncoding:NSUTF8StringEncoding], sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    
    //注册该类
    objc_registerClassPair(People);
    
    

    
    //添加属性
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t attribute2 = {"N",""};//value无意义时通常设置为空

    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", [proName cStringUsingEncoding:NSUTF8StringEncoding] };
    objc_property_attribute_t attrs[] = { type,attribute2,ownership, backingivar };
   
    
    
    if (class_addProperty(People, [proName cStringUsingEncoding:NSUTF8StringEncoding], attrs, 4)) {
        NSString *s = [NSString stringWithFormat:@"set%@:",[proName capitalizedString]];
        //添加get和set方法
        class_addMethod([People class], NSSelectorFromString(@"AAAAA"), (IMP)AAAAA, "@@:");
        class_addMethod([People class], NSSelectorFromString(@"setAAAAA"), (IMP)setAAAAA, "v@:@");
    }
    
   
    
    //获取实例
    id instance = [[People alloc] init];
    [instance setValue:@"中国人民真争气" forKey:@"name111"];
    NSLog(@"%@", [instance valueForKey:@"name111"]);
    
    
    
}

id AAAA(id objc,SEL sel){
    Ivar ivar = class_getInstanceVariable([objc class], [NSStringFromSelector(sel) cStringUsingEncoding:NSUTF8StringEncoding]);
    NSString *s = object_getIvar(objc, ivar);
    return s;
}

id getter(id self1, SEL _cmd1) {
    NSString *key = NSStringFromSelector(_cmd1);
    Ivar ivar = class_getInstanceVariable([self1 class], [key cStringUsingEncoding:NSUTF8StringEncoding]);
    NSString *s = object_getIvar(self1, ivar);
    return s;
}

void setter(id self1, SEL _cmd1, id newValue) {
    //移除set
    NSString *key = [NSStringFromSelector(_cmd1) stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];
    //首字母小写
    NSString *head = [key substringWithRange:NSMakeRange(0, 1)];
    head = [head lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:head];
    //移除后缀 ":"
    key = [key stringByReplacingCharactersInRange:NSMakeRange(key.length - 1, 1) withString:@""];
    
    Ivar ivar = class_getInstanceVariable([self1 class], [key cStringUsingEncoding:NSUTF8StringEncoding]);
    object_setIvar(self1, ivar, newValue);
}




/**************华丽的分割线******************/






- (void)setName111:(NSString *)name111{
    
}

- (NSString *)name111{
    return nil;
}
//get方法
NSString *nameGetter(id self, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([self class], "_name111");
    return object_getIvar(self, ivar);
}

//set方法
void nameSetter(id self, SEL _cmd, NSString *newName) {
    Ivar ivar = class_getInstanceVariable([self class], "_name111");
    id oldName = object_getIvar(self, ivar);
    if (oldName != newName) object_setIvar(self, ivar, [newName copy]);
}



-(void)creatHeroClass{
    /*  创建类
     *  参数1 父类  参数二 类名 参数3关于内存默认
     */
    Class  Hero = objc_allocateClassPair([NSObject class], "Hero", 0);
    
    class_addMethod(Hero, @selector(R:), (IMP)R, "@@:@");//添加方法
    
    class_addIvar(Hero, "Q", sizeof(NSString *), 0, "@");//添加成员变量
    class_addIvar(Hero, "W", sizeof(NSString *), 0, "@");//添加成员变量
    
    //添加属性实现setter  getter方法
    class_addMethod(Hero, @selector(setW:), (IMP)setW, "v@:@");
    class_addMethod(Hero, @selector(getW), (IMP)getW, "@@:");
    
    //注册类
    objc_registerClassPair(Hero);
    
    //实例化应用
    id hanbing = [[Hero alloc]init];
    
    //objc_setAssociatedObject 绑定key  value
    objc_setAssociatedObject(hanbing, @"beidong", @"寒冰的被动", OBJC_ASSOCIATION_COPY);
    NSLog(@"%@",objc_getAssociatedObject(hanbing, @"beidong"));
    
    //通过kvc设置上面定义的成员变量
    [hanbing setValue:@"寒冰射手的Q" forKey:@"Q"];
    
    [hanbing setW:@"寒冰的w"];
    NSLog(@"%@",[hanbing getW]);
    
    //类的属性
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "E" };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    class_addProperty(Hero, "E", attrs, 3);
    
    //遍历属性查看
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([Hero class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "Hero获取所有属性 %s : %s\n", property_getName(property), property_getAttributes(property));
    }
    
    
    
      NSLog(@"%@", [hanbing name111]);
    
    
    [hanbing R:@"德玛西亚"];
}

#pragma mark  OC方法

//OC方法不会调用，但是必须得写。实际调用IMP针织实现。
-(void)setW:(NSString *)w{
    
}

-(NSString *)getW{
    return nil;
}

-(NSString *)R:(NSString *)emery{
    
    return nil;
}

#pragma mark  IMP方法

void setW(id self,SEL cmd,NSString * str){
    Ivar  w = class_getInstanceVariable([self class], "W");
    NSString * oldW = object_getIvar(self, w);
    if (oldW!=str) {
        object_setIvar(self, w, [str copy]);
    }
}

NSString * getW(id self,SEL cmd){
    Ivar  w = class_getInstanceVariable([self class], "W");
    return object_getIvar(self, w);
}

id R(id self,SEL cmd,id emery){
    Ivar v  = class_getInstanceVariable([self class], "Q");
    NSString * vStr = object_getIvar(self, v);
    NSString * result = [NSString stringWithFormat:@"%@R死了%@",vStr,emery];
    NSLog(@"%@", result);
    return [NSString stringWithFormat:@"R死了%@",emery];
}

@end
