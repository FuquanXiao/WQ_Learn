//
//  JBWLMineCenterSectionView.m
//  JBApp
//
//  Created by apple on 2019/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLMineCenterSectionView.h"

@interface JBWLMineCenterSectionView()
@property (nonatomic,assign)BOOL showCornor;
@property (nonatomic,strong)UIImageView *bgImageView;
@end


@implementation JBWLMineCenterSectionView

- (instancetype)initWithFrame:(CGRect)frame showTopCornor:(BOOL)showCornor{
    _showCornor = showCornor;
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self _createUI];
    }
    return self;
}

- (void)_createUI{
    
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth - 10, kSpaceH(51))];
    self.bgImageView.userInteractionEnabled = YES;
    self.bgImageView.backgroundColor = colorF3F3F3;
    self.bgImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.bgImageView];
    
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(self).mas_offset(-5);
        make.height.mas_equalTo(kSpaceH(51));
    }];
    
    if (_showCornor) {
        self.bgImageView.image = [UIImage imageNamed:@"向上的圆角"];
    }
    else{
        self.bgImageView.backgroundColor = colorFFFFFF;
    }
    
    [self.bgImageView addSubview:self.sectionTitleLabel];
    [self.bgImageView addSubview:self.nextButton];
    
    [self.sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView).mas_offset(10);
        make.top.mas_equalTo(self.bgImageView).mas_offset(kSpaceH(20));
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgImageView).mas_offset(-10);
        make.centerY.mas_equalTo(self.sectionTitleLabel);
        make.width.mas_equalTo(kSpaceH(60));
        make.height.mas_equalTo(kSpaceH(14));
    }];
}


- (UILabel *)sectionTitleLabel{
    if (!_sectionTitleLabel) {
        _sectionTitleLabel = [UILabel createLabelWithFrame:CGRectZero text:@"" textColor:color444444 font:font17 textAlignment:NSTextAlignmentLeft];
    }
    return _sectionTitleLabel;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton createButtonWithFrame:CGRectZero withTitle:@"编辑时间" withImage:@"" withTitleColor:colorFFFFFF withTitleFont:kSpaceH(11)];
        [_nextButton setImagePosition:ImageLabelPositionRight spacing:1];
        _nextButton.backgroundColor = color00CCBB;
        _nextButton.layer.cornerRadius = kSpaceH(7);
        _nextButton.clipsToBounds = YES;
        _nextButton.hidden = YES;
    }
    return _nextButton;
}

@end
