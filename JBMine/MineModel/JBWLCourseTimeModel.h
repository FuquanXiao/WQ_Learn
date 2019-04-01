//
//  JBWLCourseTimeModel.h
//  JBApp
//
//  Created by apple on 2019/3/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLCourseTimeModel : NSObject
@property (nonatomic,strong)NSString *classId;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *weekday;
@property (nonatomic,strong)NSString *startTime;
@property (nonatomic,strong)NSString *endTime;
@property (nonatomic,strong)NSString *classDate;
@property (nonatomic,strong)NSString *courseId;
@property (nonatomic,strong)NSString *curNum;
@property (nonatomic,strong)NSString *createTime;

@property (nonatomic,strong)NSString *weekdayString;

////选择时间
@property (nonatomic,strong)NSMutableArray *weekDayArray;
@property (nonatomic,strong)NSString *afternoon;
@property (nonatomic,strong)NSString *morning;
@property (nonatomic,strong)NSString *evening;
@property (nonatomic,strong)NSMutableArray *scheduleList;
@property (nonatomic,strong)NSString *chooseWeekdayString;

@property (nonatomic,strong)NSString *hadChooseWeekdayTime;

@property (nonatomic,assign)BOOL hadSelected;
@end

NS_ASSUME_NONNULL_END
