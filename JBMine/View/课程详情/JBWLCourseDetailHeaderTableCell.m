//
//  JBWLCourseDetailHeaderTableCell.m
//  JBApp
//
//  Created by xfq on 2019/3/30.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "JBWLCourseDetailHeaderTableCell.h"

@implementation JBWLCourseDetailHeaderTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _creteUI];
    }
    return self;
}

- (void)_creteUI{
    [self _createBanner];
    UIImageView *cycleCornorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kSpaceH(190), kScreenWidth, kSpaceH(20))];
    cycleCornorImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:cycleCornorImageView];
    cycleCornorImageView.userInteractionEnabled = YES;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cycleCornorImageView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kSpaceH(10), kSpaceH(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cycleCornorImageView.bounds;
    maskLayer.path = maskPath.CGPath;
    cycleCornorImageView.layer.mask = maskLayer;
    
}

#pragma mark
#pragma mark-------bannner -------
- (void)_createBanner{
    SDCycleScrollView *cycleScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kSpaceH(200)) imageNamesGroup:nil];
    self.cycleScrollview = cycleScrollview;
    self.cycleScrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.cycleScrollview.localizationImageNamesGroup = @[[UIImage imageNamed:@"MineCenter_PhotoWall_默认"]];
    [self addSubview:cycleScrollview];
    
}


@end
