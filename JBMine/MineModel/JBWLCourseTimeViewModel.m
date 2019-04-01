//
//  JBWLCourseTimeViewModel.m
//  JBApp
//
//  Created by apple on 2019/3/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLCourseTimeViewModel.h"

@implementation JBWLCourseTimeViewModel
/**
 新增课程时间
 接口地址：usersCourse/addUsersSchedule
 请求方式：post
 */
- (void)loadAddCourseTimeWithWeekday:(NSString *)weekday andStartTime:(NSString *)startTime  andEndTime:(NSString *)endTime  completion:(JBCompletionModelCallBack)callBack;{
    NSDictionary *params = @{
                             @"weekday":weekday,
                             @"startTime":startTime,
                             @"endTime":endTime
                             };
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersCourse/addUsersSchedule"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        
        if ([model.result integerValue] == 200) {
            
            
            callBack(SafeValue(model.desc),nil);
        }
        else{
            callBack(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        callBack(nil,error.localizedDescription);
    }];
}

/**
 获取老师空闲时间列表
 接口地址：usersCourse/addUsersSchedule
 请求方式：post
 */
- (void)loadGetTeachTimeScheduleCompletion:(JBCompletionModelCallBack)callBack;{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersCourse/getUsersSchedule"];
    
    [HGHttpManager PostUrl:urlString params:nil successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        
        NSMutableArray *dataSourceArray = [[NSMutableArray alloc] init];
        
        if ([model.result integerValue] == 200) {
            
            NSArray *dataArray = (NSArray *)model.data;
            
            if (![NSObject isEmptyObj:dataArray]) {
                
                for (NSDictionary *courseDict in dataArray) {
                    JBWLCourseTimeModel *courseModel = [JBWLCourseTimeModel mj_objectWithKeyValues:courseDict];
                    [dataSourceArray addObject:courseModel];
                }
            }
            callBack(dataSourceArray,nil);
        }
        else{
            callBack(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        callBack(nil,error.localizedDescription);
    }];
}
/**
 学生获取老师的空闲时间列表
 报名上课用时间表
 
 接口地址：usersCourse/getTeacherSchdule4Student
 请求方式：post
 */
- (void)loadStuedentGetTeachTimeScheduleWithUserId:(NSString *)userId completion:(JBCompletionModelCallBack)callBack{
    NSDictionary *params = @{
                             @"userId":userId
                             };
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersCourse/getTeacherSchdule4Student"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        
        NSMutableArray *dataSourceArray = [[NSMutableArray alloc] init];
        
        if ([model.result integerValue] == 200) {
            
            NSArray *dataArray = (NSArray *)model.data;
            
            if (![NSObject isEmptyObj:dataArray]) {
                
                for (NSDictionary *courseDict in dataArray) {
                    JBWLCourseTimeModel *courseModel = [JBWLCourseTimeModel mj_objectWithKeyValues:courseDict];
                    [dataSourceArray addObject:courseModel];
                    NSArray *childArray = courseDict[@"scheduleList"];
                    
                    NSMutableArray *childModelArray = [[NSMutableArray alloc] init];
                    if (![NSObject isEmptyObj:childArray]) {
                        for (NSDictionary *childCourseDict in childArray) {
                            JBWLCourseTimeModel *childCourseModel = [JBWLCourseTimeModel mj_objectWithKeyValues:childCourseDict];
                            [childModelArray addObject:childCourseModel];
                        }
                    }
                    courseModel.scheduleList = childModelArray;
                }
            }
            callBack(dataSourceArray,nil);
        }
        else{
            callBack(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        callBack(nil,error.localizedDescription);
    }];
}


/**
 删除课程时间
 
 接口地址：usersCourse/delUsersSchedule
 请求方式：post
 */
- (void)loadDelUsersScheduleWithUserId:(NSString *)timeId completion:(JBCompletionModelCallBack)callBack;{
    NSDictionary *params = @{
                             @"id":timeId
                             };
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersCourse/delUsersSchedule"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        
        if ([model.result integerValue] == 200) {
            
            callBack(SafeValue(model.result),nil);
        }
        else{
            callBack(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        callBack(nil,error.localizedDescription);
    }];
}
@end
