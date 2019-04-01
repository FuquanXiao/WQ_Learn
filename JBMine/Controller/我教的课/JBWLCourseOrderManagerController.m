//
//  JBWLCourseOrderManagerController.m
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLCourseOrderManagerController.h"
#import "JBWLCourseTeachOederController.h"

#import "JBWLEvaluateAndPayController.h"


#import "XFQNavigationView.h"
#import "WQScrollTitileView.h"

@interface JBWLCourseOrderManagerController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *bgScrollview;
@property (nonatomic, strong) NSMutableArray <JBWLCourseTeachOederController *> *listVCArray;
@property (nonatomic,strong)NSArray<NSString *> * titlesArray ;

@property (nonatomic,strong)WQScrollTitileView *titleView;

@property (nonatomic,assign)NSInteger titleCurrentSelectedIndex;
@end

@implementation JBWLCourseOrderManagerController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self _setNav];
    [self _createUI];
    
}

#pragma mark
#pragma mark-------Action -------

- (void)buttonAction:(UIButton *)btn{
    JBWLEvaluateAndPayController *evaluateAndPay = [[JBWLEvaluateAndPayController alloc] init];
    [self.navigationController pushViewController:evaluateAndPay animated:YES];
}

- (void)gotoBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)_setNav{
    
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = colorF3F3F3;
    XFQNavigationView  *nav =  [[XFQNavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, WQ_StatusBarAndNavigationBarHeight) leftImageName:@"JbAPP_Back" leftTitle:nil title:@"我教的课" target:self action:@selector(gotoBack) showBottomLine:YES];
    [self.view addSubview:nav];
    
    UIButton *courseManagerButton =[UIButton createButtonWithFrame:CGRectZero withTitle:@"课程管理" withTitleColor:color666666 withTitleFont:kSpaceH(13) withBackgroundColor:nil withTarget:self withAction:@selector(buttonAction:)];
    [nav addSubview:courseManagerButton];
    [courseManagerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nav.titleLabel);
        make.right.mas_equalTo(nav.mas_right).mas_offset(-kSpaceW(15));
    }];
    
    
    
    WQScrollTitileView *titleView = [[WQScrollTitileView alloc] initWithFrame:CGRectMake(5, WQ_StatusBarAndNavigationBarHeight + 5, kScreenWidth - 10,40)];
    titleView.nameArray = [self.titlesArray copy];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    __weak typeof(self) weakSelf = self;
    self.titleView.SelectedBlock = ^(NSInteger index) {
        [weakSelf.bgScrollview setContentOffset:CGPointMake((index - 1) * kScreenWidth, 0) animated:NO];
        weakSelf.titleCurrentSelectedIndex = index - 1;
        
    };
}

- (void)setTitleCurrentSelectedIndex:(NSInteger)titleCurrentSelectedIndex{
    _titleCurrentSelectedIndex = titleCurrentSelectedIndex;
    JBWLCourseTeachOederController * currentVC = self.listVCArray[titleCurrentSelectedIndex];
    [currentVC loadDataForFirst];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
    double tempSelectedDouble = scrollView.contentOffset.x / (kScreenWidth * 1.0);
    NSInteger tempSelectedIndex = round(tempSelectedDouble);
    if (self.titleCurrentSelectedIndex != tempSelectedIndex) {
        self.titleCurrentSelectedIndex = tempSelectedIndex;
        self.titleView.selectedIndex = self.titleCurrentSelectedIndex;
    }
}


- (void)_createUI{
    
    UIScrollView *bgScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, (WQ_StatusBarAndNavigationBarHeight + 5 + 40 + 8), kScreenWidth, kScreenHeight - WQ_StatusBarAndNavigationBarHeight - WQ_TabbarSafeBottomMargin - 40 - 5 - 8)];
    [self.view addSubview:bgScrollview];
    bgScrollview.backgroundColor = colorF3F3F3;
    bgScrollview.pagingEnabled = YES;
    bgScrollview.bounces = NO;
    bgScrollview.delegate = self;
    self.bgScrollview = bgScrollview;
    bgScrollview.contentSize = CGSizeMake(kScreenWidth * self.titlesArray.count, kScreenHeight - WQ_StatusBarAndNavigationBarHeight - WQ_TabbarSafeBottomMargin - 40 - 5 - 8);
    
    
    for (int i = 0; i < self.titlesArray.count; i++) {
        JBWLCourseTeachOederController * teachOrderController = [[JBWLCourseTeachOederController alloc] initWithType:i];
        NSMutableArray *aaa = [[NSMutableArray alloc] init];
        if (i == 0) {
            [aaa addObject:@""];
            [aaa addObject:@""];
            [aaa addObject:@""];
        }
        if (i == 1) {
            [aaa addObject:@""];
            [aaa addObject:@""];
            [aaa addObject:@""];
            [aaa addObject:@""];
            [aaa addObject:@""];
            [aaa addObject:@""];
        }
        teachOrderController.dataSourceArray = aaa;
        teachOrderController.view.frame = CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight - WQ_StatusBarAndNavigationBarHeight - WQ_TabbarSafeBottomMargin - 40 - 5 - 8);
        [self.listVCArray addObject:teachOrderController];
        [bgScrollview addSubview:teachOrderController.view];
    }
    self.titleCurrentSelectedIndex = 0;
    [self.listVCArray[self.titleView.selectedIndex] loadDataForFirst];
    [self.bgScrollview setContentOffset:CGPointMake(self.titleView.selectedIndex * kScreenWidth, 0) animated:NO];
}

- (NSMutableArray <JBWLCourseTeachOederController *> *)listVCArray{
    if (!_listVCArray) {
        _listVCArray = [[NSMutableArray alloc] init];
    }
    return _listVCArray;
}

- (NSArray <NSString *> *)titlesArray{
    if (!_titlesArray) {
        _titlesArray = @[@"全部",@"待开始",@"进行中",@"已结束"];
    }
    return _titlesArray;
}

@end
