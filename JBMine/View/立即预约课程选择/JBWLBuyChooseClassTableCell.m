//
//  JBWLBuyChooseClassTableCell.m
//  JBApp
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLBuyChooseClassTableCell.h"

@interface JBWLBuyChooseClassTableCell()
@property (nonatomic,strong)UILabel *titleLabel;
@end


@implementation JBWLBuyChooseClassTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = colorFFFFFF;
        [self _createUI];
    }
    return self;
}

- (void)setCourseModel:(JBWLUserCourseModel *)courseModel{
    _courseModel = courseModel;
    _titleLabel.text = SafeValue(_courseModel.title);
    if (_courseModel.hadSelected) {
        self.chooseImageView.image = [UIImage imageNamed:@"JBWL_ChooseTime_Delected"];
    }
    else{
        self.chooseImageView.image = [UIImage imageNamed:@"JBWL_ChooseTime_Normal"];
    }
}

- (void)_createUI{
    UIImageView * chooseImageView = [[UIImageView alloc] init];
    [self addSubview:chooseImageView];
    self.chooseImageView = chooseImageView;
    [chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(kSpaceH(12), kSpaceH(12)));
    }];
    
    chooseImageView.image = [UIImage imageNamed:@"JBWL_ChooseTime_Normal"];
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.text = @"";
    self.titleLabel = titleLabel;
    titleLabel.font = font13;
    titleLabel.textColor = color888888;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(chooseImageView.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(chooseImageView);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
    }];
    
}

@end
