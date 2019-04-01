//
//  JBWLCourseTeachOederController.m
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLCourseTeachOederController.h"

#import "JBWLCourseOrderListTableCell.h"

@interface JBWLCourseTeachOederController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *courseOrderTableView;
@property (nonatomic,assign)BOOL isFirstLoad;
@end


@implementation JBWLCourseTeachOederController

- (instancetype)initWithType:(JBWLCourseTeachOrderType)orderType{
    _orderType = orderType;
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self _createUI];
    [self addMoreOrRefresh];
}

- (void)addMoreOrRefresh{
    MJRefreshNormalHeader *jmfreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.courseOrderTableView.header = jmfreshHeader;
}

- (void)refreshData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.courseOrderTableView.header endRefreshing];
        [self.courseOrderTableView reloadData];
    });
}

- (void)loadDataForFirst{
   
    if (!_isFirstLoad) {
         [self.courseOrderTableView.header beginRefreshing];
        _isFirstLoad = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSpaceH(185);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JBWLCourseOrderListTableCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseOrderListTableCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.orderType == JBWLCourseTeachOrderAll) {
        cell.backgroundColor = [UIColor redColor];
    }
    //    NSArray *sectionArray = self.daaSourceArray[indexPath.section];
    //    NSString *title = sectionArray[indexPath.row];
    //    cell.cellTitleLabel.text = title;
    //    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Mine_%@",title]];
    //    cell.nextButton.userInteractionEnabled = NO;
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSpaceH(5))];
    sectionFooterView.backgroundColor = colorF2F2F2;
    return sectionFooterView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 10, kSpaceH(10))];
    sectionView.backgroundColor = colorFFFFFF;
    if (section == 0) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:sectionView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(kSpaceH(10), kSpaceH(10))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = sectionView.bounds;
        maskLayer.path = maskPath.CGPath;
        sectionView.layer.mask = maskLayer;
    }
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return kSpaceW(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return kSpaceH(5);
}

- (void)_createUI{
    self.view.backgroundColor = colorF3F3F3;
    [self.view addSubview:self.courseOrderTableView];
    
}

- (UITableView *)courseOrderTableView{
    if (!_courseOrderTableView) {
        _courseOrderTableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth - 10, kScreenHeight - WQ_StatusBarAndNavigationBarHeight - WQ_TabbarSafeBottomMargin - 40 - 5 - 8) style:UITableViewStyleGrouped];
        _courseOrderTableView.backgroundColor = kUIColorFromRGB(0xf4f4f4);
        _courseOrderTableView.delegate = self;
        _courseOrderTableView.dataSource = self;
        _courseOrderTableView.separatorColor = kUIColorFromRGB(0xf4f4f4);
        _courseOrderTableView.estimatedSectionHeaderHeight = 0;
        _courseOrderTableView.estimatedSectionFooterHeight = kSpaceH(5);
        _courseOrderTableView.estimatedRowHeight = kSpaceW(146);
        _courseOrderTableView.showsVerticalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            _courseOrderTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        
        [_courseOrderTableView registerClass:[JBWLCourseOrderListTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLCourseOrderListTableCell class])];
    }
    return _courseOrderTableView;
}



@end
