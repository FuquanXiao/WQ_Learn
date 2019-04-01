//
//  JBWLCourseDetailCourseInfoTableCell.h
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLCourseDetailCourseInfoTableCell : UITableViewCell
@property (nonatomic,strong) UILabel *cellContentLabel;
@property (nonatomic,strong) UIImageView *maskImageView;
@property (nonatomic,strong) UIButton *cellShowAllButton;
@property (nonatomic,strong) NSString *contentString;
+ (CGFloat)getContentHeight:(NSString *)contentString;
@end

NS_ASSUME_NONNULL_END
