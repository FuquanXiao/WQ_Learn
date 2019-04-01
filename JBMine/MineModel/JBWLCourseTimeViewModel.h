//
//  JBWLCourseTimeViewModel.h
//  JBApp
//
//  Created by apple on 2019/3/28.
//  Copyright © 2019 apple. All rights reserved.
//
typedef NS_ENUM(NSInteger,JBWLBuyChooseTimeType) {
    ///选择时间
    JBWLBuyChooseTimeChoose,
    ///添加时间
    JBWLBuyChooseTimeTypeAdd,
};


#import <Foundation/Foundation.h>
#import "JBWLCourseTimeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JBWLCourseTimeViewModel : NSObject
/**
 新增课程时间
 接口地址：usersCourse/addUsersSchedule
 请求方式：post
 */
- (void)loadAddCourseTimeWithWeekday:(NSString *)weekday andStartTime:(NSString *)startTime  andEndTime:(NSString *)endTime  completion:(JBCompletionModelCallBack)callBack;

/**
 老师自己获取自己的空闲时间列表
 接口地址：usersCourse/addUsersSchedule
 请求方式：post
 */
- (void)loadGetTeachTimeScheduleCompletion:(JBCompletionModelCallBack)callBack;


/**
 学生获取老师的空闲时间列表
 报名上课用时间表
 
 接口地址：usersCourse/getTeacherSchdule4Student
 请求方式：post
 */
- (void)loadStuedentGetTeachTimeScheduleWithUserId:(NSString *)userId completion:(JBCompletionModelCallBack)callBack;

/**
 删除课程时间
 
 接口地址：usersCourse/delUsersSchedule
 请求方式：post
 
 */
- (void)loadDelUsersScheduleWithUserId:(NSString *)timeId completion:(JBCompletionModelCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
