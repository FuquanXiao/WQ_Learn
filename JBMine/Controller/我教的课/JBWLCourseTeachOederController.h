//
//  JBWLCourseTeachOederController.h
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,JBWLCourseTeachOrderType){
    JBWLCourseTeachOrderAll = 0,
    JBWLCourseTeachOrderWating,
    JBWLCourseTeachOrderWorking,
    JBWLCourseTeachOrderEnd,
};

NS_ASSUME_NONNULL_BEGIN

@interface JBWLCourseTeachOederController : JBBaseController

@property (nonatomic,assign)JBWLCourseTeachOrderType orderType;
@property (nonatomic,strong)NSMutableArray *dataSourceArray;


- (instancetype)initWithType:(JBWLCourseTeachOrderType)orderType;
- (void)loadDataForFirst;
@end

NS_ASSUME_NONNULL_END
