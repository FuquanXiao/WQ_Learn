//
//  MineViewController.m
//  JBApp
//
//  Created by apple on 2018/10/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MineViewController.h"
#import "MineViewTableCell.h"
#import "MineViewModel.h"
#import "MineHeaderView.h"
#import "WQBaseWebViewController.h"
#import "SettingController.h"
#import "MineCenterController.h"
#import "DynamicDetailController.h"
#import "JBWalletController.h"
#import "PasswordSetController.h"
#import "PayViewModel.h"
#import "PreviewViewController.h"
#import "APPCommentController.h"
#import "BaseTabbarController.h"
#import "AuthorityUpdateController.h"
#import "MineCenterViewModel.h"




///课程管理
#import "JBWLCourseManageController.h"
///我教的课
#import "JBWLCourseTeachOederController.h"
///我约的课
#import "JBWLAppointCourseManageController.h"

///订单管理
#import "JBWLCourseOrderManagerController.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,MineHeaderViewDelegate>
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)NSArray *daaSourceArray;
@property (nonatomic,strong)MineHeaderView *headerView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.daaSourceArray = [MineViewModel getMineVieTitleName];
    [self _creteUI];
   
    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setData];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)mineHeaderViewItemMenuDidSelected:(NSInteger)index{
    switch (index) {
        case 0:///我约的课
        {
            JBWLAppointCourseManageController * courseManagerController = [[JBWLAppointCourseManageController alloc] init];
            [self.navigationController pushViewController:courseManagerController animated:YES];
        }
            break;
        case 1:///我教的课
        {
            JBWLCourseOrderManagerController * courseManagerController = [[JBWLCourseOrderManagerController alloc] init];
            [self.navigationController pushViewController:courseManagerController animated:YES];
        }
            break;
        case 2:///我的收藏
        {
            
        }
            break;
        default:
            break;
    }
    
}

- (void)headerTapHandle:(UITapGestureRecognizer *)gesture{
    MineCenterController *mineCenter = [[MineCenterController alloc] init];
    mineCenter.userId = SafeValue(UserConfig.userId);
    [self.navigationController pushViewController:mineCenter animated:YES];
}

- (void)qianDaoAction:(UIButton *)btn{
    WQBaseWebViewController *alipy = [[WQBaseWebViewController alloc] init];
    alipy.urlString = [NSString stringWithFormat:@"%@%@",H5Domain,h5QianDao];
    alipy.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:alipy animated:YES];
}

- (void)setButtonAction:(UIButton *)btn{
    SettingController *set = [[SettingController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            JBWLCourseManageController *alipy = [[JBWLCourseManageController alloc] init];
            [self.navigationController pushViewController:alipy animated:YES];
        }
    }
    
    
    
    
    
    return;
    
    if (indexPath.section == 0) {//我的收藏
        
        if (IS_REVIEW) {
            if (indexPath.row ==0) {
                WQBaseWebViewController *alipy = [[WQBaseWebViewController alloc] init];
                alipy.urlString = [NSString stringWithFormat:@"%@%@",H5Domain,h5MyCollection];
                alipy.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:alipy animated:YES];
            }
        }
        else{
            if (indexPath.row == 0) {
                WQBaseWebViewController *alipy = [[WQBaseWebViewController alloc] init];
                alipy.urlString = [NSString stringWithFormat:@"%@%@",H5Domain,h5CourseStudy];
                alipy.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:alipy animated:YES];
            }
            if (indexPath.row == 1) {
                WQBaseWebViewController *alipy = [[WQBaseWebViewController alloc] init];
                alipy.urlString = [NSString stringWithFormat:@"%@%@",H5Domain,h5MyCollection];
                alipy.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:alipy animated:YES];
            }
        }
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            [PayViewModel loadGetHadSetPasswordConpletion:^(NSString *dataString, NSString *errorString) {
                if (dataString.integerValue == 1) {
                    JBWalletController *walletController = [[JBWalletController alloc] init];
                    [self.navigationController pushViewController:walletController animated:YES];
                }
                else{
                    PasswordSetController *walletController = [[PasswordSetController alloc] init];
                    [self.navigationController pushViewController:walletController animated:YES];
                }
            }];
        }
        
//        我的优惠券
        if (indexPath.row == 1) {
            WQBaseWebViewController *alipy = [[WQBaseWebViewController alloc] init];
            alipy.urlString = [NSString stringWithFormat:@"%@%@",H5Domain,h5MyCoupon];
            alipy.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:alipy animated:YES];
            
        }
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            WQBaseWebViewController *alipy = [[WQBaseWebViewController alloc] init];
            alipy.urlString = [NSString stringWithFormat:@"%@%@",H5Domain,h5DistributeClass];
            alipy.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:alipy animated:YES];
        }
        
//        我的访客
        if (indexPath.row == 1) {
            WQBaseWebViewController *alipy = [[WQBaseWebViewController alloc] init];
            alipy.urlString = [NSString stringWithFormat:@"%@%@",H5Domain,h5Mycustom];
            alipy.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:alipy animated:YES];
        }
    }
    if (indexPath.section == 3) {
        /// 邀请加入
        if (indexPath.row == 0) {
            WQBaseWebViewController *alipy = [[WQBaseWebViewController alloc] init];
            alipy.urlString = [NSString stringWithFormat:@"%@%@/%@",H5Domain,h5InviteJionInUs,UserConfig.userId];
            alipy.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:alipy animated:YES];
        }
        
        if (indexPath.row == 1) {
            AuthorityUpdateController *authorityUpdate = [[AuthorityUpdateController alloc] init];
             [self.navigationController pushViewController:authorityUpdate animated:YES];
        }
        
    }
    
    if (indexPath.section == 4) {
        ///常见问题
        if (indexPath.row == 0) {
            WQBaseWebViewController *alipy = [[WQBaseWebViewController alloc] init];
            alipy.urlString = [NSString stringWithFormat:@"%@%@",H5Domain,h5MyQuestion];
            alipy.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:alipy animated:YES];
        }
        if (indexPath.row == 1) {
            
            BaseTabbarController *barVc = (BaseTabbarController*) APPDeleate.window.rootViewController;
            APPCommentController *appComment = [[APPCommentController alloc] init];
            appComment.vc = self;
            [barVc.view addSubview:appComment.view];
            [barVc addChildViewController:appComment];
            [barVc didMoveToParentViewController:barVc];
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.daaSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSpaceH(42);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionArray = self.daaSourceArray[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineViewTableCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineViewTableCell class])];
    NSArray *sectionArray = self.daaSourceArray[indexPath.section];
    NSString *title = sectionArray[indexPath.row];
    cell.cellTitleLabel.text = title;
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Mine_%@",title]];
    cell.nextButton.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return kSpaceW(8);
    }
   return kSpaceH(5);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    return 0.01;
}
- (void)_creteUI{
    
    [self.view addSubview:self.myTableView];

    MineHeaderView *headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSpaceH(202) + WQ_StatusBarHeight)];
    self.headerView = headerView;
    headerView.delegate = self;
    [headerView setUserModel:UserConfig.userModel];

    [headerView.setButton addTarget:self action:@selector(setButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapHandle:)];
    [headerView.icomImageView addGestureRecognizer:headerTap];
    
    [self.headerView.qianDaoButton addTarget:self action:@selector(qianDaoAction:) forControlEvents:UIControlEventTouchUpInside];
    self.myTableView.tableHeaderView = headerView;
    
    
}
- (void)loadMineCenterWithUserId:(NSString *)userId sourceType:(NSString *)sourceType{
    [MineCenterViewModel loadPersonInfoWithUserId:userId sourceType:sourceType completoion:^(UserModel *userModel, NSArray *array,NSString *classCount, NSString *des) {
        if (userModel) {
            self.headerView.activeLabel.text = [NSString stringWithFormat:@"活跃值:%@",SafeValue(userModel.activeValue)];
        }
    }];
}

- (void)setData{
    [self.headerView.icomImageView sd_setImageWithURL:[NSURL URLWithString:UserConfig.userModel.headPic] placeholderImage:[UIImage imageWithColor:colorE7E7E7]];

    
    self.headerView.nameLabel.text = UserConfig.userModel.nickName;
  
    /// 我的界面名师老师导师图标区分
    if ([UserConfig.userModel.userLevel integerValue] == 2) {
        self.headerView.leavelImageView.image = [UIImage imageNamed:@"HomePage_老师"];
    }
    if ([UserConfig.userModel.userLevel integerValue] == 3) {
        self.headerView.leavelImageView.image = [UIImage imageNamed:@"TeachDoJo_名师"];
    }
    if ([UserConfig.userModel.userLevel integerValue] == 4) {
        self.headerView.leavelImageView.image = [UIImage imageNamed:@"TeachDoJo_导师"];
    }
    if ([SafeValue(UserConfig.userModel.userLevel) integerValue] == 7) {
        self.headerView.leavelImageView.image = [UIImage imageNamed:@"hangjia_hangjia"];
    }

    [self loadMineCenterWithUserId:@"" sourceType:@""];
}
- (UITableView *)myTableView{
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - WQ_TabbarHeight ) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = kUIColorFromRGB(0xf4f4f4);
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorColor = kUIColorFromRGB(0xf4f4f4);
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.estimatedRowHeight = kSpaceW(42);
        _myTableView.showsVerticalScrollIndicator = NO;
        [_myTableView registerClass:[MineViewTableCell class] forCellReuseIdentifier:NSStringFromClass([MineViewTableCell class])];
    }
    return _myTableView;
}

@end
