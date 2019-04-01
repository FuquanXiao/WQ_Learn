//
//  JBWLMineCenterHeaderUserInfoView.m
//  JBApp
//
//  Created by apple on 2019/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLMineCenterHeaderUserInfoView.h"

@interface JBWLMineCenterHeaderUserInfoView()

@end

@implementation JBWLMineCenterHeaderUserInfoView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _createUI];
    }
    return self;
}

- (void)_createUI{
    
    UIImageView * iconImageView = [[UIImageView alloc] init];
    UILabel *nameLabel = [[UILabel alloc] init];
    UIImageView *nameIconImageView = [[UIImageView alloc] init];
    UIImageView *sexIconImageView = [[UIImageView alloc] init];
    UILabel *activeLabel = [[UILabel alloc] init];
    UIView *lineView = [[UIView alloc] init];
    UILabel *tagViewLabel = [[UILabel alloc] init];
    UIButton *modifyButton = [[UIButton alloc] init];

    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.iconImageView = iconImageView;
    self.lineView      = lineView;
    self.activeLabel   = activeLabel;
    self.sexIconImageView = sexIconImageView;
    self.nameIconImageView = nameIconImageView;
    self.nameLabel = nameLabel;
    self.tagViewLabel = tagViewLabel;
    self.modifyButton = modifyButton;
    sexIconImageView.contentMode = UIViewContentModeLeft;
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;

    [self addSubview:iconImageView];
    [self addSubview:nameLabel];
    [self addSubview:nameIconImageView];
    [self addSubview:sexIconImageView];
    [self addSubview:activeLabel];
    [self addSubview:lineView];
    [self addSubview:tagViewLabel];
    [self addSubview:modifyButton];
    
    [iconImageView zy_cornerRadiusRoundingRect];
    modifyButton.tag = 505;
    [modifyButton setTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    

    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kSpaceH(0));
        make.left.mas_equalTo(kSpaceH(10));
        make.height.width.mas_equalTo(kSpaceH(60));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageView.mas_top).mas_offset(8);
        make.left.mas_equalTo(iconImageView.mas_right).mas_offset(kSpaceH(10));
        make.height.mas_equalTo(kSpaceH(20));
        make.width.mas_lessThanOrEqualTo(200);
    }];
    [nameLabel sizeToFit];
    
    [nameIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameLabel);
        make.left.mas_equalTo(nameLabel.mas_right).mas_offset(5);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(24);
    }];
    [sexIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(iconImageView.mas_bottom).mas_offset(-8);
        make.left.mas_equalTo(iconImageView.mas_right).mas_offset(kSpaceH(10));
        make.height.mas_equalTo(14);
    }];
    
    
    [activeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(iconImageView.mas_bottom).mas_offset(-8);
        make.left.mas_equalTo(sexIconImageView.mas_right).mas_offset(kSpaceH(5));
        make.height.mas_equalTo(kSpaceH(14));
    }];
    [activeLabel sizeToFit];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(activeLabel);
        make.left.mas_equalTo(activeLabel.mas_right).mas_offset(kSpaceH(4));
        make.top.mas_equalTo(activeLabel).mas_offset(3);
        make.bottom.mas_equalTo(activeLabel).mas_offset(-3);
        make.width.mas_equalTo(1);
    }];
    lineView.backgroundColor = colorD6D6D6;
    
    [modifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(iconImageView);
        make.right.mas_equalTo(self.mas_right).mas_offset(- kSpaceH(10));
        //        make.width.mas_equalTo(40);
    }];
    [modifyButton sizeToFit];
    
    [tagViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(iconImageView.mas_bottom).mas_offset(-8);
        make.left.mas_equalTo(lineView.mas_right).mas_offset(kSpaceH(4));
        make.width.mas_lessThanOrEqualTo(kSpaceH(130));
    }];
    
    
    
    [modifyButton setImage:[UIImage imageNamed:@"MineCenter_修改个人信息"] forState:UIControlStateNormal];
    [modifyButton setTitle:@"修改资料 " forState:UIControlStateNormal];
    modifyButton.titleLabel.font = font9;
    [modifyButton setTitleColor:color999999 forState:UIControlStateNormal];
    
    nameLabel.textColor = color333333;
    nameLabel.font = font17;
    activeLabel.font = font11;
    activeLabel.textColor = 
    tagViewLabel.textColor = color666666;
    tagViewLabel.font = font11;
    
    [modifyButton setImagePosition:ImageLabelPositionTop spacing:3];

}
@end
