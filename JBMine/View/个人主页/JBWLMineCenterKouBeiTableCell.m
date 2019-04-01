//
//  JBWLMineCenterKouBeiTableCell.m
//  JBApp
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLMineCenterKouBeiTableCell.h"

@interface JBWLMineCenterKouBeiTableCell()

@property (nonatomic,strong)UIImageView *bgImageView;
///头像
@property (nonatomic,strong)UIImageView *cellIconImageView;
///名字
@property (nonatomic,strong)UILabel *cellNameLabel;
///满意度
@property (nonatomic,strong)UIButton *cellSatisfactionButton;
///时间
@property (nonatomic,strong)UILabel * cellTimeLabel;
///学习“孩子沉迷手机的原因”课程
@property (nonatomic,strong)UILabel * cellClassTitleLabel;

@property (nonatomic,strong)YYLabel *cellContentLable;
@end


@implementation JBWLMineCenterKouBeiTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self _cteateUI];
    }
    return self;
}


- (void)_cteateUI{
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth - 10, kSpaceH(51))];
    self.bgImageView.backgroundColor = [UIColor whiteColor];
    self.bgImageView.contentMode = UIViewContentModeScaleToFill;
    
    UIView *titleLineView = [[UIView alloc] initWithFrame:CGRectMake(kSpaceH(10), 0, kScreenWidth - 10 - 20 , 1)];
    titleLineView.backgroundColor = colorD6D6D6;

    self.cellIconImageView = [[UIImageView alloc] init];
    
    self.cellIconImageView.userInteractionEnabled = YES;
    
    self.cellNameLabel = [UILabel createLabelWithFrame:CGRectZero text:@"" textColor:color333333 font:font15 textAlignment:NSTextAlignmentLeft];
    
    self.cellSatisfactionButton = [[UIButton alloc] init];
    
    self.cellTimeLabel = [UILabel createLabelWithFrame:CGRectZero text:@"" textColor:color999999 font:font12 textAlignment:NSTextAlignmentLeft];
    
    self.cellClassTitleLabel = [UILabel createLabelWithFrame:CGRectZero text:@"" textColor:colorFF7E00 font:font10 textAlignment:NSTextAlignmentLeft];
    
    self.cellContentLable = [[YYLabel alloc] initWithFrame:CGRectMake(0, 0, kSpaceH(291), 10)];
    self.cellContentLable.preferredMaxLayoutWidth = kSpaceH(291);
    self.cellContentLable.numberOfLines = 0;

    
    MASAttachKeys(self.cellIconImageView);
    MASAttachKeys(self.cellNameLabel);
    MASAttachKeys(self.cellSatisfactionButton);
    MASAttachKeys(self.cellClassTitleLabel);
    MASAttachKeys(self.cellTimeLabel);
    
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:titleLineView];
    [self.bgImageView addSubview:self.cellIconImageView];
    [self.bgImageView addSubview:self.cellNameLabel];
    [self.bgImageView addSubview:self.cellSatisfactionButton];
    [self.bgImageView addSubview:self.cellClassTitleLabel];
    [self.bgImageView addSubview:self.cellTimeLabel];
    [self.bgImageView addSubview:self.cellContentLable];
    self.cellIconImageView.backgroundColor = kUIColorFromRGB(0xFFEBEBEB);
    self.cellIconImageView.layer.cornerRadius = kSpaceH(20);
    self.cellIconImageView.clipsToBounds = YES;
    
    
    self.cellNameLabel.text = @"半夏如烟";
 
    self.cellClassTitleLabel.text = @"学习“孩子沉迷手机的原因”课程学习“孩子沉迷手机的原因”课程";
    [self.cellClassTitleLabel sizeToFit];
    
    self.cellTimeLabel.text = @"08/28  16:52:23";
    
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(self).mas_offset(-5);
        make.bottom.mas_equalTo(self);
    }];
    
    [titleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.cellIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.bgImageView).mas_offset(kSpaceH(20));
        make.height.width.mas_equalTo(kSpaceH(40));
    }];
    
    [self.cellNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cellIconImageView);
        make.left.mas_equalTo(self.cellIconImageView.mas_right).mas_offset(10);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_equalTo(kSpaceH(20));
    }];
    [self.cellNameLabel sizeToFit];
    
    [self.cellSatisfactionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cellIconImageView);
        make.left.mas_equalTo(self.cellNameLabel.mas_right).mas_offset(5);
        make.height.mas_equalTo(self.cellNameLabel);
    }];
    
    [self.cellTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cellNameLabel);
        make.height.mas_equalTo(kSpaceW(14)); make.bottom.mas_equalTo(self.cellIconImageView.mas_bottom);
        make.width.mas_lessThanOrEqualTo(kScreenWidth/2.0);
        
    }];
    [self.cellTimeLabel sizeToFit];
    
    [self.cellClassTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.cellTimeLabel.mas_centerY);
        make.left.mas_equalTo(self.cellTimeLabel.mas_right).mas_offset(7);
        make.right.mas_equalTo(self.bgImageView.mas_right).mas_offset(-10);
    }];
    [self setContent:@"简单暴力，却是最最常用的方法，直接将图片设置为ImageView的image属性，图片便会随UIImageView对象的大小做自动拉伸。这种拉伸的方法有一个致命的缺陷，它会使图像发生失真与形变"];
}

- (void)setContent:(NSString *)contetString{
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:contetString];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = kSpaceH(10);
    [att addAttributes:@{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:font12} range:NSMakeRange(0, contetString.length)];
    self.cellContentLable.attributedText = att;
    
    [self.cellContentLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cellIconImageView.mas_bottom).mas_offset(kSpaceH(12));
        make.left.mas_equalTo(self.cellNameLabel);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom).mas_offset(-kSpaceH(20));
    }];
//    [self.cellContentLable sizeToFit];
}

+ (CGFloat)getCellHeightWithContentString:(NSString *)contetString{
    NSString *contetString1 = @"简单暴力，却是最最常用的方法，直接将图片设置为ImageView的image属性，图片便会随UIImageView对象的大小做自动拉伸。这种拉伸的方法有一个致命的缺陷，它会使图像发生失真与形变";
    

    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = kSpaceH(10);
      CGSize size = [contetString boundingRectWithSize:CGSizeMake(kSpaceH(291), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |
                                      NSStringDrawingUsesLineFragmentOrigin |
                                      NSStringDrawingUsesFontLeading attributes:@{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:font12} context:nil].size;
    
    return size.height + kSpaceH(72) + kSpaceH(20);
}

@end
