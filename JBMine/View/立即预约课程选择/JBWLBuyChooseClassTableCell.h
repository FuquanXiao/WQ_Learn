//
//  JBWLBuyChooseClassTableCell.h
//  JBApp
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBWLUserCourseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JBWLBuyChooseClassTableCell : UITableViewCell
@property (nonatomic,strong)UIImageView *chooseImageView;
@property (nonatomic,strong)JBWLUserCourseModel *courseModel;
@end

NS_ASSUME_NONNULL_END
