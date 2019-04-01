//
//  JBWLMineCenterClassicalCourseTableCell.m
//  JBApp
//
//  Created by apple on 2019/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLMineCenterClassicalCourseTableCell.h"

@interface JBWLMineCenterClassicalCourseTableCell()
@property (nonatomic,strong)UIImageView *bgImageView ;
@end


@implementation JBWLMineCenterClassicalCourseTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self _createUI];
    }
    return self;
}

- (void)_createUI{
    
    [self addSubview:self.bgImageView];

    [self.bgImageView addSubview:self.cellTitleLabel];
    [self.bgImageView addSubview:self.nextButton];
    
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView).mas_offset(10);
        make.centerY.mas_equalTo(self.bgImageView);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgImageView).mas_offset(-10);
        make.centerY.mas_equalTo(self.bgImageView);
    }];
    [self.nextButton sizeToFit];
}

- (UILabel *)cellTitleLabel{
    if (!_cellTitleLabel) {
        _cellTitleLabel = [UILabel createLabelWithFrame:CGRectZero text:@"" textColor:color444444 font:[UIFont fontWithName:@"PingFang-SC-Bold" size:17] textAlignment:NSTextAlignmentLeft];
    }
    return _cellTitleLabel;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton  = [UIButton createButtonWithFrame:CGRectZero withTitle:@"查看全部" withImage:@"JBWL_MineCenter_showAllRight" withTitleColor:color666666 withTitleFont:kSpaceH(11)];
        [_nextButton setImagePosition:ImageLabelPositionRight spacing:1];
    }
    return _nextButton;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth - 10, kSpaceH(55))];
        _bgImageView.backgroundColor = colorFFFFFF;
        _bgImageView.layer.cornerRadius = 15;
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}
@end
