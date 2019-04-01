//
//  JBWLUserCourseModel.m
//  JBApp
//
//  Created by apple on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLUserCourseModel.h"

@implementation JBWLUserCourseModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"courseId":@"id"
             };
}
@end
