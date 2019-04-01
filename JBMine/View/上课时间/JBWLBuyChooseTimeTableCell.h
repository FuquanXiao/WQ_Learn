//
//  JBWLBuyChooseTimeTableCell.h
//  JBApp
//
//  Created by apple on 2019/3/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBWLCourseTimeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JBWLBuyChooseTimeTableCell : UITableViewCell
@property (nonatomic,assign)JBWLBuyChooseTimeType timeType;
@property (nonatomic,strong)UIButton *selectedButton;
@property (nonatomic,strong)JBWLCourseTimeModel *timeModel;
@end

NS_ASSUME_NONNULL_END
