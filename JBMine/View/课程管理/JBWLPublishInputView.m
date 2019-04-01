//
//  JBWLPublishInputView.m
//  JBApp
//
//  Created by apple on 2019/3/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLPublishInputView.h"

@implementation JBWLPublishInputView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self configInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)titile placeHoler:(NSString *)placeHolder andType:(JBInputItemViewItemType)type{
    _title = titile;
    _placeHolder = placeHolder;
    _type = type;
    return [self  initWithFrame:frame];
}

- (void)configInit{
    _textBgViewHeight = kSpaceH(30);
    _titleFont = font15;
    _titleColor = color666666;
    _textViewFont = font12;
    _textViewColor = color999999;
}

- (void)showItemView{
    [self _createUI];
}


- (void)_createUI{
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,_labelWidth, _textBgViewHeight)];
    [self addSubview:titleLabel];
    titleLabel.font = _titleFont;
    
    
    if (_textBgViewWidth < 1.0) {
        _textBgViewWidth = CGRectGetWidth(self.bounds) - _labelWidth - _labelInputSpace;
    }
    
    
    UIView *textBgView = [[UIView alloc] initWithFrame:CGRectMake(_labelWidth + _labelInputSpace, 0, _textBgViewWidth, _textBgViewHeight)];
    [self addSubview:textBgView];
    [self addSubview:titleLabel];
    
    
    UITextField * textView = [[UITextField alloc] initWithFrame:CGRectMake(kSpaceH(18), 0, _textBgViewWidth -  kSpaceH(18), _textBgViewHeight)];
    [textBgView addSubview:textView];
    textView.borderStyle = UITextBorderStyleNone;
    self.textView = textView;
    textView.placeholder = _placeHolder;
    textView.font = _textViewFont;
    titleLabel.text = _title;
    titleLabel.font = _titleFont;
    titleLabel.textColor = _titleColor;
    
    textBgView.backgroundColor = [UIColor whiteColor];
    textBgView.layer.borderColor = colorCCCCCC.CGColor;
    textBgView.layer.borderWidth = 1;
    textBgView.layer.cornerRadius = kSpaceH(15);
    textBgView.clipsToBounds = YES;
    
    
    if (_type == JBInputItemViewItemTypeNormal) {
        textView.enabled = NO;
        
        self.proButtton = [[UIButton alloc] initWithFrame:textBgView.frame];
        [textBgView addSubview:_proButtton];
        
        UIButton * nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSpaceH(30), kSpaceH(30))];
        textView.rightView = nextButton;
        textView.rightViewMode = UITextFieldViewModeAlways;
        [nextButton setImage:[UIImage imageNamed:@"JB_认证_next"] forState:UIControlStateNormal];
    }
    
    
}

@end
