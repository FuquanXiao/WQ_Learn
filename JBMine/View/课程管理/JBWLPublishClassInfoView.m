//
//  JBWLPublishClassInfoView.m
//  JBApp
//
//  Created by apple on 2019/3/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLPublishClassInfoView.h"



@interface JBWLPublishClassInfoView()


@end



@implementation JBWLPublishClassInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _createUI];
    }
    return self;
}

- (void)tagButtonAction:(UIButton *)btn{
    for (UIButton *butt in self.tagButtonArray) {
        butt.selected = NO;
    }
    btn.selected = YES;
    NSLog(@"这个地方显示but的tag");
}


- (void)timeLenthButtonAction:(UIButton *)btn{
    
    for (UIButton *butt in self.timeLengthButtonArray) {
        butt.selected = NO;
    }
    btn.selected = YES;
    self.timeLengthString = self.classTimeArray[btn.tag];
    
}


- (void)buttonAction:(UIButton *)btn{
    switch (btn.tag) {
            
        case 101://线下课
        {
            _courseModel.teachType = @"2";
            self.classType = PublishClassOffLine;
            self.offLineChooseButton.selected = YES;
            self.onLineChooseButton.selected = !self.offLineChooseButton.selected;
            
        }
            break;
            
        case 102:/// 语音教学
        {
             _courseModel.teachType = @"1";
            self.classType = PublishClassOnLine;
            self.onLineChooseButton.selected = YES;
            self.offLineChooseButton.selected = !self.onLineChooseButton.selected;
           
        }
            break;
        case 103:{///上门
            self.gotoHomeButton.selected = YES;
            _courseModel.addressType = @"1";
            self.regularButton.selected =
            self.aggreeButton.selected = NO;
            
            self.lineViewTwo.hidden =
            self.addressItemView.hidden =
            self.gotoHomeButton.selected ;
            
            [self.addressView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kSpaceW(45));
            }];
        }
            break;
        case 104:{///协商
            _courseModel.addressType = @"2";
            
            
            self.aggreeButton.selected = YES;
            self.regularButton.selected =
            self.gotoHomeButton.selected = NO;
            
            self.lineViewTwo.hidden =
            self.addressItemView.hidden =
            self.aggreeButton.selected ;
            
            [self.addressView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kSpaceW(45));
            }];
        }
            break;
        case 105:{///固定地点
            
            _courseModel.addressType = @"3";
            
            
            self.regularButton.selected = YES;
            
            self.gotoHomeButton.selected =
            self.aggreeButton.selected =
            self.lineViewTwo.hidden =
            self.addressItemView.hidden =
            !self.regularButton.selected ;
            
            [self.addressView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kSpaceW(100));
            }];
        }
            break;
        case 106:{///一人
            
            self.onePeopleButton.selected = YES;
            self.moreOnePeopleButton.selected = NO;
            
            [self.peopleCountView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kSpaceW(45));
            }];
            self.lineViewFourth.hidden = YES;
            self.minTextField.hidden =
            self.maxTextField.hidden =
            self.lineLable.hidden = YES;
        }
            break;
        case 107:{///多人
            self.moreOnePeopleButton.selected = YES;
            self.onePeopleButton.selected = NO;
            
            [self.peopleCountView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kSpaceW(100));
            }];
            self.lineViewFourth.hidden = NO;
            self.minTextField.hidden =
            self.maxTextField.hidden =
            self.lineLable.hidden =  NO;
            
        }
            break;
        case 108:{///添加tag
            [self setTagLabelName:@"一年级语文"];
        }
            break;
        default:
            break;
    }
}


- (void)setTagLabelName:(NSString *)tagLabelName{
    _tagLabelName = tagLabelName;
    if (tagLabelName && tagLabelName.length > 0) {
        CGSize size= [tagLabelName  sizeWithAttributes:@{NSFontAttributeName:font12}];
        self.showTagLabel.frame = CGRectMake(kSpaceW(75) + kSpaceW(50), kSpaceH(10), size.width + 18, kSpaceH(30));
        
        self.showTagLabel.hidden = NO;
         self.chooseTagButton.frame = CGRectMake(CGRectGetMaxX(self.showTagLabel.frame) + kSpaceW(20), kSpaceH(10) , kSpaceH(105), kSpaceH(30));
    }
    else{
      self.chooseTagButton.frame = CGRectMake(kSpaceW(75) + kSpaceW(50), kSpaceH(10) , kSpaceH(105), kSpaceH(30));
        self.showTagLabel.hidden = YES;
    }
}

- (void)setClassType:(PublishClassType)classType{
    _classType = classType;
    switch (classType) {
        
        case PublishClassOffLine://线下课
        {
            self.addressView.hidden = NO;
            
            [self.addressView mas_updateConstraints:^(MASConstraintMaker *make) {
                if (self.regularButton.selected) {
                    make.height.mas_equalTo(kSpaceW(100));
                }
                else{
                    make.height.mas_equalTo(kSpaceW(45));
                }
            }];
            
            
            [self.peopleCountView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                if (self.moreOnePeopleButton.selected) {
                   make.height.mas_equalTo(kSpaceW(100));
                }
                else{
                    make.height.mas_equalTo(kSpaceW(45));
                }
            }];
            
            if (self.moreOnePeopleButton.selected) {
                self.lineViewFourth.hidden = NO;
                self.minTextField.hidden =
                self.maxTextField.hidden =
                self.lineLable.hidden = NO;
            }
            else{
                self.lineViewFourth.hidden = YES;
                self.minTextField.hidden =
                self.maxTextField.hidden =
                self.lineLable.hidden = YES;
            }
           
            self.moreOnePeopleButton.hidden = NO;
            self.onePeopleButton.selected = NO;
            
           
        }
            break;
        case PublishClassOnLine: /// 语音教学
        {
            self.addressView.hidden = YES;
            [self.addressView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kSpaceW(0));
            }];
            
            [self.peopleCountView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kSpaceW(45));
            }];
            self.lineViewFourth.hidden = YES;
            self.moreOnePeopleButton.hidden = YES;
            self.onePeopleButton.selected = YES;
            self.minTextField.hidden =
            self.maxTextField.hidden =
            self.lineLable.hidden = YES;
            
            
        }
            break;
            
        default:
            break;
    }
}


- (void)_createUI{

    [self _createClassType];
    [self _createClassTimeLengthView];
    [self _createTeachAddress];
    [self _createCountView];
    [self _createFeeView];
    [self _createTagsView];
    
}


- (CGFloat)getViewHeight{
    return CGRectGetMaxY(self.tagsView.frame);
}


- (void)_createClassTimeLengthView{
    
    UIView *classLengthView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineViewOne.frame), kScreenWidth - kSpaceW(10), kSpaceW(75))];
    classLengthView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:classLengthView];
    
    self.classLengthView = classLengthView;
    
    UILabel *classLengthLable = [UILabel createLabelWithFrame:CGRectMake(kSpaceW(10), kSpaceH(15) , kSpaceW(65), kSpaceH(16)) text:@"课程时长" textColor:color666666 font:font15 textAlignment:NSTextAlignmentLeft];
    
    [classLengthView addSubview:classLengthLable];
    
    [classLengthLable sizeToFit];
    
    
    
    UIView *selectedTimeView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(classLengthLable.frame) + kSpaceW(40), 0, kScreenWidth - kSpaceW(30) - kSpaceW(115), kSpaceW(75))];
   
    selectedTimeView.backgroundColor = [UIColor whiteColor];
    [classLengthView addSubview:selectedTimeView];
    
    UIView *lineViewTimeLengthTop = [self createLineView];
    [self addSubview:lineViewTimeLengthTop];
    self.lineViewTimeLengthViewBottom = lineViewTimeLengthTop;
    
    self.lineViewTimeLengthViewBottom.frame = CGRectMake(kSpaceW(10), CGRectGetMaxY(classLengthView.frame) + 1, kScreenWidth - kSpaceW(30), 1);
    MASAttachKeys(lineViewTimeLengthTop);
    MASAttachKeys(selectedTimeView);
    MASAttachKeys(classLengthView);

    
    NSArray *classTimeArray = @[@"不限",@"1小时",@"1.5小时",@"2小时",@"2.5小时"];
    
    if (IS_REVIEW) {
        classTimeArray = @[@"全年",@"一周",@"一月",@"半月",@"半年"];
    }
    self.classTimeArray = classTimeArray;

    
    CGFloat buttonWidth = (kScreenWidth - kSpaceW(30) - kSpaceW(115))/3.0;
    CGFloat buttonHeight = kSpaceH(20) ;
    
    for (int i = 0; i < classTimeArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( i % 3 * buttonWidth  + kSpaceW(10), kSpaceH(15) + i/3 * (buttonHeight + kSpaceH(10)), buttonWidth, buttonHeight)];
        [selectedTimeView addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:@"JB_Post_Choose_未选中"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"JB_Post_Choose_选中"] forState:UIControlStateSelected];
        button.titleLabel.font = font13;
        button.tag = i ;
        [button setTitleColor:color777777 forState:UIControlStateNormal];
        [button setTitle:classTimeArray[i] forState:UIControlStateNormal];
        [self.timeLengthButtonArray addObject:button];
        [button setImagePosition:ImageLabelPositionLeft spacing:6];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [button addTarget:self action:@selector(timeLenthButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
        }
    }
    
    [selectedTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(classLengthView);
        make.left.mas_equalTo(classLengthLable.mas_right).mas_offset(kSpaceW(50));
        make.right.mas_equalTo(classLengthView.mas_right);
        make.height.mas_equalTo(kSpaceH(75));
    }];
    
    
   
    [lineViewTimeLengthTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(classLengthView.mas_bottom);
        make.right.left.mas_equalTo(self.lineViewOne);
        make.height.mas_equalTo(1);
    }];
    
}
- (NSMutableArray *)timeLengthButtonArray{
    if (!_timeLengthButtonArray) {
        _timeLengthButtonArray  = [[NSMutableArray alloc] init];
    }
    return _timeLengthButtonArray;
}



- (NSMutableArray *)tagButtonArray{
    if (!_tagButtonArray) {
        _tagButtonArray  = [[NSMutableArray alloc] init];
    }
    return _tagButtonArray;
}



- (CGFloat)showTagsViewWithArray:(NSArray *)tagTextsArray tagView:(UIView *)showTagsView{
    
    [showTagsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat lineSpace = kSpaceH(10);
    CGFloat _viewWidth = kScreenWidth - kSpaceW(20) - kSpaceW(115);
    CGRect  proButtonFrame = CGRectMake(0, 0, 0, 0);
    
    for (int i = 0; i < tagTextsArray.count; i++) {
        
        CGSize size_str = [tagTextsArray[i] sizeWithAttributes:@{NSFontAttributeName:font13}];
        
        CGFloat labelWidth = 0;
        if (size_str.width >=  _viewWidth) {
            labelWidth = _viewWidth;
        }
        else{
            NSString *tagKey = tagTextsArray[i];
            if (tagKey.length>0) {
                labelWidth = MAX((size_str.width + kSpaceH(30)), kSpaceH(16));
            }
            else{
                labelWidth = 0;
            }
        }
        
        CGRect newFrame = CGRectZero;
        
        CGFloat x = CGRectGetMaxX(proButtonFrame) ;
        CGFloat y = CGRectGetMinY(proButtonFrame);
        
        if (i > 0) {
            x = CGRectGetMaxX(proButtonFrame) + lineSpace;
        }
        
        if (x + labelWidth  + lineSpace> _viewWidth) {
            x = 0;
            y = CGRectGetMaxY(proButtonFrame) + kSpaceH(10);
        }
        newFrame.origin = CGPointMake(x, y);
        
        newFrame.size = CGSizeMake(labelWidth, kSpaceH(16));
        proButtonFrame = newFrame;
        
        UIButton *button = [UIButton new];
        [button setTitle:tagTextsArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = font13;
        [button sizeToFit];
        button.frame = proButtonFrame;
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:@"JB_Post_Choose_未选中"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"JB_Post_Choose_选中"] forState:UIControlStateSelected];
        [button setImagePosition:ImageLabelPositionLeft spacing:kSpaceW(5)];
        [showTagsView addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(tagButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tagButtonArray addObject:button];
    }
    
    NSLog(@"proButtonFrame---%f",CGRectGetMaxY(proButtonFrame));
    return CGRectGetMaxY(proButtonFrame);
}


- (void)setSkillTagModelArray:(NSMutableArray *)skillTagModelArray{
    _skillTagModelArray = skillTagModelArray;
    [self _createTagsView];
    [self.tagsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)_createTagsView{
    
    UIView *tagsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineViewSix.frame), kScreenWidth - kSpaceW(10), kSpaceW(54))];
    self.tagsView = tagsView;
    [self addSubview:tagsView];
    
    UILabel *classTypeLabel = [UILabel createLabelWithFrame:CGRectMake(kSpaceW(10), kSpaceH(15) , kSpaceW(65), kSpaceH(45)) text:@"课程标签" textColor:color666666 font:font15 textAlignment:NSTextAlignmentLeft];
    [tagsView addSubview:classTypeLabel];
    [classTypeLabel sizeToFit];
    
    
    
    [tagsView addSubview:self.chooseTagButton];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:@"更多课程标签 》"];
    [attribute addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0, @"更多课程标签 》".length)];
    
    [self.chooseTagButton setAttributedTitle:attribute forState:UIControlStateNormal];
    

    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    
    for (JBSkillTagModel *model in _skillTagModelArray) {
        [titleArray addObject:SafeValue(model.labelName)];
    }
    
    if (_skillTagModelArray && _skillTagModelArray.count < 1) {
        
        UIView *showTagsView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(classTypeLabel.frame) + kSpaceW(50), kSpaceH(15), kScreenWidth - kSpaceW(20) - kSpaceW(115), kSpaceW(54))];
        [tagsView addSubview:showTagsView];

        
        CGFloat tagViewH = [self showTagsViewWithArray:titleArray tagView:showTagsView];

        
        tagsView.frame = CGRectMake(0, CGRectGetMaxY(self.lineViewSix.frame), kScreenWidth  - kSpaceW(20) - kSpaceW(115), tagViewH + kSpaceH(15) + kSpaceW(45));
        showTagsView.frame = CGRectMake(CGRectGetMaxX(classTypeLabel.frame) + kSpaceW(50), kSpaceH(15), kScreenWidth  - kSpaceW(20) - kSpaceW(115), tagViewH);
        
        [tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lineViewSix);
            make.width.mas_equalTo(kScreenWidth - kSpaceW(10));
            make.height.mas_equalTo(tagViewH + kSpaceH(15) + kSpaceW(45));
            make.left.mas_equalTo(0);
        }];
    }
    else{
        [tagsView addSubview:self.chooseTagButton];
        
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:@"更多课程标签 》"];
        [attribute addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0, @"更多课程标签 》".length)];
        
        [self.chooseTagButton setAttributedTitle:attribute forState:UIControlStateNormal];
        [tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lineViewSix);
            make.width.mas_equalTo(kScreenWidth - kSpaceW(10));
            make.height.mas_equalTo(kSpaceH(45));
            make.left.mas_equalTo(0);
        }];
    }
    
    
    
    
    
    

    
   
  
//
//    [tagsView addSubview:self.showTagLabel];

//    self.showTagLabel.hidden = YES;
    
    
}




- (void)_createFeeView{
    
    UIView *feeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineViewFive.frame), kScreenWidth - kSpaceW(10), kSpaceW(54))];
    self.feeView = feeView;
    [self addSubview:feeView];
    
    [feeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineViewFive);
        make.width.mas_equalTo(kScreenWidth - kSpaceW(10));
        make.height.mas_equalTo(kSpaceW(54));
        make.left.mas_equalTo(0);
    }];
    
    
    JBWLPublishInputView *feeItemView = [[JBWLPublishInputView alloc] initWithFrame:CGRectMake(kSpaceW(10),  kSpaceH(12), kScreenWidth - kSpaceW(15) -  kSpaceW(25), kSpaceH(30)) andTitle:@"课程费用" placeHoler:@"输入课程的收费价格" andType:JBInputItemViewItemTypeText];
    feeItemView.labelWidth = kSpaceW(65);
    feeItemView.labelInputSpace = kSpaceW(50);
    [feeItemView showItemView];
    [feeView addSubview:feeItemView];
    self.feeItemView = feeItemView;
    UIView *lineViewSix = [self createLineView];
    lineViewSix.frame = CGRectMake(kSpaceW(10), CGRectGetMaxY(feeView.frame) + 1, kScreenWidth - kSpaceW(30), 1);
    self.lineViewSix = lineViewSix;
    [self addSubview:lineViewSix];


    [lineViewSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(feeView.mas_bottom);
        make.left.mas_equalTo(kSpaceW(10));
        make.width.mas_equalTo(kScreenWidth - kSpaceW(30));
        make.height.mas_equalTo(1);
    }];
    
    
}

- (void)_createCountView{
    /// 上课地点
    UIView *peopleCountView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineViewThree.frame), kScreenWidth - kSpaceW(10), kSpaceW(100))];
    self.peopleCountView = peopleCountView;
    [self addSubview:peopleCountView];
    
    [peopleCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineViewThree);
        make.width.mas_equalTo(kScreenWidth - kSpaceW(10));
        make.height.mas_equalTo(kSpaceW(45));
        make.left.mas_equalTo(0);
    }];
    
    
    UILabel *classTypeLabel = [UILabel createLabelWithFrame:CGRectMake(kSpaceW(10), 0 , kSpaceW(65), kSpaceH(45)) text:@"人数限制" textColor:color666666 font:font15 textAlignment:NSTextAlignmentLeft];
    [peopleCountView addSubview:classTypeLabel];
    
    UIButton *onePeopleButton = [UIButton createButtonWithFrame:CGRectMake(CGRectGetMaxX(classTypeLabel.frame) + kSpaceW(50), kSpaceH(10) , kSpaceH(55), kSpaceH(20)) withTitle:@"1人" withTitleColor:color999999 withTitleFont:kSpaceH(13) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
    self.onePeopleButton = onePeopleButton;
    onePeopleButton.tag = 106;
    UIButton *moreOnePeopleButton = [UIButton createButtonWithFrame:CGRectMake(CGRectGetMaxX(onePeopleButton.frame) + kSpaceW(20), kSpaceH(10) , kSpaceH(55), kSpaceH(20)) withTitle:@"多人" withTitleColor:color999999 withTitleFont:kSpaceH(13) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
    self.moreOnePeopleButton = moreOnePeopleButton;
    moreOnePeopleButton.tag = 107;

    [self configButton:onePeopleButton];
    [self configButton:moreOnePeopleButton];
    [peopleCountView addSubview:onePeopleButton];
    [peopleCountView addSubview:moreOnePeopleButton];

    UIView *lineViewFourth = [self createLineView];
    lineViewFourth.frame = CGRectMake(CGRectGetMinX(onePeopleButton.frame), CGRectGetMaxY(classTypeLabel.frame) + 1, kSpaceW(231), 1);
    self.lineViewFourth = lineViewFourth;
    [peopleCountView addSubview:lineViewFourth];
    
 
    UITextField *minTextField = [[UITextField alloc] init];
    minTextField.placeholder = @"最低人数";
    UILabel *lineLable = [[UILabel alloc] init];
    self.minTextField = minTextField;
    UITextField *maxTextField = [[UITextField alloc] init];
    maxTextField.placeholder = @"最大人数";
    self.maxTextField = maxTextField;
    self.maxTextField .keyboardType = UIKeyboardTypePhonePad;
    self.minTextField .keyboardType = UIKeyboardTypePhonePad;
    self.maxTextField.textAlignment =
    self.minTextField.textAlignment = NSTextAlignmentCenter;
    lineLable.backgroundColor = colorCCCCCC;
    self.lineLable = lineLable;
    [peopleCountView addSubview:minTextField];
    
    [peopleCountView addSubview:lineLable];
    [peopleCountView addSubview:maxTextField];
    
    minTextField.font = font12;
    maxTextField.font = font12;
    
    lineLable.textColor = colorE7E7E7;
    lineLable.textAlignment = NSTextAlignmentCenter;
    
    
    minTextField.borderStyle = UITextBorderStyleRoundedRect;
    maxTextField.borderStyle = UITextBorderStyleRoundedRect;

    
    [minTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineViewFourth.mas_bottom).mas_offset(kSpaceH(12));
        make.left.mas_equalTo(onePeopleButton);
        make.height.mas_equalTo(kSpaceH(30));
        make.width.mas_equalTo(kSpaceW(90));
    }];
    
    [maxTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineViewFourth.mas_bottom).mas_offset(kSpaceH(12));
        make.right.mas_equalTo(self.lineViewThree.mas_right).mas_offset(-kSpaceW(10));
        make.height.mas_equalTo(kSpaceH(30));
        make.width.mas_equalTo(kSpaceW(90));
    }];
    
    [lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(maxTextField);
        make.right.mas_equalTo(self.maxTextField.mas_left).mas_offset(-kSpaceW(8));
        make.left.mas_equalTo(self.minTextField.mas_right).mas_offset(kSpaceW(8));
        make.height.mas_equalTo(1);
    }];
    
    
    UIView *lineViewFive  = [[UIView alloc] init];
    lineViewFive.backgroundColor = colorE7E7E7;
    lineViewFive.frame = CGRectMake(kSpaceW(10), CGRectGetMaxY(peopleCountView.frame), kScreenWidth - kSpaceW(30), 1);
    [self addSubview:lineViewFive];
    self.lineViewFive = lineViewFive;
    [lineViewFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(peopleCountView.mas_bottom);
        make.left.mas_equalTo(kSpaceW(10));
        make.width.mas_equalTo(kScreenWidth - kSpaceW(30));
        make.height.mas_equalTo(1);
    }];
    
    self.lineViewFourth.hidden = YES;
    minTextField.hidden =
    maxTextField.hidden =
    lineLable.hidden = YES;
}


- (void)_createTeachAddress{
    /// 上课地点
   UIView * addressView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineViewTimeLengthViewBottom.frame), kScreenWidth - kSpaceW(10), kSpaceW(100))];
    [self addSubview:addressView];
    self.addressView = addressView;
        
    
    UILabel *classTypeLabel = [UILabel createLabelWithFrame:CGRectMake(kSpaceW(10), 0 , kSpaceW(65), kSpaceH(45)) text:@"上课地点" textColor:color666666 font:font15 textAlignment:NSTextAlignmentLeft];
    [addressView addSubview:classTypeLabel];

    UIButton *gotoHomeButton = [UIButton createButtonWithFrame:CGRectMake(CGRectGetMaxX(classTypeLabel.frame) + kSpaceW(50), kSpaceH(10) , kSpaceH(55), kSpaceH(20)) withTitle:@"上门" withTitleColor:color999999 withTitleFont:kSpaceH(13) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
     gotoHomeButton.tag = 103;

     UIButton *aggreeButton = [UIButton createButtonWithFrame:CGRectMake(CGRectGetMaxX(gotoHomeButton.frame) + kSpaceW(20), kSpaceH(10) , kSpaceH(55), kSpaceH(20)) withTitle:@"协商" withTitleColor:color999999 withTitleFont:kSpaceH(13) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
     aggreeButton.tag = 104;
    
     UIButton *regularButton = [UIButton createButtonWithFrame:CGRectMake(CGRectGetMaxX(aggreeButton.frame) + kSpaceW(20), kSpaceH(10) , kSpaceH(90), kSpaceH(25)) withTitle:@"固定地点" withTitleColor:color999999 withTitleFont:kSpaceH(13) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
    regularButton.tag = 105;
    [self configButton:regularButton];
    [self configButton:aggreeButton];
    [self configButton:gotoHomeButton];
    [addressView addSubview:regularButton];
    [addressView addSubview:aggreeButton];
    [addressView addSubview:gotoHomeButton];
    self.gotoHomeButton = gotoHomeButton;
    self.aggreeButton = aggreeButton;
    self.regularButton = regularButton;
    
    
    UIView *lineViewTwo = [self createLineView];
    lineViewTwo.frame = CGRectMake(CGRectGetMinX(gotoHomeButton.frame), CGRectGetMaxY(classTypeLabel.frame) + 1, kSpaceW(231), 1);
    self.lineViewTwo = lineViewTwo;
    [addressView addSubview:lineViewTwo];

    JBWLPublishInputView *addressItemView = [[JBWLPublishInputView alloc] initWithFrame:CGRectMake(kSpaceW(10), CGRectGetMaxY(lineViewTwo.frame) + kSpaceH(12), kScreenWidth - kSpaceW(15) -  kSpaceW(25), kSpaceH(30)) andTitle:@"" placeHoler:@"输入上课地点" andType:JBInputItemViewItemTypeText];
    addressItemView.labelWidth = kSpaceW(65);
    addressItemView.labelInputSpace = kSpaceW(50);
    [addressItemView showItemView];

    self.addressItemView = addressItemView;
    [addressView addSubview:addressItemView];
    
    
    UIView *lineViewThree = [self createLineView];
    lineViewThree.frame = CGRectMake(kSpaceW(10), CGRectGetMaxY(addressView.frame) , kScreenWidth - kSpaceW(30), 1);
    self.lineViewThree = lineViewThree;
    [self addSubview:lineViewThree];

///最开始隐藏
    lineViewTwo.hidden = YES;
    self.addressItemView.hidden = YES;
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineViewTimeLengthViewBottom);
        make.width.mas_equalTo(kScreenWidth - kSpaceW(10));
        make.height.mas_equalTo(kSpaceW(45));
        make.left.mas_equalTo(0);
    }];
    
    [lineViewThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addressView.mas_bottom);
        make.left.mas_equalTo(kSpaceW(10));
        make.width.mas_equalTo(kScreenWidth - kSpaceW(30));
        make.height.mas_equalTo(1);
    }];
    
    
}

- (void)configButton:(UIButton *)btn{
    
    [btn setImagePosition:ImageLabelPositionLeft spacing:kSpaceW(10)];
    [btn setImage:[UIImage imageNamed:@"JB_选择框_Selected"] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"JB_选择框_Normal"] forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];


}

- (void)_createClassType{
    
    UIImageView *topCornorImageView = [[UIImageView alloc] initWithCornerRadiusAdvance:10 rectCornerType:UIRectCornerTopLeft | UIRectCornerTopRight];
    topCornorImageView.frame = CGRectMake(0, 0, kScreenWidth - kSpaceW(10), kSpaceH(10));
    topCornorImageView.image = [UIImage imageWithColor:colorFFFFFF size:CGSizeMake(kScreenWidth - kSpaceW(10), kSpaceH(10))];
    [self addSubview:topCornorImageView];
   
    /// 课程类型
    UILabel *classTypeLabel = [UILabel createLabelWithFrame:CGRectMake(kSpaceW(10), CGRectGetMaxY(topCornorImageView.frame) , kSpaceW(65), kSpaceH(45)) text:@"课程类型" textColor:color666666 font:font15 textAlignment:NSTextAlignmentLeft];
    [self addSubview:classTypeLabel];
    self.classTypeLabel = classTypeLabel;
    
    UIButton *offLineChooseButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(classTypeLabel.frame) + kSpaceW(50), kSpaceH(10) + CGRectGetMinY(classTypeLabel.frame), kSpaceH(90), kSpaceH(25))];
    
    UIButton *onLineChooseButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(offLineChooseButton.frame), CGRectGetMinY(classTypeLabel.frame) + kSpaceH(10), kSpaceH(90), kSpaceH(25))];
    
    [self addSubview:offLineChooseButton];
    [self addSubview:onLineChooseButton];

    [self configButton:offLineChooseButton];
    [self configButton:onLineChooseButton];
    
    
    self.offLineChooseButton = offLineChooseButton;
    self.onLineChooseButton = onLineChooseButton;

    
    [offLineChooseButton setTitle:@"线下课" forState:UIControlStateNormal];
    [onLineChooseButton setTitle:@"语音教学" forState:UIControlStateNormal];
    [offLineChooseButton setTitleColor:color999999 forState:UIControlStateNormal];
    offLineChooseButton.titleLabel.font = font13;
    [onLineChooseButton setTitleColor:color999999 forState:UIControlStateNormal];
    onLineChooseButton.titleLabel.font = font13;
    [offLineChooseButton setImagePosition:ImageLabelPositionLeft spacing:kSpaceW(10)];
    [onLineChooseButton setImagePosition:ImageLabelPositionLeft spacing:kSpaceW(10)];
    offLineChooseButton.tag = 101;
    onLineChooseButton.tag = 102;
    [offLineChooseButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [onLineChooseButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineViewOne = [self createLineView];
    lineViewOne.frame = CGRectMake(kSpaceW(10), CGRectGetMaxY(classTypeLabel.frame) + 1, kScreenWidth - kSpaceW(30), 1);
    self.lineViewOne = lineViewOne;
    [self addSubview:lineViewOne];
}


- (UIView *)createLineView{
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = colorE7E7E7;
    return lineView;
}

- (UIButton *)chooseTagButton{
    if (!_chooseTagButton) {
        _chooseTagButton = [UIButton createButtonWithFrame:CGRectMake(kSpaceW(75) + kSpaceW(50), kSpaceH(10) , kSpaceH(105), kSpaceH(30)) withTitle:@"选择课程标签 》" withTitleColor:color999999 withTitleFont:kSpaceH(12) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
        self.chooseTagButton = _chooseTagButton;
        self.chooseTagButton.tag = 108;
      
    }
    return _chooseTagButton;
}

- (UILabel *)showTagLabel{
    if (!_showTagLabel) {
        _showTagLabel = [UILabel createLabelWithFrame:CGRectMake(kSpaceW(75) + kSpaceW(50), kSpaceH(10) , kSpaceW(65), kSpaceH(45)) text:@"课程类型" textColor:color00CCBB font:font15 textAlignment:NSTextAlignmentCenter];
        self.showTagLabel = _showTagLabel;
        self.showTagLabel.layer.cornerRadius = kSpaceW(15);
        self.showTagLabel.layer.borderWidth = 1;
        self.showTagLabel.layer.borderColor = color00CCBB.CGColor;
        self.showTagLabel.clipsToBounds = YES;
    }
    return _showTagLabel;
}

@end
