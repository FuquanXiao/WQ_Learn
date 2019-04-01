//
//  JBWLSubscribeBottomView.m
//  JBApp
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLSubscribeBottomView.h"

@interface JBWLSubscribeBottomView()
@property (nonatomic,strong)UIButton *chatBtn;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UIButton *buyBtn;
@end



@implementation JBWLSubscribeBottomView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _creteUI];
    }
    return self;
}
- (void)chatAction{
    if (self.chatBlock) {
        self.chatBlock();
    }
}

- (void)buyAction
{
    if (self.buyBlock) {
        self.buyBlock();
    }
}
- (void)setBottomWithStatue:(NSInteger)staute{

        self.buyBtn.enabled = YES;
        [self.buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        self.buyBtn.backgroundColor = color00CCBB;
}

- (void)setBottomLeftType:(BottomViewLeftType)bottomLeftType{
    _bottomLeftType = bottomLeftType;
}

- (void)_creteUI{
    self.chatBtn = [[UIButton alloc]init];
    [self.chatBtn addTarget:self action:@selector(chatAction) forControlEvents:UIControlEventTouchUpInside];
    [self.chatBtn setImage:[UIImage imageNamed:@"录播课免费试看1"] forState:UIControlStateNormal];
    [self.chatBtn sizeToFit];
    self.chatBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.chatBtn setTitleColor:colorC40000 forState:UIControlStateNormal];
    [self.chatBtn setTitle:@"免费试看" forState:UIControlStateNormal];
    [self.chatBtn setImagePosition:ImageLabelPositionTop spacing:3];
    [self addSubview:self.chatBtn];
    [self.chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.bottom.mas_equalTo(8);
        make.height.mas_equalTo(34).priority(750);
        make.width.mas_equalTo(100);
    }];
    [self.chatBtn sizeToFit];
    
    self.buyBtn = [UIButton createButtonWithFrame:CGRectZero withTitle:@"" withTitleColor:colorFFFFFF withTitleFont:kSpaceH(16) withBackgroundColor:nil withTarget:self withAction:@selector(buyAction)];
    
    [self addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(130);
    }];
    
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.font = [UIFont systemFontOfSize:20];
    self.priceLabel.textColor = colorC40000;
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.buyBtn.mas_left).offset(-10);
        make.centerY.equalTo(self);
    }];
    
    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.backgroundColor = colorEBEBEB;
    [self addSubview:lineImage];
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.right.equalTo(self).offset(IS_REVIEW ? 0 : -130);
        make.height.mas_equalTo(1);
    }];
    [self setBottomWithStatue:1];
}

@end
