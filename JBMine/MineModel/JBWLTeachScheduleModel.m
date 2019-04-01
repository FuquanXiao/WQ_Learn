//
//  JBWLTeachScheduleModel.m
//  JBApp
//
//  Created by apple on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLTeachScheduleModel.h"

@implementation JBWLTeachScheduleModel

- (NSString *)morningString{
    if ([SafeValue(self.morning) integerValue] == 1) {
        return @"";
    }
    if ([SafeValue(self.morning) integerValue] == 2) {
        return @"可约";
    }
    if ([SafeValue(self.morning) integerValue] == 3) {
        return @"约满";
    }
    return @"";
}

- (NSString *)afternoonString{
    if ([SafeValue(self.afternoon) integerValue] == 1) {
        return @"";
    }
    if ([SafeValue(self.afternoon) integerValue] == 2) {
        return @"可约";
    }
    if ([SafeValue(self.afternoon) integerValue] == 3) {
        return @"约满";
    }
    return @"";
}
- (NSString *)eveningString{
    if ([SafeValue(self.evening) integerValue] == 1) {
        return @"";
    }
    if ([SafeValue(self.evening) integerValue] == 2) {
        return @"可约";
    }
    if ([SafeValue(self.evening) integerValue] == 3) {
        return @"约满";
    }
    return @"";
}

- (NSString *)weekdayString{
    if ([SafeValue(self.weekday) integerValue] == 1) {
        return @"周一";
    }
    if ([SafeValue(self.weekday) integerValue] == 2) {
        return @"周二";
    }
    if ([SafeValue(self.weekday) integerValue] == 3) {
        return @"周三";
    }
    if ([SafeValue(self.weekday) integerValue] == 4) {
        return @"周四";
    }
    if ([SafeValue(self.weekday) integerValue] == 5) {
        return @"周五";
    }
    if ([SafeValue(self.weekday) integerValue] == 6) {
        return @"周六";
    }
    if ([SafeValue(self.weekday) integerValue] == 7) {
        return @"周日";
    }
    return @"";
}
@end
