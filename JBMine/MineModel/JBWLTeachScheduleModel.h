//
//  JBWLTeachScheduleModel.h
//  JBApp
//
//  Created by apple on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//个人主页课程时间表

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLTeachScheduleModel : NSObject
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *weekday;
@property (nonatomic,strong)NSString *classDate;
@property (nonatomic,strong)NSString *morning;
@property (nonatomic,strong)NSString *afternoon;
@property (nonatomic,strong)NSString *evening;


///写get方法，转成展示的格式
@property (nonatomic,strong)NSString *weekdayString;
@property (nonatomic,strong)NSString *morningString;
@property (nonatomic,strong)NSString *afternoonString;
@property (nonatomic,strong)NSString *eveningString;


@end

NS_ASSUME_NONNULL_END
