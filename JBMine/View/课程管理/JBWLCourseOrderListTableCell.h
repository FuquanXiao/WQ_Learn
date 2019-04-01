//
//  JBWLCourseOrderListTableCell.h
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLCourseOrderListTableCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *cellIconImageView;
@property (nonatomic,strong)  UILabel *cellUserNameLabel;
@property (nonatomic,strong)  UILabel *cellOrderStatusLabel;

@property (nonatomic,strong)  UILabel *cellTitleLabel;
@property (nonatomic,strong)  UILabel *cellClassTimeLabel;


@property (nonatomic,strong)  UILabel *cellClassAddressLabel;

@property (nonatomic,strong)  UILabel *cellOrderTimeLabel;

@property (nonatomic,strong)  UIButton *cellRightButton;
@property (nonatomic,strong)  UIButton *cellMiddeleButton;
@property (nonatomic,strong)  UIButton *cellLeftButton;

@property (nonatomic,strong)  NSIndexPath *cellIndexPath;
@end

NS_ASSUME_NONNULL_END
