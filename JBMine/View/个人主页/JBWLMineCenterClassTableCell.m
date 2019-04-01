//
//  JBWLMineCenterClassTableCell.m
//  JBApp
//
//  Created by apple on 2019/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLMineCenterClassTableCell.h"

@implementation JBWLMineCenterClassTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = colorF3F3F3;
    self.contentView.backgroundColor = colorF3F3F3;
    self.cellLine.image = [UIImage imageWithColor:colorE7E7E7 size:CGSizeMake(kScreenWidth - 20, 1)];

    self.cellPeopleLabel.font =
    self.cellContentLabel.font = font12;
    self.cellContentLabel.numberOfLines = 2;
    self.cellPeopleLabel.textColor =
    self.cellContentLabel.textColor = color888888;
    
    self.cellTitleLabel.font = font14;
    self.cellTitleLabel.textColor = color444444;
    
    self.cellPeopleLabel.textAlignment = NSTextAlignmentRight;
    
    self.cellMoneyLabel.textColor = color00CCBB;
    self.cellMoneyLabel.font = font15;
    
    self.cellCourseStatusLabel.font = font11;
    self.cellCourseStatusLabel.layer.cornerRadius = 7;
    self.cellCourseStatusLabel.clipsToBounds = YES;
    self.cellCourseStatusLabel.layer.borderColor = color00CCBB.CGColor;
    self.cellCourseStatusLabel.layer.borderWidth = 1;
    self.cellCourseStatusLabel.hidden = YES;
    
}

- (void)setCourseModel:(JBWLUserCourseModel *)courseModel{
    _courseModel = courseModel;
    
    _cellTitleLabel.text = SafeValue(_courseModel.title);
//    _cellContentLabel.text = SafeValue(_courseModel.content);
    _cellMoneyLabel.text = [NSString stringWithFormat:@"￥%@",SafeValue(_courseModel.priceYuan)];
    
    _cellPeopleLabel.text = [NSString stringWithFormat:@"%@人学过",SafeValue(_courseModel.learnNum)];
    [self setClassContentModel:SafeValue(_courseModel.content)];
}

- (void)setClassContentModel:(NSString *)contentString{
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:contentString];
    NSMutableParagraphStyle *pragramStyle = [[NSMutableParagraphStyle alloc] init];
    pragramStyle.lineSpacing = kSpaceH(4);
    
    [attributedString addAttributes:@{NSParagraphStyleAttributeName:pragramStyle} range:NSMakeRange(0, contentString.length)];
    self.cellContentLabel.attributedText = attributedString;
    
}

@end
