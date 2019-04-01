//
//  JBWLAppointCourseController.h
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBBaseController.h"
#import "JBWLAppointCourseManageController.h"

typedef NS_ENUM(NSInteger,JBWLAppointCourseOrderType){
    JBWLAppointCourseOrderAll = 0,
    JBWLAppointCourseOrderWating,
    JBWLAppointCourseOrderWorking,
    JBWLAppointCourseOrderEnd,
};
NS_ASSUME_NONNULL_BEGIN

@interface JBWLAppointCourseController : JBBaseController
@property (nonatomic,assign)JBWLAppointCourseOrderType orderType;
@property (nonatomic,strong)NSMutableArray *dataSourceArray;
@property (nonatomic,strong)JBWLAppointCourseManageController *managerVC;


- (instancetype)initWithType:(JBWLAppointCourseOrderType)orderType;
- (void)loadDataForFirst;
@end

NS_ASSUME_NONNULL_END
