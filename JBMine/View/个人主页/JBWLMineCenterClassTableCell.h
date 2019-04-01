//
//  JBWLMineCenterClassTableCell.h
//  JBApp
//
//  Created by apple on 2019/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBWLUserCourseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JBWLMineCenterClassTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellLine;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellPeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellCourseStatusLabel;

@property (nonatomic,strong)JBWLUserCourseModel *courseModel;

@end

NS_ASSUME_NONNULL_END
