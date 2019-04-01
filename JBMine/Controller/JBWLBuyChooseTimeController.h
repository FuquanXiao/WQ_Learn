//
//  JBWLBuyChooseTimeController.h
//  JBApp
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 apple. All rights reserved.
//




#import "JBBaseController.h"
#import "JBWLBuyChooseTimeSectionView.h"
#import "JBWLCourseTimeViewModel.h"

#import "JBWLCourseTimeModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface JBWLBuyChooseTimeController : JBBaseController
@property (nonatomic,strong)NSString  *userId;
@property (nonatomic,assign)JBWLBuyChooseTimeType timeType;
@property (nonatomic,strong)JBWLCourseTimeModel *hadSelectedTimeModel;
@property (nonatomic,strong)void (^chooseIdBlock)(JBWLCourseTimeModel *timeModel);

@end

NS_ASSUME_NONNULL_END
