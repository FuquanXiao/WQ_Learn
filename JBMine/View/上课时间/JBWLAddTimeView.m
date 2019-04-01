//
//  JBWLAddTimeView.m
//  JBApp
//
//  Created by apple on 2019/3/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLAddTimeView.h"

@interface JBWLAddTimeView()
@property (nonatomic,strong)UILabel *cellMoneyLabel;

@property (nonatomic,strong)UILabel *lineLable;
@end



@implementation JBWLAddTimeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self loadContentView];
    }
    return self;
}

- (void)nextButtonAction{
    
}


- (void)closeButtonAction{
    [self removeFromSuperview];
}

- (void)loadContentView{
    
    UIButton *closeButton = [[UIButton alloc] init];
    [self addSubview:closeButton];
    [closeButton setImage:[UIImage imageNamed:@"Pay_Password_close_icon"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *contentView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:contentView];
    contentView.userInteractionEnabled = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = kSpaceW(10);
    contentView.clipsToBounds = YES;
    
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(contentView.mas_right);
        make.bottom.mas_equalTo(contentView.mas_top).mas_offset(-kSpaceH(10));
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSpaceW(319));
        make.height.mas_equalTo(kSpaceH(238));
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    
    self.cellMoneyLabel = [UILabel  createLabelWithFrame:CGRectZero text:@"选择您可上课的时间段" textColor:color00CCBB font:font15 textAlignment:NSTextAlignmentCenter];
    [contentView addSubview:self.cellMoneyLabel];
    
    [self.cellMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView).mas_offset(kSpaceH(30));
        make.right.left.mas_equalTo(0);
    }];
    
    
    UIButton *minTextField = [[UIButton alloc] init];
    [minTextField setTitle:@"最早开始时间" forState:UIControlStateNormal];
    UILabel *lineLable = [[UILabel alloc] init];
    self.minTextField = minTextField;
    UIButton *maxTextField = [[UIButton alloc] init];
    self.maxTextField = maxTextField;
    [maxTextField setTitle:@"最晚结束时间" forState:UIControlStateNormal];

    self.maxTextField.contentHorizontalAlignment =
    self.minTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    lineLable.backgroundColor = colorCCCCCC;
    self.lineLable = lineLable;
    [contentView addSubview:minTextField];
    
    [contentView addSubview:lineLable];
    [contentView addSubview:maxTextField];
    minTextField.tag = 456;
    maxTextField.tag = 457;
    
    
    [minTextField setTitleColor:colorCCCCCC forState:UIControlStateNormal];
    [maxTextField setTitleColor:colorCCCCCC forState:UIControlStateNormal];

    minTextField.titleLabel.font = font12;
    maxTextField.titleLabel.font = font12;
    
    lineLable.textColor = colorE7E7E7;
    lineLable.textAlignment = NSTextAlignmentCenter;
    
    
    minTextField.layer.cornerRadius =
    maxTextField.layer.cornerRadius = kSpaceH(15);
    
    minTextField.layer.borderColor =
    maxTextField.layer.borderColor = colorCCCCCC.CGColor;
    
    minTextField.layer.borderWidth =
    maxTextField.layer.borderWidth = 1;
    
    minTextField.clipsToBounds =
    maxTextField.clipsToBounds = YES;
    

    
    [lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contentView);
        make.top.mas_equalTo(self.cellMoneyLabel.mas_bottom).mas_offset(kSpaceH(60));
        make.width.mas_equalTo(kSpaceW(25));
        make.height.mas_equalTo(1);
    }];
    
    [minTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lineLable);
        make.right.mas_equalTo(lineLable.mas_left).mas_offset(-kSpaceW(8));
        make.height.mas_equalTo(kSpaceH(30));
        make.width.mas_equalTo(kSpaceW(100));
    }];
    
    [maxTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lineLable);
        make.left.mas_equalTo(lineLable.mas_right).mas_offset(kSpaceW(8));
        make.height.mas_equalTo(kSpaceH(30));
        make.width.mas_equalTo(kSpaceW(100));
    }];
    
    
    
    UIView *lineViewFive = [[UIView alloc] init];
    [contentView addSubview:lineViewFive];
    lineViewFive.backgroundColor = colorE7E7E7;
    [lineViewFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(contentView.mas_bottom).mas_offset(-kSpaceH(65));
        make.right.left.mas_equalTo(contentView);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *nextbutton = [[UIButton alloc] initWithFrame:CGRectMake(20, 4.5, 150 , 40)];
    self.nextbutton = nextbutton;
    [nextbutton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    nextbutton.tag = 458;
    [nextbutton setTitle:@"确 认" forState:UIControlStateNormal];
    nextbutton.backgroundColor = color00CCBB;
    nextbutton.titleLabel.font = font16;
    [nextbutton setTitleColor:colorFFFFFF forState:UIControlStateNormal];
    nextbutton.layer.cornerRadius = 17.5;
    nextbutton.clipsToBounds = YES;
    [contentView addSubview:nextbutton];
    nextbutton.adjustsImageWhenHighlighted = NO;
    [nextbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(contentView.mas_bottom).mas_offset(-kSpaceH(15));
        make.centerX.mas_equalTo(contentView.mas_centerX);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(150);
    }];
    
}

@end
