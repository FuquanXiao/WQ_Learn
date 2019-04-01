//
//  JBWLCourseDetailCourseInfoTableCell.m
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLCourseDetailCourseInfoTableCell.h"

@implementation JBWLCourseDetailCourseInfoTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _createUI];
    }
    return self;
}

- (void)_createUI{
    
    self.cellContentLabel = [UILabel  createLabelWithFrame:CGRectZero text:@"" textColor:color666666 font:font14 textAlignment:NSTextAlignmentLeft];
    
    self.cellContentLabel.backgroundColor = [UIColor redColor];
    
    self.maskImageView = [[UIImageView alloc] init];
    
    UIImageView *bottomImageView = [[UIImageView alloc] init];
    
    bottomImageView.image = [UIImage imageNamed:@"向下的圆角"];
    
     self.cellShowAllButton = [UIButton createButtonWithFrame:CGRectZero withTitle:@"查看全部" withTitleColor:color00CCBB withTitleFont:kSpaceH(12) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
    [self.cellShowAllButton setImage:[UIImage imageNamed:@"JBWL_MineCenter_showAllDown"] forState:UIControlStateNormal];
    [self.cellShowAllButton setImagePosition:ImageLabelPositionLeft spacing:3];


    [self addSubview:self.cellContentLabel];
    [self addSubview:self.maskImageView];
    [self addSubview:bottomImageView];
    [bottomImageView addSubview:self.cellShowAllButton];
    
    
    MASAttachKeys(self.cellContentLabel);
    MASAttachKeys(self.maskImageView);

    self.cellContentLabel.numberOfLines = 0;
    
    
    
    [self.cellContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kSpaceH(0));
        make.left.mas_equalTo(kSpaceH(10));
        make.right.mas_equalTo(self.mas_right).mas_offset(-kSpaceH(10));
        make.height.mas_equalTo(kSpaceH(53));
    }];
    
    self.maskImageView.backgroundColor = [UIColor whiteColor];
    self.maskImageView.alpha = 0.3;
    [self.maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-kSpaceH(35));
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(kSpaceH(30));
    }];
    
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(kSpaceH(35));
    }];
    
    
    [self.cellShowAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.right.mas_equalTo(self.cellContentLabel);
        make.height.mas_equalTo(kSpaceH(35));
    }];
    
    
    
    
    
}


- (void)setContentString:(NSString *)contentString{
    _contentString = contentString;
    
    NSMutableParagraphStyle *style =[[NSMutableParagraphStyle alloc] init];
    style.lineSpacing =  kSpaceW(8);
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:contentString];
    [attribute addAttributes:@{NSFontAttributeName:font14,NSParagraphStyleAttributeName:style} range:NSMakeRange(0, contentString.length)];
    
    self.cellContentLabel.attributedText = attribute;
    
    [self.cellContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([JBWLCourseDetailCourseInfoTableCell getContentHeight:contentString] - kSpaceH(35));
    }];
}


+ (CGFloat)getContentHeight:(NSString *)contentString{
    
    CGSize contentSize = [NSString getSizeWithContent:contentString andCGSize:CGSizeMake(kScreenWidth - kSpaceW(20), MAXFLOAT) andfont:font14 lineSpace:kSpaceH(8)];
    
    return contentSize.height + kSpaceH(35);
}


@end
