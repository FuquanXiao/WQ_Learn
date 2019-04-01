//
//  JBWLMineCenterController.m
//  JBApp
//
//  Created by apple on 2019/3/18.
//  Copyright © 2019 apple. All rights reserved.
// 新版本的4.3.0 个人中心

#import "JBWLMineCenterController.h"
#import "JBWLMineCenterHeaderView.h"
#import "JBWLMineCenterClassicalCourseTableCell.h"
#import "JBWLMineCenterSectionView.h"
#import "JBWLMineCenterClassTableCell.h"
#import "JBWLMineCenterTimeTableCell.h"
#import "JBMineCenterTagsTableCell.h"
#import "JBWLMineCenterKouBeiTableCell.h"
#import "JBWLSubscribeBottomView.h"
#import "JBWLBuyChooseClassController.h"

///照片墙的viewModel
#import "PhotoWalllViewModel.h"
///个人信息viewModel；
#import "JBWLUserViewModel.h"
///个人中心viewModel
#import "JBWLMineCenterViewModel.h"

#import "JBWLUserCourseModel.h"

#import "JBWLEvaluateLabModel.h"

#import "JBWLBuyChooseTimeController.h"

@interface JBWLMineCenterController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)JBWLMineCenterHeaderView *mineCenterView;
@property (nonatomic,strong)UITableView  *centerTableView ;
@property (nonatomic,strong)JBWLMineCenterSectionView *sectionOneView;
@property (nonatomic,strong)JBWLMineCenterSectionView *sectionTwoView;
@property (nonatomic,strong)JBWLMineCenterSectionView *sectionThreeView;
@property (nonatomic,strong)JBWLBuyChooseClassController *buyChooseVC;

@property (nonatomic,strong)JBWLMineCenterViewModel *mineCenterViewModel;
@property (nonatomic,strong)JBWLUserViewModel *userViewModel;

@property (nonatomic,strong)NSArray  *photoWallArray;
////精品课数量
@property (nonatomic,strong)NSString *qualityCount;

@property (nonatomic,strong)NSMutableArray *courseListArray;

@property (nonatomic,strong)NSMutableArray *teachScheduleArray;

@property (nonatomic,strong)NSMutableArray *evaluateLabArray;


@end

@implementation JBWLMineCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _nav];
    [self _createHeaderView];
    [self _createTableView];
    [self loadDataSourceRequest];
}

- (void)_nav{
    self.fd_prefersNavigationBarHidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _mineCenterViewModel = [[JBWLMineCenterViewModel alloc] init];
}


- (void)editClassTimeAction:(UIButton *)btn{
    JBWLBuyChooseTimeController *editTime = [[JBWLBuyChooseTimeController alloc] init];
    editTime.timeType = JBWLBuyChooseTimeTypeAdd;
    [self.navigationController pushViewController:editTime animated:YES];
}

- (void)loadDataSourceRequest{
    [self loadPhotoWallWithUserId:self.userId];
    [self loadMineCenterWithUserId:self.userId sourceType:self.sourceType];
    [self loadQualityCourseWithUserId:self.userId];
    [self loadUserCourseListWithUserId:self.userId];
    [self loadTeacheSchedulWithUserId:self.userId];
    [self loadEvaluateLabWithUserId:self.userId andCourseId:@""];
}


- (void)loadEvaluateLabWithUserId:(NSString *)userId andCourseId:(NSString *)courseId{
    __weak typeof(self) weakSelf = self;

    [_mineCenterViewModel loadEvaluateLabWithUserId:userId andCourseId:courseId andComletion:^(id model, NSString *desString) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (desString) {
            [strongSelf showHudMessage:desString hidenAfterDelay:1];
        }
        else{
            NSMutableArray  *temEvaluateLabArray = [(NSMutableArray *)model copy];
            
            for (JBWLEvaluateLabModel *model in temEvaluateLabArray) {
                [strongSelf.evaluateLabArray addObject:[NSString stringWithFormat:@"%@%@",model.labName,model.labNum]];
            }
            
            [strongSelf.centerTableView reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)loadTeacheSchedulWithUserId:(NSString *)userId{
    __weak typeof(self) weakSelf = self;

    [_mineCenterViewModel loadTeacherSchduleWithUserId:userId andComletion:^(id model, NSString *desString) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (desString) {
            [strongSelf showHudMessage:desString hidenAfterDelay:1];
        }
        else{
            strongSelf.teachScheduleArray = [(NSMutableArray *)model copy];
            [strongSelf.centerTableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}


- (void)loadUserCourseListWithUserId:(NSString *)userId{
    __weak typeof(self) weakSelf = self;

    [_mineCenterViewModel loadCourseListWithUserId:userId andComletion:^(id model, NSString *desString) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (desString) {
            [strongSelf showHudMessage:desString hidenAfterDelay:1];
        }
        else{
            strongSelf.courseListArray = [(NSMutableArray *)model copy];
            [strongSelf.centerTableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
            strongSelf.sectionOneView.sectionTitleLabel.text =  [NSString stringWithFormat:@"预约课%lu个",(unsigned long)strongSelf.courseListArray.count];
        }
    }];
}


- (void)loadQualityCourseWithUserId:(NSString *)userId{
    __weak typeof(self) weakSelf = self;

    [_mineCenterViewModel loadQualityCourseCountWithUserId:userId andComletion:^(id model, NSString *desString) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (desString) {
            [strongSelf showHudMessage:desString hidenAfterDelay:1];
        }
        else{
            strongSelf.qualityCount = (NSString *)[model copy];
            [strongSelf.centerTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}


- (void)loadPhotoWallWithUserId:(NSString *)userId {
    
    __weak typeof(self) weakSelf = self;
    [_mineCenterViewModel loadPhotoWallWith:userId completion:^(NSArray *listArray, NSString *desString) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (desString) {
            [strongSelf showHudMessage:desString hidenAfterDelay:1];
        }
        else{
            if (strongSelf.mineCenterViewModel.cycleImageArray.count<1) {
                strongSelf.mineCenterView.cycleScrollview.localizationImageNamesGroup = @[[UIImage imageNamed:@"MineCenter_PhotoWall_默认"]];
            }
            else{
                strongSelf.mineCenterView.cycleScrollview.imageURLStringsGroup = [strongSelf.mineCenterViewModel.cycleImageArray copy];
            }
            self.photoWallArray = [listArray copy];
        }
    }];
}

/**
 mvvm 如果没有实现数据的双向绑定 会成为什么？ 难道MVVM一定要双向绑定吗？
 mvc 和mvvm的区别又有什么的？
 mvp有是干什么的？  mvvm 和mvp的区别又是什么？
 登录界面输入框 （view）文字变化了如何改变model 的值
 
 model 又如何被监听到，进而修改view的值；

 @param userId <#userId description#>
 @param sourceType <#sourceType description#>
 */
- (void)loadMineCenterWithUserId:(NSString *)userId sourceType:(NSString *)sourceType{
    
    __weak typeof(self) weakSelf = self;

    [_mineCenterViewModel loadUserIntroWithUserId:self.userId andSourceType:self.sourceType andComletion:^(id model, NSString *desString) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (desString) {
            [strongSelf showHudMessage:desString hidenAfterDelay:1];
        }
        else{
           JBWLUserViewModel *viewModel = (JBWLUserViewModel *)model;
           strongSelf.userViewModel = viewModel;
           strongSelf.mineCenterView.userViewModel = viewModel;
            ///这一段网络请求之后赋值使用；
            
            NSString *contentString = SafeValue(viewModel.userModel.useDescription);
            
//            NSString * firstStr = [contentString substringToIndex:contentString.length - 5]; //去除掉首尾的空白字符和换行字符
//            NSString *lastStr = [contentString substringWithRange:NSMakeRange(contentString.length - 5, 5)];
//
//            NSString * str  = [lastStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
//
//            str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//
//            contentString = [contentString stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\r\n"];
//
            contentString = [NSString stringWithFormat:@"%@%@",contentString, @"\n"];
            
            
            CGFloat labelHeight = [strongSelf.mineCenterView setContentLabelTextWithContent:contentString];
            
            [strongSelf showUserInfoWithLabelHeight:labelHeight andShowAll:NO];
            
            __strong typeof(strongSelf) weakweakSelf = strongSelf;

            strongSelf.mineCenterView.showAllText = ^{
                [weakweakSelf showUserInfoWithLabelHeight:labelHeight andShowAll:YES];
            };
            
            strongSelf.mineCenterView.hideAllText = ^{
                [weakweakSelf showUserInfoWithLabelHeight:labelHeight andShowAll:NO];
            };
            
            [self.centerTableView reloadData];
        }
    }];
}



- (void)_createTableView{
    _centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - WQ_TabbarSafeBottomMargin - 50) style:UITableViewStyleGrouped];
    [self.view addSubview:_centerTableView];
    
    _centerTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _centerTableView.delegate = self;
    _centerTableView.dataSource = self;
    _centerTableView.estimatedRowHeight = 100;
    _centerTableView.rowHeight = UITableViewAutomaticDimension;
    _centerTableView.estimatedSectionFooterHeight =
    _centerTableView.estimatedSectionHeaderHeight = 0.01;
    _centerTableView.separatorColor = [UIColor clearColor];
    _centerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _centerTableView.tableHeaderView = self.mineCenterView;
    
    if (@available(iOS 11.0, *)) {
        _centerTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    
    [_centerTableView registerClass:[JBWLMineCenterClassicalCourseTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLMineCenterClassicalCourseTableCell class])];
    
    [_centerTableView registerNib:[UINib nibWithNibName:@"JBWLMineCenterClassTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([JBWLMineCenterClassTableCell class])];
    
    [_centerTableView registerClass:[JBWLMineCenterTimeTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLMineCenterTimeTableCell class])];
    
    [_centerTableView registerClass:[JBMineCenterTagsTableCell class] forCellReuseIdentifier:NSStringFromClass([JBMineCenterTagsTableCell class])];
    
    [_centerTableView registerClass:[JBWLMineCenterKouBeiTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLMineCenterKouBeiTableCell class])];
    
    [_centerTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    
    JBWLSubscribeBottomView *bottomView = [[JBWLSubscribeBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - WQ_TabbarSafeBottomMargin - 50, kScreenWidth, 50)];
    [self.view addSubview:bottomView];
    
    bottomView.chatBlock = ^{
        
    };
    
    bottomView.buyBlock = ^{
        [self addChildViewController:self.buyChooseVC];
        self.buyChooseVC.classArray = self.courseListArray;
        [self.view addSubview:self.buyChooseVC.view];
    };
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        JBWLMineCenterClassicalCourseTableCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLMineCenterClassicalCourseTableCell class])];
        if (!cell) {
            cell = [[JBWLMineCenterClassicalCourseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([JBWLMineCenterClassicalCourseTableCell class])];
            
        }
        cell.cellTitleLabel.text = [NSString stringWithFormat:@"特色精品课%@个",SafeValue(self.qualityCount)];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else if (indexPath.section == 1) {
        JBWLMineCenterClassTableCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLMineCenterClassTableCell class])];
        if (!cell) {
            cell = [[JBWLMineCenterClassTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([JBWLMineCenterClassTableCell class])];
        }
        JBWLUserCourseModel *model = self.courseListArray[indexPath.row];
        
        cell.courseModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 2) {
        JBWLMineCenterTimeTableCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLMineCenterTimeTableCell class])];
        if (!cell) {
            cell = [[JBWLMineCenterTimeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([JBWLMineCenterTimeTableCell class])];
        }
        cell.scheduleModelArray = self.teachScheduleArray ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    else if (indexPath.section == 3) {
        JBMineCenterTagsTableCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBMineCenterTagsTableCell class])];
        if (!cell) {
            cell = [[JBMineCenterTagsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([JBMineCenterTagsTableCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.tagsArray = [self.evaluateLabArray mutableCopy];
        return cell;
    }
    else if (indexPath.section == 4) {
        JBWLMineCenterKouBeiTableCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLMineCenterKouBeiTableCell class])];
        if (!cell) {
            cell = [[JBWLMineCenterKouBeiTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([JBWLMineCenterKouBeiTableCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        return cell;
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return self.courseListArray.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        self.sectionOneView.nextButton.hidden = YES;
        self.sectionOneView.sectionTitleLabel.text =  [NSString stringWithFormat:@"预约课%lu个",(unsigned long)self.courseListArray.count];
        return self.sectionOneView;
    }
    else if (section == 2){
        self.sectionTwoView.nextButton.hidden = NO;
        self.sectionTwoView.sectionTitleLabel.text = @"预约时间";
        [self.sectionTwoView.nextButton addTarget:self action:@selector(editClassTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        return self.sectionTwoView;
    }
    else if (section == 3){
        self.sectionThreeView.nextButton.hidden = YES;
        self.sectionThreeView.sectionTitleLabel.text = @"圈内口碑";
        return self.sectionThreeView;
    }
    else{
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return kSpaceH(10);
    }
    else if (section == 1) {
        return kSpaceH(51);
    }
    else if (section == 2) {
        return kSpaceH(51);
    }
    else if (section == 3) {
        return kSpaceH(51);
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return kSpaceH(10);
    }
    else if (section == 1) {
        return 8;
    }
    else if (section == 2) {
        return 10;
    }
  
    return 0.01;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    if (indexPath.section == 1) {
         return kSpaceH(132);
    }
    else if (indexPath.section == 2) {
        return kSpaceH(166);
    }
    else if (indexPath.section == 3) {
        return [JBMineCenterTagsTableCell getCellHeightWithArray:[@[@"讲课认真23",@"细心解答2",@"人很nice3",@"讲的不好3",@"态度很差2"] mutableCopy]] + kSpaceH(20) + kSpaceH(20);
    }
    else if (indexPath.section == 4) {
        return [JBWLMineCenterKouBeiTableCell getCellHeightWithContentString:@"简单暴力，却是最最常用的方法，直接将图片设置为ImageView的image属性，图片便会随UIImageView对象的大小做自动拉伸。这种拉伸的方法有一个致命的缺陷，它会使图像发生失真与形变"];
    }
     return 55;
}

- (void)_createHeaderView{
    self.mineCenterView = [[JBWLMineCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSpaceH(372))];
    
    [self.view addSubview:self.mineCenterView];
    
    
    
}


- (void)showUserInfoWithLabelHeight:(CGFloat)labelHeight andShowAll:(BOOL)showAll{

    if (!showAll) {
        CGFloat reallyHeight = [self.mineCenterView reInitLabelFrameWithHeight:labelHeight];
        
        self.mineCenterView.userInfoImageView.frame = CGRectMake(0, kSpaceH(185), kScreenWidth, kSpaceH(107) + reallyHeight + kSpaceH(20));
        
        self.mineCenterView.frame = CGRectMake(0, 0, kScreenWidth, kSpaceH(185) + kSpaceH(107) + reallyHeight + kSpaceH(20));
    }
    else{
        self.mineCenterView.userInfoImageView.frame = CGRectMake(0, kSpaceH(185), kScreenWidth, kSpaceH(107) + labelHeight + kSpaceH(26));
        self.mineCenterView.frame = CGRectMake(0, 0, kScreenWidth, kSpaceH(185) + kSpaceH(107) + labelHeight + kSpaceH(26));
    }
    
    self.centerTableView.tableHeaderView = self.mineCenterView;
    
}


- (NSMutableArray *)evaluateLabArray{
    if (!_evaluateLabArray) {
        _evaluateLabArray = [[NSMutableArray alloc] init];
    }
    return _evaluateLabArray;
}

- (JBWLMineCenterSectionView *)sectionOneView{
    if (!_sectionOneView) {
        _sectionOneView = [[JBWLMineCenterSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSpaceH(51)) showTopCornor:YES];
        _sectionOneView.nextButton.hidden = YES;
    }
    return _sectionOneView;
}
- (JBWLMineCenterSectionView *)sectionTwoView{
    if (!_sectionTwoView) {
        _sectionTwoView = [[JBWLMineCenterSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSpaceH(51)) showTopCornor:NO];
    }
    return _sectionTwoView;
}

- (JBWLMineCenterSectionView *)sectionThreeView{
    if (!_sectionThreeView) {
        _sectionThreeView = [[JBWLMineCenterSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSpaceH(51)) showTopCornor:YES];
    }
    return _sectionThreeView;
}

- (JBWLBuyChooseClassController *)buyChooseVC{
    if (!_buyChooseVC) {
        _buyChooseVC = [[JBWLBuyChooseClassController alloc] init];
        _buyChooseVC.userId = self.userId;
    }
    return _buyChooseVC;
}

@end
