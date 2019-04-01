//
//  JBWLCourseDetailHeaderView.m
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLCourseDetailHeaderView.h"

@interface JBWLCourseDetailHeaderView()
@property (nonatomic,strong)UIImageView *packUpImageview;
@end

@implementation JBWLCourseDetailHeaderView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor cyanColor];
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
    SDCycleScrollView *cycleScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kSpaceH(210)) imageNamesGroup:nil];
    self.cycleScrollview = cycleScrollview;
    self.cycleScrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.cycleScrollview.localizationImageNamesGroup = @[[UIImage imageNamed:@"MineCenter_PhotoWall_默认"]];
    [self addSubview:cycleScrollview];
    
}

@end
