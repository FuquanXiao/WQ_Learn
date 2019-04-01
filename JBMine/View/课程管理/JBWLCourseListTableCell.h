//
//  JBWLCourseListTableCell.h
//  JBApp
//
//  Created by apple on 2019/3/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLCourseListTableCell : UITableViewCell
@property (nonatomic,strong)  UIImageView *cellLine;
@property (nonatomic,strong)  UILabel *cellTitleLabel;
@property (nonatomic,strong)  UILabel *cellContentLabel;
@property (nonatomic,strong)  UILabel *cellMoneyLabel;
@property (nonatomic,strong)  UIButton *cellDeleteButton;
@property (nonatomic,strong)  UIButton *cellEditButton;
@property (nonatomic,strong)  NSIndexPath *cellIndexPath;
@end

NS_ASSUME_NONNULL_END
