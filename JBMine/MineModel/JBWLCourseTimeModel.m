//
//  JBWLCourseTimeModel.m
//  JBApp
//
//  Created by apple on 2019/3/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLCourseTimeModel.h"

@implementation JBWLCourseTimeModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"classId":@"id"
             };
}

- (NSString *)weekdayString{
    NSString *dateString = @"";
    NSString *wee = @"";
    if (SafeValue(self.classDate).length > 5) {
        dateString = [SafeValue(self.classDate) substringFromIndex:5];
        dateString = [NSString stringWithFormat:@"(%@)",dateString];
    }
    if ([SafeValue(self.weekday) integerValue] == 1) {
        
        wee =  @"周一";
    }
    if ([SafeValue(self.weekday) integerValue] == 2) {
        wee =  @"周二";
    }
    if ([SafeValue(self.weekday) integerValue] == 3) {
        wee =   @"周三";
    }
    if ([SafeValue(self.weekday) integerValue] == 4) {
        wee =   @"周四";
    }
    if ([SafeValue(self.weekday) integerValue] == 5) {
        wee =   @"周五";
    }
    if ([SafeValue(self.weekday) integerValue] == 6) {
        wee =   @"周六";
    }
    if ([SafeValue(self.weekday) integerValue] == 7) {
        wee =   @"周日";
    }
    return wee ;//[NSString stringWithFormat: @"%@%@",wee,dateString];
}

- (NSString *)chooseWeekdayString{
    NSString *dateString = @"";
    NSString *wee = @"";
    if (SafeValue(self.classDate).length > 5) {
        dateString = [SafeValue(self.classDate) substringFromIndex:5];
        dateString = [NSString stringWithFormat:@"(%@)",dateString];
    }
    if ([SafeValue(self.weekday) integerValue] == 1) {
        
        wee =  @"周一";
    }
    if ([SafeValue(self.weekday) integerValue] == 2) {
        wee =  @"周二";
    }
    if ([SafeValue(self.weekday) integerValue] == 3) {
        wee =   @"周三";
    }
    if ([SafeValue(self.weekday) integerValue] == 4) {
        wee =   @"周四";
    }
    if ([SafeValue(self.weekday) integerValue] == 5) {
        wee =   @"周五";
    }
    if ([SafeValue(self.weekday) integerValue] == 6) {
        wee =   @"周六";
    }
    if ([SafeValue(self.weekday) integerValue] == 7) {
        wee =   @"周日";
    }
    return [NSString stringWithFormat: @"%@%@",wee,dateString];
}

- (NSString *)hadChooseWeekdayTime{
    
    NSString *monthString = @"";
    NSString *dayString = @"";
    NSString *wee = @"";
    if (SafeValue(self.classDate).length >= 10) {
       monthString = [SafeValue(self.classDate) substringWithRange:NSMakeRange(5, 2)];
       dayString = [SafeValue(self.classDate) substringWithRange:NSMakeRange(8, 2)];
    }
    if ([SafeValue(self.weekday) integerValue] == 1) {
        
        wee =  @"周一";
    }
    if ([SafeValue(self.weekday) integerValue] == 2) {
        wee =  @"周二";
    }
    if ([SafeValue(self.weekday) integerValue] == 3) {
        wee =   @"周三";
    }
    if ([SafeValue(self.weekday) integerValue] == 4) {
        wee =   @"周四";
    }
    if ([SafeValue(self.weekday) integerValue] == 5) {
        wee =   @"周五";
    }
    if ([SafeValue(self.weekday) integerValue] == 6) {
        wee =   @"周六";
    }
    if ([SafeValue(self.weekday) integerValue] == 7) {
        wee =   @"周日";
    }
    return [NSString stringWithFormat: @"%@月%@日   %@",monthString,dayString,wee];
    
    
}

@end
