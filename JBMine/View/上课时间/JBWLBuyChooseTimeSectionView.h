//
//  JBWLBuyChooseTimeSectionView.h
//  JBApp
//
//  Created by apple on 2019/3/22.
//  Copyright © 2019 apple. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "JBWLCourseTimeViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JBWLBuyChooseTimeSectionView : UIView
@property (nonatomic,strong)UILabel *contentLabel;

- (instancetype)initWithFrame:(CGRect)frame andTimeType:(JBWLBuyChooseTimeType)timeType;
@property (nonatomic,assign)JBWLBuyChooseTimeType timeType;
@property (nonatomic,strong)UIButton *selectedButton;
@end

NS_ASSUME_NONNULL_END
