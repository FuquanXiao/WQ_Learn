//
//  WQSlipMenuView.m
//  XFQItemButton
//
//  Created by apple on 2019/3/3.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "WQSlipMenuView.h"
@interface WQSlipMenuView()
@property (nonatomic,strong)NSMutableArray *buttonArray;
@property (nonatomic,strong)NSMutableArray *itemArray;

@property (nonatomic,assign)NSInteger selectedBtnTag;
@end



@implementation WQSlipMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.bounces = NO;
        [self initConfig];
    }
    return self;
}

- (void)initConfig{
    self.normalFont = [UIFont systemFontOfSize:13];
    self.selectedFont = self.normalFont;
}

- (void)tittleButtonAction:(UITapGestureRecognizer *)gesture{
    
    UIView *gestureView = (UIView *)gesture.view;
    if (gestureView.tag == _selectedBtnTag) {
        return;
    }
    
    //计算scrollview偏移量
    CGFloat originX = gestureView.center.x - CGRectGetMidX(self.frame);
    CGFloat maxOffsetX = self.contentSize.width - self.frame.size.width;
    if (originX < 0) {
        originX = 0;
    }else if (originX > maxOffsetX){
        originX = maxOffsetX;
    }
    [self setContentOffset:CGPointMake(originX, 0) animated:YES];
    [self setSelectedBtnTag:gestureView.tag - 550];
}


- (void)setSelectedBtnTag:(NSInteger)selectedBtnTag{
    _selectedBtnTag = selectedBtnTag;
    if (self.buttonArray.count<=selectedBtnTag) {
        return ;
    }
    
    for (UILabel *selectedLabel in self.buttonArray) {
        selectedLabel.backgroundColor =  [UIColor whiteColor];
        selectedLabel.font =  self.normalFont;
        
        if (selectedBtnTag + 660 == selectedLabel.tag) {
             selectedLabel.backgroundColor = [UIColor redColor];
        }
        
    }
    
}


- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    self.contentOffset = CGPointZero;
    CGFloat scrollContentWidth = 0;
    
    for (int i = 0; i < _titleArray.count; i++) {
        
        NSString *titleContent =  _titleArray[i];
        CGSize contentSize = [titleContent sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        
        
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(scrollContentWidth, 0, contentSize.width + 30, self.bounds.size.height)];
        [self addSubview:itemView];
        
        itemView.backgroundColor = [UIColor cyanColor];
        
        
        UILabel *itemTittleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (self.bounds.size.height - (23))/2.0, contentSize.width + 10, 24)];
        itemTittleLabel.textColor = [UIColor orangeColor];
        itemTittleLabel.font = [UIFont systemFontOfSize:15];
        itemTittleLabel.text =  titleContent;
        [itemView addSubview:itemTittleLabel];
        itemTittleLabel.layer.borderColor = [UIColor redColor].CGColor;
        itemTittleLabel.layer.borderWidth = 1;
        itemTittleLabel.textAlignment = NSTextAlignmentCenter;;
        scrollContentWidth += contentSize.width;
        scrollContentWidth += 30;
        itemView.tag = i + 550;
        itemTittleLabel.tag = i + 660;
        itemTittleLabel.layer.cornerRadius = 12;
        
        [itemView addSubview:itemTittleLabel];
        
        UITapGestureRecognizer *itemTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tittleButtonAction:)];
        [itemView addGestureRecognizer:itemTap];
        [self.buttonArray addObject:itemTittleLabel];
        [self.itemArray addObject:itemView];
    }
    
    self.contentSize = CGSizeMake(scrollContentWidth, 60);
    [self setSelectedBtnTag:0];

}

- (NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}

- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

@end
