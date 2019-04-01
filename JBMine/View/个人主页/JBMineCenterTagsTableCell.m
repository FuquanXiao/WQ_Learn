//
//  JBMineCenterTagsTableCell.m
//  JBApp
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBMineCenterTagsTableCell.h"
#import "XFQTagsView.h"
@interface JBMineCenterTagsTableCell()
@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)XFQTagsView *tagViews;
@end



@implementation JBMineCenterTagsTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self _createUI];
    }
    return self;
}

- (void)_createUI{
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth - 10, kSpaceH(51))];
    self.bgImageView.backgroundColor = [UIColor whiteColor];
    self.bgImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.bgImageView];
    
    
    UIView *titleLineView = [[UIView alloc] initWithFrame:CGRectMake(kSpaceH(10), 0, kScreenWidth - 10 - 20 , 1)];
    [self addSubview:titleLineView];
    titleLineView.backgroundColor = colorD6D6D6;
    
    [titleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(self).mas_offset(-5);
        make.bottom.mas_equalTo(self);
    }];
}

- (void)setTagsArray:(NSMutableArray *)tagsArray{
    _tagsArray = tagsArray;
    [self.bgImageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.tagViews = [[XFQTagsView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 10) withViewWidth:kScreenWidth - 20 ];
    self.tagViews.tagBgViewWidth = kScreenWidth - 20;
    self.tagViews.noBorderColor = YES;
    self.tagViews.borderColor = [UIColor redColor];
    self.tagViews.textColor = color666666;
    self.tagViews.rowSpace = 10;
    self.tagViews.font = font13;
    [self.tagViews showTagsViewWithArray:_tagsArray createTag:YES];
    
    [self.bgImageView addSubview:_tagViews];
    [self.tagViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kSpaceH(20));
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom).mas_offset(-kSpaceH(20));
    }];
}
+ (CGFloat)getCellHeightWithArray:(NSArray *)tagArray{
    
    XFQTagsView *tagView = [[XFQTagsView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 10) withViewWidth:kScreenWidth - 20 ];
    tagView.font = font13;
    tagView.tagBgViewWidth = kScreenWidth - 20;
    tagView.rowSpace = 10;
    CGFloat tagViewHeight = [tagView showTagsViewWithArray:tagArray createTag:NO];
    
    return tagViewHeight;
}

@end
