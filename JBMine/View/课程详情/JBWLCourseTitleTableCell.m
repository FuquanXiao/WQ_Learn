//
//  JBWLCourseTitleTableCell.m
//  JBApp
//
//  Created by xfq on 2019/3/30.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "JBWLCourseTitleTableCell.h"

@interface JBWLCourseTitleTableCell()

@property (nonatomic,strong)UIImageView *cycleCornorImageView;

@end


@implementation JBWLCourseTitleTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
                [self _creteUI];
        self.backgroundColor = colorE7E7E7;
    }
    return self;
}


- (void)setCourseType:(NSInteger)courseType{
    _courseType = courseType;
    
    
    if (courseType == 1 || courseType == 3) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cycleCornorImageView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kSpaceH(10), kSpaceH(10))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.cycleCornorImageView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.cycleCornorImageView.layer.mask = maskLayer;
        [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kSpaceH(15));
            make.left.mas_equalTo(kSpaceH(10));
            make.height.mas_equalTo(kSpaceH(45));
            make.right.mas_equalTo(self.mas_right).mas_offset(-kSpaceH(10));
        }];
    }
    else{
        [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kSpaceH(0));
            make.left.mas_equalTo(kSpaceH(10));
            make.height.mas_equalTo(kSpaceH(45));
            make.right.mas_equalTo(self.mas_right).mas_offset(-kSpaceH(10));
        }];
    }
    
    
}

- (void)_creteUI{
    
    UIImageView *cycleCornorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSpaceH(0), kSpaceH(0), kScreenWidth, kSpaceH(60))];
    cycleCornorImageView.backgroundColor = [UIColor whiteColor];
    self.cycleCornorImageView = cycleCornorImageView;
    [self addSubview:cycleCornorImageView];
    cycleCornorImageView.userInteractionEnabled = YES;
    
    [self.cycleCornorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(self);
        make.right.mas_equalTo(0);
    }];
    
    
    
     self.cellTitleLabel = [UILabel  createLabelWithFrame:CGRectZero text:@"金融工具与风险管理" textColor:color444444 font:[UIFont boldSystemFontOfSize:kSpaceH(24)] textAlignment:NSTextAlignmentLeft];
    [cycleCornorImageView addSubview:self.cellTitleLabel];
    self.cellTitleLabel.backgroundColor = [UIColor whiteColor];
    
   

}

@end
