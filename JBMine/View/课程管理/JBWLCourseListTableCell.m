//
//  JBWLCourseListTableCell.m
//  JBApp
//
//  Created by apple on 2019/3/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLCourseListTableCell.h"

@implementation JBWLCourseListTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _createUI];
    }
    return self;
}

- (void)buttonAction:(UIButton *)btn{
    
}

- (void)_createUI{
    self.cellTitleLabel = [UILabel  createLabelWithFrame:CGRectZero text:@"父母一生必听的11节课" textColor:color444444 font:font17 textAlignment:NSTextAlignmentLeft];
    
    self.cellContentLabel = [UILabel  createLabelWithFrame:CGRectZero text:@"韩国国会军军扩绿绿绿绿回家客流量吴桥到家吧吗现在小宝贝抽 点时间了韩国国会军军扩绿绿绿绿回家客..." textColor:color666666 font:font12 textAlignment:NSTextAlignmentLeft];
    
    self.cellMoneyLabel = [UILabel  createLabelWithFrame:CGRectZero text:@"¥30" textColor:color00CCBB font:font15 textAlignment:NSTextAlignmentLeft];
    
    self.cellEditButton = [UIButton createButtonWithFrame:CGRectZero withTitle:@"编辑课程" withTitleColor:color00CCBB withTitleFont:kSpaceH(12) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];

    self.cellDeleteButton = [UIButton createButtonWithFrame:CGRectZero withTitle:@"删除课程" withTitleColor:kUIColorFromRGB(0xff3f04) withTitleFont:kSpaceH(12) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
    
    self.cellContentLabel.numberOfLines = 2;
    
    self.cellDeleteButton.tag = 401;
    self.cellEditButton.tag = 402;
    
    self.cellDeleteButton.layer.cornerRadius = kSpaceW(12.5);
    self.cellDeleteButton.clipsToBounds = YES;
    self.cellDeleteButton.layer.borderWidth = 1;
    self.cellEditButton.layer.borderWidth = 1;
    self.cellEditButton.layer.borderColor = color00CCBB.CGColor;
    self.cellDeleteButton.layer.borderColor = kUIColorFromRGB(0xff3f04).CGColor;

    self.cellEditButton.layer.cornerRadius = kSpaceW(12.5);
    self.cellEditButton.clipsToBounds = YES;
    
    NSMutableParagraphStyle *style=  [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = kSpaceW(8);
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.cellContentLabel.text];
    [attribute addAttributes:@{NSParagraphStyleAttributeName:style} range:NSMakeRange(0, self.cellContentLabel.text.length)];
    self.cellContentLabel.attributedText = attribute;

    [self addSubview:self.cellTitleLabel];
    [self addSubview:self.cellContentLabel];
    [self addSubview:self.cellMoneyLabel];
    [self addSubview:self.cellEditButton];
    [self addSubview:self.cellDeleteButton];

    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kSpaceH(18));
        make.left.mas_equalTo(kSpaceH(15));
        make.height.mas_equalTo(kSpaceH(16));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kSpaceH(15));
    }];
    
    [self.cellEditButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-kSpaceH(10));
        make.width.mas_equalTo(kSpaceH(70));
        make.height.mas_equalTo(kSpaceH(25));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kSpaceH(15));
    }];
    
    [self.cellDeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.cellEditButton);
        make.height.and.width.mas_equalTo(self.cellEditButton);
        make.right.mas_equalTo(self.cellEditButton.mas_left).mas_offset(-kSpaceH(13));
    }];
    
   
    
    [self.cellContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cellTitleLabel.mas_bottom).mas_offset(kSpaceH(18));
        make.left.right.mas_equalTo(self.cellTitleLabel);
        make.bottom.mas_equalTo(self.cellEditButton.mas_top).mas_offset(-kSpaceH(18));
    }];
    
    [self.cellMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cellTitleLabel);
        make.height.mas_equalTo(self.cellEditButton);
        make.centerY.mas_equalTo(self.cellEditButton);
        make.width.mas_lessThanOrEqualTo(kSpaceW(100));
    }];
    
}
@end
