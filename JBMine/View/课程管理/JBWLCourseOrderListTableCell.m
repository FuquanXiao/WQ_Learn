//
//  JBWLCourseOrderListTableCell.m
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLCourseOrderListTableCell.h"

@implementation JBWLCourseOrderListTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _createUI];
    }
    return self;
}

- (void)buttonAction:(UIButton *)btn{
    
}

- (void)_createUI{
    
    self.cellIconImageView = [[UIImageView alloc] init];
    
    self.cellUserNameLabel =  [UILabel  createLabelWithFrame:CGRectZero text:@"半夏如烟" textColor:color666666 font:font13 textAlignment:NSTextAlignmentLeft];
    
    self.cellOrderStatusLabel =  [UILabel  createLabelWithFrame:CGRectZero text:@"已结束" textColor:color444444 font:font12 textAlignment:NSTextAlignmentCenter];
    
    
    self.cellTitleLabel = [UILabel  createLabelWithFrame:CGRectZero text:@"父母一生必听的11节课" textColor:color444444 font:font17 textAlignment:NSTextAlignmentLeft];
    
    self.cellClassTimeLabel = [UILabel  createLabelWithFrame:CGRectZero text:@"上课时间：2019/03/19  周二  14:00" textColor:color666666 font:font12 textAlignment:NSTextAlignmentLeft];
    
      self.cellClassAddressLabel = [UILabel  createLabelWithFrame:CGRectZero text:@"上课地点：浙江省杭州市拱墅区中国智慧信息产业园" textColor:color666666 font:font12 textAlignment:NSTextAlignmentLeft];
    
    
    self.cellOrderTimeLabel = [UILabel  createLabelWithFrame:CGRectZero text:@"2018/09/07  15:03" textColor:color999999 font:font11 textAlignment:NSTextAlignmentLeft];
    
    self.cellRightButton = [UIButton createButtonWithFrame:CGRectZero withTitle:@"提前聊聊" withTitleColor:color00CCBB withTitleFont:kSpaceH(12) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
    
    self.cellMiddeleButton = [UIButton createButtonWithFrame:CGRectZero withTitle:@"进入课堂" withTitleColor:kUIColorFromRGB(0xFF6E04) withTitleFont:kSpaceH(12) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
    
    
    self.cellLeftButton = [UIButton createButtonWithFrame:CGRectZero withTitle:@"取消报名" withTitleColor:kUIColorFromRGB(0xFFBA00) withTitleFont:kSpaceH(12) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
    
    
    
    self.cellRightButton.tag = 401;
    self.cellMiddeleButton.tag = 402;
    self.cellLeftButton.tag = 403;
    
    self.cellRightButton.layer.cornerRadius = kSpaceW(12.5);
    self.cellRightButton.clipsToBounds = YES;
    self.cellRightButton.layer.borderWidth = 1;
    self.cellRightButton.layer.borderColor = color00CCBB.CGColor;
    
    self.cellMiddeleButton.layer.borderWidth = 1;
    self.cellMiddeleButton.layer.borderColor = kUIColorFromRGB(0xFF6E04).CGColor;
    self.cellMiddeleButton.layer.cornerRadius = kSpaceW(12.5);
    self.cellMiddeleButton.clipsToBounds = YES;
    
    self.cellLeftButton.layer.borderWidth = 1;
    self.cellLeftButton.layer.borderColor = kUIColorFromRGB(0xFFBA00).CGColor;
    self.cellLeftButton.layer.cornerRadius = kSpaceW(12.5);
    self.cellLeftButton.clipsToBounds = YES;
    
    NSMutableParagraphStyle *style=  [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = kSpaceW(8);
    

    
    [self addSubview:self.cellIconImageView];
    [self addSubview:self.cellUserNameLabel];
    [self addSubview:self.cellOrderStatusLabel];
    [self addSubview:self.cellTitleLabel];
    [self addSubview:self.cellClassTimeLabel];
    [self addSubview:self.cellClassAddressLabel];
    [self addSubview:self.cellOrderTimeLabel];
    [self addSubview:self.cellRightButton];
    [self addSubview:self.cellMiddeleButton];
    [self addSubview:self.cellLeftButton];
    
    MASAttachKeys(self.cellIconImageView);
    MASAttachKeys(self.cellUserNameLabel);
    MASAttachKeys(self.cellOrderStatusLabel);
    MASAttachKeys(self.cellTitleLabel);
    MASAttachKeys(self.cellClassTimeLabel);
    MASAttachKeys(self.cellClassAddressLabel);
    MASAttachKeys(self.cellOrderTimeLabel);
    MASAttachKeys(self.cellRightButton);
    MASAttachKeys(self.cellMiddeleButton);
    MASAttachKeys(self.cellLeftButton);

    
    self.cellOrderStatusLabel.layer.cornerRadius = kSpaceH(9);
    self.cellOrderStatusLabel.backgroundColor = color00CCBB;
    self.cellOrderStatusLabel.textColor = colorFFFFFF;
    self.cellOrderStatusLabel.clipsToBounds = YES;
    
   
    
    [self.cellIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kSpaceH(10));
        make.left.mas_equalTo(kSpaceH(15));
        make.height.mas_equalTo(kSpaceH(25));
        make.width.mas_equalTo(kSpaceH(25));
    }];
    
    [self.cellUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cellIconImageView);
        make.left.mas_equalTo(self.cellIconImageView.mas_right).mas_offset(kSpaceW(15));
        make.height.mas_equalTo(self.cellIconImageView);
        make.width.mas_lessThanOrEqualTo(100);
    }];
    
    [self.cellOrderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cellIconImageView);
        make.right.mas_equalTo(self.mas_right).mas_offset(-kSpaceW(15));
        make.height.mas_equalTo(kSpaceH(18));
    }];
    
     CGSize size = [self.cellOrderStatusLabel.text sizeWithAttributes:@{NSFontAttributeName:font12}];
    [self.cellOrderStatusLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width + 18);
    }];
    
    
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cellIconImageView.mas_bottom).mas_offset(kSpaceH(15));
        make.left.mas_equalTo( kSpaceW(10));
        make.height.mas_equalTo(kSpaceH(16));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kSpaceH(15));
    }];

    [self.cellClassTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cellTitleLabel.mas_bottom).mas_offset(kSpaceH(18));
        make.left.mas_equalTo(self.cellTitleLabel);
        make.height.mas_equalTo(kSpaceH(12));
        make.right.mas_equalTo(self.cellTitleLabel);
    }];
    
    [self.cellClassAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cellClassTimeLabel.mas_bottom).mas_offset(kSpaceH(10));
        make.left.mas_equalTo(self.cellTitleLabel);
        make.height.mas_equalTo(kSpaceH(12)).priority(750);
        make.right.mas_equalTo(self.cellTitleLabel);
    }];

    
    [self.cellRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-kSpaceH(15));
        make.width.mas_equalTo(kSpaceH(70));
        make.height.mas_equalTo(kSpaceH(25));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kSpaceH(10));
    }];
    
    [self.cellMiddeleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.cellRightButton);
        make.width.height.mas_equalTo(self.cellRightButton);
        make.right.mas_equalTo(self.cellRightButton.mas_left).mas_offset(-kSpaceH(15));
    }];
    
    
    [self.cellLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.cellRightButton);
        make.width.height.mas_equalTo(self.cellRightButton);
        make.right.mas_equalTo(self.cellMiddeleButton.mas_left).mas_offset(-kSpaceH(15));
    }];
    
    
    [self.cellOrderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.cellRightButton);
        make.right.mas_equalTo(self.cellLeftButton.mas_left).mas_offset(-kSpaceH(5));
        make.left.mas_equalTo(self).mas_offset(kSpaceH(10));
    }];
   
}


@end
