//
//  JBWLEvaluateAndPayController.m
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLEvaluateAndPayController.h"
#import "XFQNavigationView.h"
#import "XFQTagsView.h"

@interface JBWLEvaluateAndPayController ()

@property (nonatomic,strong)NSArray *evaluateArray;
@property (nonatomic,strong)NSArray<UIColor *> *evaluateColorArray;
@property (nonatomic,strong)XFQTagsView *tagsView ;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIView *lineViewTwo;
@property (nonatomic,strong)NSMutableArray *evaluateTagsArray;
@property (nonatomic,strong)NSMutableArray<UIButton *> *buttonArray;
@property (nonatomic,strong)UIImageView * topImageView;
@property (nonatomic,strong)UIImageView * commentImageView;
@property (nonatomic,strong)WQTextView *contentTextView;
@end

@implementation JBWLEvaluateAndPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setNav];
    [self _createUI];
}

- (void)evaluateButtonAction:(WQButton *)btn{
    
    for (int i = 0; i<btn.tag; i++) {
        [self.evaluateTagsArray addObject:self.evaluateArray[i]];
    }
    
    for (WQButton * tempButton in self.buttonArray) {
        tempButton.selected = NO;
    }
    btn.selected = YES;
    [self reSetTagsDataSourceWithTag:btn.tag];
}

- (void)gotoBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)_setNav{
    
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = colorF3F3F3;
    XFQNavigationView  *nav =  [[XFQNavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, WQ_StatusBarAndNavigationBarHeight) leftImageName:@"JbAPP_Back" leftTitle:nil title:@"评价并支付" target:self action:@selector(gotoBack) showBottomLine:YES];
    [self.view addSubview:nav];
    
}

- (void)_createUI{
    
    UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, WQ_StatusBarAndNavigationBarHeight + 5, kScreenWidth - 10, kSpaceH(85))];
    topImageView.backgroundColor = colorFFFFFF;
    topImageView.userInteractionEnabled = YES;
    topImageView.layer.cornerRadius = kSpaceW(15);
    topImageView.clipsToBounds = YES;
    [self.view addSubview:topImageView];
    self.topImageView = topImageView;
    CGFloat buttonWidth = (kScreenWidth - 10) / self.evaluateArray.count;
    
    for (int i = 0; i < self.evaluateArray.count ; i++) {
        
        NSString *titleString = self.evaluateArray[i];
        WQButton *evaluateButton = [[WQButton alloc] initWithFrame:CGRectMake(i * buttonWidth, kSpaceH(10) , buttonWidth, kSpaceH(70))];
        [evaluateButton setTitle:titleString forState:UIControlStateNormal];
        [evaluateButton setTitleColor:kUIColorFromRGB(0xB5B5B5) forState:UIControlStateNormal];
        [evaluateButton setTitleColor:self.evaluateColorArray[i] forState:UIControlStateSelected];
        evaluateButton.titleLabel.font = font10;
        NSString *normalImageName = [NSString stringWithFormat:@"JBWL_Evaluate_%@_Normal",titleString];
        NSString *selectedImageName = [NSString stringWithFormat:@"JBWL_Evaluate_%@_Selected",titleString];

        [evaluateButton setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
        [evaluateButton setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
        [topImageView addSubview:evaluateButton];
        evaluateButton.tag = i;
        [evaluateButton addTarget:self action:@selector(evaluateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [evaluateButton setLabelImagePosition:WQButtonImageTop space:kSpaceH(10)];
        
        if (i == 0) {
            evaluateButton.selected = YES;
        }
        [self.buttonArray addObject:evaluateButton];
    }
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = colorE7E7E7;;
    lineView.frame = CGRectMake(kSpaceW(10), kSpaceH(80), kScreenWidth - kSpaceW(20) - 10, 1);
    [topImageView addSubview:lineView];
    self.lineView = lineView;
    
    XFQTagsView *tagsView = [[XFQTagsView alloc] init];
    [topImageView addSubview:tagsView];
    self.tagsView = tagsView;
    
    UIImageView * commentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    commentImageView.backgroundColor = colorFFFFFF;
    commentImageView.userInteractionEnabled = YES;
    commentImageView.layer.cornerRadius = kSpaceW(15);
    commentImageView.clipsToBounds = YES;
    [self.view addSubview:commentImageView];
    self.commentImageView = commentImageView;
    
    [self.commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImageView.mas_bottom).mas_offset(kSpaceH(5));
        make.width.left.mas_equalTo(self.topImageView);
        make.height.mas_equalTo(kSpaceW(250));
    }];
    
    
    UILabel *tittleLalel = [UILabel createLabelWithFrame:CGRectZero text:@"评价： " textColor:color555555 font:font16 textAlignment:NSTextAlignmentLeft];
    
    [commentImageView addSubview:tittleLalel];
    
    [commentImageView addSubview:self.contentTextView];
    
    [tittleLalel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.commentImageView);
        make.left.mas_equalTo(kSpaceH(10));
        make.height.mas_equalTo(kSpaceH(44));
    }];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tittleLalel.mas_bottom);
        make.left.mas_equalTo(tittleLalel);
        make.right.mas_equalTo(self.commentImageView.mas_right).mas_offset(-kSpaceH(10));
        make.height.mas_equalTo(kSpaceH(135));
    }];
    
    UIView *lineViewTwo = [[UIView alloc] init];
    lineViewTwo.backgroundColor = colorE7E7E7;;
   
    [commentImageView addSubview:lineViewTwo];
    self.lineViewTwo = lineViewTwo;
    
    [self.lineViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentTextView.mas_bottom).mas_offset(kSpaceH(5));
        make.left.mas_equalTo(self.commentImageView).mas_offset(kSpaceW(10));
        make.right.mas_equalTo(self.commentImageView.mas_right).mas_offset(-kSpaceH(10));
        make.height.mas_equalTo(1);
    }];
    
    UIButton *nextbutton = [[UIButton alloc] initWithFrame:CGRectMake(20, 4.5, 150 , 40)];
    [nextbutton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [nextbutton setTitle:@"确 认 评 价" forState:UIControlStateNormal];
    nextbutton.backgroundColor = color00CCBB;
    nextbutton.titleLabel.font = font16;
    [nextbutton setTitleColor:colorFFFFFF forState:UIControlStateNormal];
    nextbutton.layer.cornerRadius = 17.5;
    nextbutton.clipsToBounds = YES;
    [commentImageView addSubview:nextbutton];
    nextbutton.adjustsImageWhenHighlighted = NO;
    [nextbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineViewTwo.mas_bottom).mas_offset(kSpaceH(15));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(150);
    }];
    
    
    [self reSetTagsDataSourceWithTag:0];
}

- (void)reSetTagsDataSourceWithTag:(NSInteger)tag{
    
    self.tagsView.tagBgViewWidth = kScreenWidth - 10 - kSpaceW(20);
    self.tagsView.textColor = self.evaluateColorArray[tag];
    self.tagsView.borderColor = self.evaluateColorArray[tag];
    CGFloat tagsHeight = [self.tagsView showTagsViewWithArray:self.evaluateTagsArray createTag:YES];
    
    self.tagsView.frame = CGRectMake(kSpaceW(10) + 5, CGRectGetMaxY(self.lineView.frame) + kSpaceH(10), kScreenWidth - kSpaceW(20) - 20, tagsHeight);
    self.topImageView.frame = CGRectMake(5, WQ_StatusBarAndNavigationBarHeight + 5, kScreenWidth - 10, CGRectGetMaxY(self.lineView.frame) + kSpaceH(10) + tagsHeight + kSpaceH(10));
    
}


- (NSMutableArray *)evaluateTagsArray{
    if (!_evaluateTagsArray) {
        _evaluateTagsArray = [@[@"讲课认真23",@"细心解答2",@"人很nice3",@"不满意",@"细心解答2"] mutableCopy];
    }
    return _evaluateTagsArray;
}

- (NSArray *)evaluateArray{
    if (!_evaluateArray) {
        _evaluateArray = @[@"很满意",@"满意",@"一般",@"不满意",@"极不满意"];
    }
    return _evaluateArray;
}

- (NSArray <UIColor *> *)evaluateColorArray{
    if (!_evaluateColorArray) {
        _evaluateColorArray = @[kUIColorFromRGB(0xFF4200),kUIColorFromRGB(0xFF7800),kUIColorFromRGB(0xFFBA00),kUIColorFromRGB(0x971B1B),kUIColorFromRGB(0x5D2E0F)];
    }
    return _evaluateColorArray;
}

- (NSMutableArray <UIButton *> *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc] init];;
    }
    return _buttonArray;
}

- (WQTextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [[WQTextView alloc] initWithFrame:CGRectMake(10, WQ_StatusBarAndNavigationBarHeight +  39 + 10, kScreenWidth - 20, 120)];
        _contentTextView.backgroundColor = [UIColor cyanColor];
        self.contentTextView = _contentTextView;
        _contentTextView.font = font14;
        _contentTextView.placeholderFont = font12;
        _contentTextView.textColor = color666666;
        _contentTextView.placeholderColor = color999999;
        _contentTextView.placeholder = @"希望可以得到您的宝贵意见";
    }
    return  _contentTextView;
}
@end
