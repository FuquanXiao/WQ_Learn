//
//  JBWLCourseDetailController.m
//  JBApp
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 apple. All rights reserved.
//课程详情

#import "JBWLCourseDetailController.h"
#import "XFQNavigationView.h"
#import "JBWLCourseDetailHeaderView.h"
///  课程详情 课程信息
#import "JBWLCourseDetailCourseInfoTableCell.h"

#import "JBWLCourseDetailHeaderTableCell.h"

#import "JBWLCourseDetailSoundTableCell.h"

#import "JBWLCourseTitleTableCell.h"


@interface JBWLCourseDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *courseDetailTableView;
@property (nonatomic,strong)JBWLCourseDetailHeaderView *detailHeaderView;

@property (nonatomic,assign) NSInteger courseType;

@end

@implementation JBWLCourseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setNav];
    [self _courseDetailTableView];
    self.courseType = 3;
}

- (void)gotoBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareButtonAction:(UIButton *)shareButton{
    
}


NSString *contString = @"请对您的教学内容进行具体的，描述请对您的教学内容进 行具体的描。述请对您的教学内容进行 具体的描述请对您的教学内容进行，具体的前段时间，有个朋友让我帮忙做一个图片在UIScrollView滑动翻页的效果，只不过图片宽度只有屏幕的一半，屏幕左边展示上一张图片右半部分，屏幕中间展示当前图片全部，屏幕右边展示下一张图片的左半部分，而且每次滑动半个屏幕，将下一个图片移动屏幕中央，要实现的效果图如下。";

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /// 文本
    if (self.courseType == 1) {
       
        if (indexPath.section == 0) {
            return  kSpaceH(60);
        }
        if (indexPath.section == 1) {
            return [JBWLCourseDetailCourseInfoTableCell getContentHeight:contString];
        }
    }
    ///图片
    if (self.courseType == 2) {
        if (indexPath.section == 0) {
            return kSpaceH(210);
        }
        if (indexPath.section == 1) {
            return  kSpaceH(45);
        }
        if (indexPath.section == 2) {
            return [JBWLCourseDetailCourseInfoTableCell getContentHeight:contString];
        }
        
    }
    ///语音
    if (self.courseType == 3) {
        if (indexPath.section == 0) {
            return  kSpaceH(60);
        }
        if (indexPath.section == 1) {
            return  55;
        }
        if (indexPath.section == 2) {
            return [JBWLCourseDetailCourseInfoTableCell getContentHeight:contString];
        }
    }
    
    return 0.01;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.courseType == 1) {
        if (section == 0) {
            return kSpaceH(5);
        }
    }
    if (self.courseType == 2) {
        if (section == 0) {
            return kSpaceH(0);
        }
    }
    if (self.courseType == 3) {
        if (section == 0) {
            return kSpaceH(5);
        }
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    if (self.courseType == 1) {
        return 0.01;
    }
    
    if (self.courseType == 2) {
        return 0.01;
    }
    if (self.courseType == 3) {
        return 0.01;
    }
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.courseType == 1) {
        return 2;
    }
    if (self.courseType == 2) {
        return 3;
    }
    if (self.courseType == 3) {
        return 3;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.courseType == 1) {
        
        if (indexPath.section == 0) {
 
            JBWLCourseTitleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseTitleTableCell class])];
            return cell;
        }
        else  {
            
            JBWLCourseDetailCourseInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseDetailCourseInfoTableCell class])];
            cell.contentString = contString;
            return cell;
        }
    }
    
    if (self.courseType == 2) {
        
        if (indexPath.section == 0) {
            JBWLCourseDetailHeaderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseDetailHeaderTableCell class])];
            return cell;
        }
        
        
        if (indexPath.section == 1) {
            
            JBWLCourseTitleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseTitleTableCell class])];
            cell.courseType = self.courseType;
            return cell;
        }
        else  {
            
            JBWLCourseDetailCourseInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseDetailCourseInfoTableCell class])];
            cell.contentString = contString;
            return cell;
        }
    }
    if (self.courseType == 3) {
        
        
        
        
        if (indexPath.section == 0) {
            
            JBWLCourseTitleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseTitleTableCell class])];
            cell.courseType = self.courseType;
            return cell;
        }
        if (indexPath.section == 1) {
            JBWLCourseDetailSoundTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseDetailSoundTableCell class])];
            return cell;
        }
        else  {
            
            JBWLCourseDetailCourseInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseDetailCourseInfoTableCell class])];
            cell.contentString = contString;
            return cell;
        }
    }
    
    else{
        JBWLCourseDetailHeaderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseDetailHeaderTableCell class])];
        return cell;
    }
    
//    if (indexPath.section == 0) {
//
//
//        JBWLCourseDetailHeaderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseDetailHeaderTableCell class])];
//        return cell;
//    }
//    else if (indexPath.section == 1) {
//
//        JBWLCourseTitleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseTitleTableCell class])];
//        return cell;
//    }
//
//   else if (indexPath.section == 2) {
//
//        JBWLCourseDetailSoundTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseDetailSoundTableCell class])];
//        return cell;
//    }
//
//    else{
//        JBWLCourseDetailCourseInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseDetailCourseInfoTableCell class])];
//        cell.contentString = contString;
//        return cell;
//    }
    
    
}

- (void)_setNav{
    
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = colorF3F3F3;
    XFQNavigationView  *nav =  [[XFQNavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, WQ_StatusBarAndNavigationBarHeight) leftImageName:@"JbAPP_Back" leftTitle:nil title:@"课程详情" target:self action:@selector(gotoBack) showBottomLine:YES];
    [self.view addSubview:nav];
    
    UIButton *courseManagerButton =[UIButton createButtonWithFrame:CGRectZero withTitle:@"分享" withTitleColor:color666666 withTitleFont:kSpaceH(13) withBackgroundColor:nil withTarget:self withAction:@selector(shareButtonAction:)];
    [nav addSubview:courseManagerButton];
    [courseManagerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nav.titleLabel);
        make.right.mas_equalTo(nav.mas_right).mas_offset(-kSpaceW(15));
    }];
}
- (void)_courseDetailTableView{
    _courseDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WQ_StatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - WQ_TabbarSafeBottomMargin - 50) style:UITableViewStyleGrouped];
    [self.view addSubview:_courseDetailTableView];
    _courseDetailTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _courseDetailTableView.delegate = self;
    _courseDetailTableView.dataSource = self;
    _courseDetailTableView.estimatedRowHeight = 100;
    _courseDetailTableView.rowHeight = UITableViewAutomaticDimension;
    _courseDetailTableView.estimatedSectionFooterHeight =
    _courseDetailTableView.estimatedSectionHeaderHeight = 0.01;
    _courseDetailTableView.separatorColor = [UIColor clearColor];
    _courseDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        _courseDetailTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    
    [_courseDetailTableView registerClass:[JBWLCourseDetailCourseInfoTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLCourseDetailCourseInfoTableCell class])];
    
    [_courseDetailTableView registerClass:[JBWLCourseTitleTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLCourseTitleTableCell class])];

    
    [_courseDetailTableView registerClass:[JBWLCourseDetailSoundTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLCourseDetailSoundTableCell class])];
    
    [_courseDetailTableView registerClass:[JBWLCourseDetailHeaderTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLCourseDetailHeaderTableCell class])];
    
    
//    JBWLSubscribeBottomView *bottomView = [[JBWLSubscribeBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - WQ_TabbarSafeBottomMargin - 50, kScreenWidth, 50)];
//    [self.view addSubview:bottomView];
//
//    bottomView.chatBlock = ^{
//
//    };
//
//    bottomView.buyBlock = ^{
//        [self addChildViewController:self.buyChooseVC];
//        [self.view addSubview:self.buyChooseVC.view];
//        [self.buyChooseVC didMoveToParentViewController:self];
//    };
}

- (JBWLCourseDetailHeaderView *)detailHeaderView{
    if (!_detailHeaderView) {
        _detailHeaderView = [[JBWLCourseDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSpaceH(210))];
    }
    return _detailHeaderView;
}

@end
