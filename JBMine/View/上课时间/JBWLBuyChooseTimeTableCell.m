//
//  JBWLBuyChooseTimeTableCell.m
//  JBApp
//
//  Created by apple on 2019/3/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLBuyChooseTimeTableCell.h"

@interface JBWLBuyChooseTimeTableCell()

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIImageView *cycleImageView;
@property (nonatomic,strong)UILabel *contentLabel;


@end



@implementation JBWLBuyChooseTimeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self _createUI];
    }
    return self;
}

- (void)setTimeModel:(JBWLCourseTimeModel *)timeModel{
    _timeModel = timeModel;
    self.contentLabel.text = [NSString stringWithFormat:@"%@ - %@",SafeValue(_timeModel.startTime),SafeValue(_timeModel.endTime)];
    
    if (self.timeType == JBWLBuyChooseTimeChoose) {
        if (timeModel.hadSelected) {
            [self.selectedButton setImage:[UIImage imageNamed:@"JBWL_ChooseTime_Delected"] forState:UIControlStateNormal];
        }
        else{
            [self.selectedButton setImage:[UIImage imageNamed:@"JBWL_ChooseTime_Normal"] forState:UIControlStateNormal];
        }
    }
    else{
         [self.selectedButton setImage:[UIImage imageNamed:@"JBWL_ChooseTime_Delete"] forState:UIControlStateNormal];
    }
}


- (void)_createUI{
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    
    UIImageView *cycleImageView = [[UIImageView alloc] init];
    [self addSubview:cycleImageView];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    [self addSubview:contentLabel];
    
    UIButton *selectedButton = [[UIButton alloc] init];
    [self addSubview:selectedButton];
    
    self.lineView = lineView;
    self.cycleImageView = cycleImageView;
    self.contentLabel = contentLabel;
    self.selectedButton = selectedButton;
    
    lineView.backgroundColor = color00CCBB;
    cycleImageView.backgroundColor = kUIColorFromRGB(0xFF9000);
    cycleImageView.layer.cornerRadius = 3;
    cycleImageView.clipsToBounds = YES;
    contentLabel.textColor = color444444;
    contentLabel.font = font17;
    
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(1);
        make.left.mas_equalTo(kSpaceH(20));
    }];
    
    [cycleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(kSpaceH(59));
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(cycleImageView.mas_right).mas_offset(kSpaceH(10));
    }];
    [contentLabel sizeToFit];
    
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(kSpaceH(16));
        make.left.mas_equalTo(contentLabel.mas_right).mas_offset(kSpaceH(15));
    }];
    selectedButton.titleLabel.font = font10;
    [selectedButton sizeToFit];
    
}

- (void)setTimeType:(JBWLBuyChooseTimeType)timeType{
    _timeType = timeType;
    if (self.timeType == JBWLBuyChooseTimeChoose) {
        [self.selectedButton setImage:[UIImage imageNamed:@"JBWL_ChooseTime_Normal"] forState:UIControlStateNormal];
    }
}


@end
