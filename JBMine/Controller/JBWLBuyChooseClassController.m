//
//  JBWLBuyChooseClassController.m
//  JBApp
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLBuyChooseClassController.h"
#import "JBWLBuyChooseClassTableCell.h"
#import "JBWLSubscribeBottomView.h"
#import "JBWLBuyChooseTimeController.h"
#import "JBWLCourseTimeModel.h"
@interface JBWLBuyChooseClassController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UITableView *couponTableView;
@property (nonatomic,strong)UIButton *timeButton;

@property (nonatomic,strong)JBWLCourseTimeModel *chooseTimeModel;
@end


@implementation JBWLBuyChooseClassController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self _setNav];
    [self _createUI];
}

- (void)_setNav{
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
}

- (void)setClassArray:(NSMutableArray *)classArray{
    _classArray = classArray;
    [self.couponTableView reloadData];
}

- (void)backReturn{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    for (JBWLUserCourseModel *model in self.classArray) {
        model.hadSelected = NO;
    }
    
    JBWLUserCourseModel *model  =  self.classArray[indexPath.row];
    model.hadSelected = YES;
    
    [self.couponTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.classArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSpaceH(35);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JBWLBuyChooseClassTableCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLBuyChooseClassTableCell class]) forIndexPath:indexPath];
    JBWLUserCourseModel *model = self.classArray[indexPath.row];
    cell.courseModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)_createUI{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - WQ_TabbarSafeBottomMargin - kSpaceH(385), kScreenWidth, kSpaceH(385))];
    self.contentView = contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kSpaceH(10), kSpaceH(10))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    
    [self createContent];
}

- (void)createContent{
    
//    WQNavigationView *nav = [[WQNavigationView alloc] initWithFrame:CGRectMake(10, - WQ_StatusBarHeight, kScreenWidth, 44 + WQ_StatusBarHeight) leftImageName:@"JbAPP_Back" leftTitle:@"您选择的课程" target:self action:@selector(gotoBack) showBottomLine:YES];
//    [self.contentView addSubview:nav];
    
    
    UIButton *titleBakButton = [UIButton createButtonWithFrame:CGRectMake(10, kSpaceH(20), kScreenWidth - 32, kSpaceH(16)) withTitle:@"您选择的课程" withImage:@"JbAPP_Back" withTitleColor:color444444 withTitleFont:kSpaceW(17)];
    [titleBakButton setImagePosition:ImageLabelPositionLeft spacing:6];
    [titleBakButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [titleBakButton addTarget:self action:@selector(backReturn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:titleBakButton];
    
    UITableView *couponTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSpaceH(50), kScreenWidth, kSpaceH(105)) style:UITableViewStylePlain];
    self.couponTableView = couponTableView;
    self.couponTableView.separatorColor = [UIColor clearColor];
    self.couponTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.couponTableView.backgroundColor = colorFFFFFF;
    [self.contentView addSubview:couponTableView];

    [self.couponTableView registerClass:[JBWLBuyChooseClassTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLBuyChooseClassTableCell class])];
    
    couponTableView.delegate = self;
    couponTableView.dataSource = self;
    couponTableView.bounces = NO;
    
    if (@available(iOS 11.0, *)) {
        couponTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    JBWLSubscribeBottomView *bottomView = [[JBWLSubscribeBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - WQ_TabbarSafeBottomMargin - 50, kScreenWidth, 50)];
    [self.view addSubview:bottomView];
    
    bottomView.chatBlock = ^{
        
    };
    
    bottomView.buyBlock = ^{

    };
    
    UIView *titleLineView = [[UIView alloc] initWithFrame:CGRectMake(kSpaceH(10), CGRectGetMaxY(self.couponTableView.frame) + kSpaceH(25), kScreenWidth - 20 , 1)];
    [self.contentView addSubview:titleLineView];
    titleLineView.backgroundColor = colorEBEBEB;
    
    
    UIButton *timeButton = [[UIButton alloc] init];
    [timeButton setTitle:@"" forState:UIControlStateNormal];
    [timeButton setTitleColor:color00CCBB forState:UIControlStateNormal];
    timeButton.titleLabel.font = font12;
    [self.contentView addSubview:timeButton];
    self.timeButton = timeButton;
    
    [timeButton setImagePosition:ImageLabelPositionLeft spacing:kSpaceW(8)];
    
    [timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLineView.mas_bottom).mas_offset(kSpaceH(16));
        make.left.mas_equalTo(10);
    }];
    
    
    UIButton *chooseTimeButton = [UIButton createButtonWithFrame:CGRectZero withTitle:@"选择您的上课时间 》" withTitleColor:colorFFFFFF withTitleFont:kSpaceH(15) withBackgroundColor:color00CCBB withTarget:self withAction:@selector(chooseTimeButtonAction:)];
    [self.contentView addSubview:chooseTimeButton];
    chooseTimeButton.layer.cornerRadius = kSpaceH(20);
    chooseTimeButton.clipsToBounds = YES;
    [chooseTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bottomView.mas_top).mas_offset(kSpaceH(-50));
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kSpaceH(250));
        make.height.mas_equalTo(kSpaceH(40));
    }];
    
}

- (void)chooseTimeButtonAction:(UIButton *)btn{
    JBWLBuyChooseTimeController *buyChooseTime = [[JBWLBuyChooseTimeController alloc] init];
    buyChooseTime.userId = self.userId;
    buyChooseTime.timeType = JBWLBuyChooseTimeChoose;
    buyChooseTime.chooseIdBlock = ^(JBWLCourseTimeModel * _Nonnull timeModel) {
        self.chooseTimeModel = timeModel;
        [self.timeButton setImage:[UIImage imageNamed:@"JBWL_ChooseTime_Delected"] forState:UIControlStateNormal];
        [self.timeButton setTitle:[NSString stringWithFormat:@"%@  %@-%@",SafeValue(timeModel.hadChooseWeekdayTime),SafeValue(timeModel.startTime),SafeValue(timeModel.endTime)] forState:UIControlStateNormal];
        [self.timeButton setTitleColor:color00CCBB forState:UIControlStateNormal];
    };
    buyChooseTime.hadSelectedTimeModel = self.chooseTimeModel;
    [self.navigationController pushViewController:buyChooseTime animated:YES];
}

@end
