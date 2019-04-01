//
//  JBWLCourseManageController.m
//  JBApp
//
//  Created by apple on 2019/3/25.
//  Copyright © 2019 apple. All rights reserved.
//课程管理

#import "JBWLCourseManageController.h"

#import "XFQNavigationView.h"

#import "JBWLCourseListTableCell.h"

#import "JBWLPublishController.h"

@interface JBWLCourseManageController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *courseTableView;
@end

@implementation JBWLCourseManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setNav];
    [self.view addSubview:self.courseTableView];
    
    [self _createUI];
}

- (void)nextButtonAction:(UIButton *)nextButton{
    JBWLPublishController *jbwlPublishCourse = [[JBWLPublishController alloc] init];
    [self.navigationController pushViewController:jbwlPublishCourse animated:YES];
}


- (void)gotoBack{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSpaceH(146);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSArray *sectionArray = self.daaSourceArray[section];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JBWLCourseListTableCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLCourseListTableCell class])];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return kSpaceH(5);
}

- (void)_setNav{
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = colorFFFFFF;
    XFQNavigationView  *nav =  [[XFQNavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, WQ_StatusBarAndNavigationBarHeight) leftImageName:@"JbAPP_Back" leftTitle:nil title:@"课程管理" target:self action:@selector(gotoBack) showBottomLine:YES];
    [self.view addSubview:nav];
}

- (void)_createUI{
    UIButton *nextbutton = [[UIButton alloc] initWithFrame:CGRectMake(20, 4.5, 150 , 40)];
    [nextbutton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [nextbutton setTitle:@"添 加 课 程" forState:UIControlStateNormal];
    nextbutton.backgroundColor = color00CCBB;
    [nextbutton setImage:[UIImage imageNamed:@"TeachDoJo_机构"] forState:UIControlStateNormal];
    nextbutton.titleLabel.font = [UIFont boldSystemFontOfSize:kSpaceW(15)];
    [nextbutton setTitleColor:colorFFFFFF forState:UIControlStateNormal];
    nextbutton.layer.cornerRadius = 17.5;
    nextbutton.clipsToBounds = YES;
    [self.view addSubview:nextbutton];
    [nextbutton setImagePosition:ImageLabelPositionLeft spacing:6];
    nextbutton.adjustsImageWhenHighlighted = NO;
    [nextbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.courseTableView.mas_bottom).mas_offset(7);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(170);
    }];
}

- (UITableView *)courseTableView{
    
    if (!_courseTableView) {
        _courseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, WQ_StatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight  - WQ_StatusBarAndNavigationBarHeight - WQ_TabbarHeight) style:UITableViewStyleGrouped];
        _courseTableView.backgroundColor = kUIColorFromRGB(0xf4f4f4);
        _courseTableView.delegate = self;
        _courseTableView.dataSource = self;
        _courseTableView.separatorColor = kUIColorFromRGB(0xf4f4f4);
        _courseTableView.estimatedSectionHeaderHeight = 0;
        _courseTableView.estimatedSectionFooterHeight = kSpaceH(5);
        _courseTableView.estimatedRowHeight = kSpaceW(146);
        _courseTableView.showsVerticalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            _courseTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }

        [_courseTableView registerClass:[JBWLCourseListTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLCourseListTableCell class])];
    }
    return _courseTableView;
}


@end
