//
//  JBWLBuyChooseTimeSectionView.m
//  JBApp
//
//  Created by apple on 2019/3/22.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLBuyChooseTimeSectionView.h"

@interface JBWLBuyChooseTimeSectionView()

@property (nonatomic,strong)UIView *topLineView;
@property (nonatomic,strong)UIImageView *cycleImageView;
@property (nonatomic,strong)UIView *bottomLineView;


@end


@implementation JBWLBuyChooseTimeSectionView

- (instancetype)initWithFrame:(CGRect)frame andTimeType:(JBWLBuyChooseTimeType)timeType{
    _timeType = timeType;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _createUI];
    }
    return self;
}

- (void)_createUI{
    
    UIView *topLineView = [[UIView alloc] init];
    [self addSubview:topLineView];
    
    UIImageView *cycleImageView = [[UIImageView alloc] init];
    [self addSubview:cycleImageView];
    
    
    UIView *bottomLineView = [[UIView alloc] init];
    [self addSubview:bottomLineView];
    
    
    UILabel *contentLabel = [[UILabel alloc] init];
    [self addSubview:contentLabel];
    
    UIButton *selectedButton = [[UIButton alloc] init];
    [self addSubview:selectedButton];
    
    self.topLineView = topLineView;
    self.cycleImageView = cycleImageView;
    self.bottomLineView = bottomLineView;

    self.contentLabel = contentLabel;
    self.selectedButton = selectedButton;
    
    topLineView.backgroundColor =
    bottomLineView.backgroundColor = color00CCBB;
//    cycleImageView.backgroundColor = kUIColorFromRGB(0xFF9000);
    cycleImageView.layer.cornerRadius = 3;
    cycleImageView.clipsToBounds = YES;
    contentLabel.textColor = color444444;
    contentLabel.font = font17;
    
    topLineView.alpha =
    bottomLineView.alpha = 0.5;
    
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(1);
        make.left.mas_equalTo(kSpaceH(20));
        make.bottom.mas_equalTo(cycleImageView.mas_top);
    }];
    
    [cycleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(topLineView);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.top.mas_equalTo(cycleImageView.mas_bottom);
        make.width.mas_equalTo(1);
        make.left.mas_equalTo(kSpaceH(20));
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(cycleImageView.mas_right).mas_offset(kSpaceH(10));
    }];
    [contentLabel sizeToFit];
    
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(kSpaceH(20));
        make.width.mas_equalTo(kSpaceH(65));
        make.left.mas_equalTo(contentLabel.mas_right).mas_offset(kSpaceH(15));
    }];
    [selectedButton sizeToFit];
    
    cycleImageView.image = [UIImage imageNamed:@"JBWL_ChooseTime_Icon"];
   
    self.contentLabel.text = @"";
    self.contentLabel.textColor = color00CCBB;
    self.contentLabel.font = font18;
    self.selectedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    if (self.timeType == JBWLBuyChooseTimeChoose) {
        self.selectedButton.userInteractionEnabled = NO;
    }
    else{
        self.selectedButton.userInteractionEnabled = YES;
        [self.selectedButton setTitle:@"添加时间" forState:UIControlStateNormal];
        [self.selectedButton setTitleColor:color00CCBB forState:UIControlStateNormal];
        self.selectedButton.layer.cornerRadius = kSpaceH(10);
        self.selectedButton.layer.borderWidth = 1;
        self.selectedButton.layer.borderColor = color00CCBB.CGColor;
        self.selectedButton.titleLabel.font = font11;

    }
    
}

@end
