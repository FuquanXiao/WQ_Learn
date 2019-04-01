//
//  JBWLBuyChooseTimeController.m
//  JBApp
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 apple. All rights reserved.
//立即购买 选择时间
#define DatePickerHeight 216

#import "JBWLBuyChooseTimeController.h"
#import "XFQNavigationView.h"
#import "JBWLBuyChooseTimeTableCell.h"
#import "JBWLAddTimeView.h"
#import "HYTimePickerView.h"

#import "JBWLCourseTimeViewModel.h"

@interface JBWLBuyChooseTimeController ()<UITableViewDelegate,UITableViewDataSource,TimePickerViewDelegate>
@property (nonatomic,strong)UITableView *timeAxisTableView;
@property (nonatomic,strong)JBWLCourseTimeViewModel *courseTimeViewModel;
@property (nonatomic,strong)NSMutableArray *timeWeekKeyArray;
@property (nonatomic,strong)NSMutableArray *timeSourceArray;
@property (nonatomic,strong)NSMutableDictionary *timeWeekValueDict;


@property (strong, nonatomic) HYTimePickerView *dateView;

@property (nonatomic,strong)JBWLAddTimeView *addTimeView;

///记录当前选中的是开始时间 结束时间
@property (nonatomic,assign)NSInteger timeSelectedButtonIndex;

///记录当前选中的是星期几
@property (nonatomic,assign)NSInteger timeSelectedWeek;

///开始时间
@property (nonatomic,strong)NSString *startTimeString;
///结束时间
@property (nonatomic,strong)NSString *endTimeString;
@end

@implementation JBWLBuyChooseTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setNav];
    [self configInit];
    [self _createTableView];
    [self loadDataSourceRequest];
}

- (void)configInit{
    self.endTimeString = @"";
    self.startTimeString = @"";
}

#pragma mark
#pragma mark-------Action: -------
- (void)addTimeAction:(UIButton *)btn{
    self.timeSelectedWeek = btn.tag;
    [self.navigationController.view addSubview:self.addTimeView];
}


- (void)selectedButtonAction:(UIButton *)btn{
    
    if (self.timeType == JBWLBuyChooseTimeTypeAdd) {
        NSString *keyString = self.timeWeekKeyArray[btn.indexPath.section];
        
        NSMutableArray *modelArray = self.timeWeekValueDict[keyString];
        
        JBWLCourseTimeModel *model = modelArray[btn.indexPath.row];
        [self loadDeleteTimeWithTimeId:SafeValue(model.classId)];
    }
    else{
        
        
        JBWLCourseTimeModel *sectionModel = self.timeSourceArray[btn.indexPath.section];
        JBWLCourseTimeModel *rowModel = sectionModel.scheduleList[btn.indexPath.row];
        
        for (JBWLCourseTimeModel *tempRowModel in sectionModel.scheduleList) {
            tempRowModel.hadSelected = NO;
        }
        rowModel.hadSelected = YES;
        if (self.chooseIdBlock) {
            self.chooseIdBlock(rowModel);
        }
        [self.timeAxisTableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
    }
    

}


- (void)chooseTimeAction:(UIButton *)btn{

    switch (btn.tag) {
        case 456:///开始时间
        case 457:///结束时间
        {
            [self.navigationController.view addSubview:self.dateView];
            [UIView animateWithDuration:0.3 animations:^{
                self.dateView.frame = CGRectMake(0, kScreenHeight - DatePickerHeight, kScreenWidth,DatePickerHeight);
                [self.dateView show];
            }];
            self.timeSelectedButtonIndex = btn.tag;
        }
            break;
        case 458:///确认添加
        {
            if (self.startTimeString.length<1 || self.endTimeString.length<1) {
                 UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"时间设置不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return;
            }
            
            __weak typeof(self) weakSelf = self;
            [_courseTimeViewModel loadAddCourseTimeWithWeekday:[NSString stringWithFormat:@"%ld",(self.timeSelectedWeek + 1)] andStartTime:SafeValue(_startTimeString) andEndTime:SafeValue(_endTimeString) completion:^(id model, NSString *desString) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                if (desString) {
                    [strongSelf showHudMessage:desString hidenAfterDelay:1];
                }
                else{
                    [strongSelf.addTimeView removeFromSuperview];
                    [strongSelf loadTeacherSelfTimeListRequest];
                    [strongSelf configInit];
                }
            }];
        }
            break;
        default:
            break;
    }
}


- (void)loadDataSourceRequest{
    
    if (self.timeType == JBWLBuyChooseTimeTypeAdd) {
        [self loadTeacherSelfTimeListRequest];
    }
    if (self.timeType == JBWLBuyChooseTimeChoose) {
        [self loadStudentGetTeacherTimeListRequestWithUserId:self.userId];
    }
}


- (void)loadDeleteTimeWithTimeId:(NSString *)timeId{
    
    __weak typeof(self) weakSelf = self;

    [_courseTimeViewModel loadDelUsersScheduleWithUserId:timeId completion:^(id model, NSString *desString) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (desString) {
            [strongSelf showHudMessage:desString hidenAfterDelay:1];
        }
        else{
            [strongSelf loadTeacherSelfTimeListRequest];
        }
    }];
}


#pragma mark
#pragma mark-------获取时间列表 -------
- (void)loadTeacherSelfTimeListRequest{
     __weak typeof(self) weakSelf = self;
    [_courseTimeViewModel loadGetTeachTimeScheduleCompletion:^(id model, NSString *desString) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf.timeSourceArray removeAllObjects];
        [strongSelf.timeWeekValueDict removeAllObjects];
        if (desString) {
            [strongSelf showHudMessage:desString hidenAfterDelay:1];
        }
        else{
            NSMutableArray  *temTimeArray = [(NSMutableArray *)model copy];
            
            for (JBWLCourseTimeModel *model in temTimeArray) {
                [strongSelf.timeSourceArray addObject:model];
                NSString *weekString = SafeValue(model.weekdayString);
                
                NSMutableArray *valueArray = strongSelf.timeWeekValueDict[weekString];
                if (!valueArray) {
                    valueArray = [[NSMutableArray alloc] init];
                    [strongSelf.timeWeekValueDict setValue:valueArray forKey:weekString];
                }
                [valueArray addObject:model];
            }
            [self.timeAxisTableView reloadData];
        }
    }];
}
#pragma mark
#pragma mark-------学生选课时获取老师的时间列表 -------
- (void)loadStudentGetTeacherTimeListRequestWithUserId:(NSString *)userid{
    
    __weak typeof(self) weakSelf = self;

    [_courseTimeViewModel loadStuedentGetTeachTimeScheduleWithUserId:userid completion:^(id model, NSString *desString) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf.timeSourceArray removeAllObjects];
        [strongSelf.timeWeekValueDict removeAllObjects];
        if (desString) {
            [strongSelf showHudMessage:desString hidenAfterDelay:1];
        }
        else{
            NSMutableArray  *temTimeArray = [(NSMutableArray *)model copy];
            
            for (JBWLCourseTimeModel *model in temTimeArray) {
                
                
                for (JBWLCourseTimeModel *rowModel in model.scheduleList) {
                    if ([SafeValue(rowModel.classId) isEqualToString:SafeValue(self.hadSelectedTimeModel.classId)]) {
                        rowModel.hadSelected = YES;
                    }
                }

                [strongSelf.timeSourceArray addObject:model];
            }
            [self.timeAxisTableView reloadData];
        }
    }];
}



- (void)gotoBack{
    [self.navigationController popViewControllerAnimated:YES];
}


//通过协议将选中的时间返回
-(void)timePickerViewDidSelectRow:(NSString *)time{
    
    if (self.timeSelectedButtonIndex == 456) {
        self.startTimeString = time;

        [self.addTimeView.minTextField setTitle:time forState:UIControlStateNormal];
    }
    if (self.timeSelectedButtonIndex == 457) {

        self.endTimeString = time ;

        [self.addTimeView.maxTextField setTitle:time forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, DatePickerHeight);
    }];
    
    
    
}



- (void)_setNav{
    _courseTimeViewModel = [[JBWLCourseTimeViewModel alloc] init];
    self.view.backgroundColor = colorF3F3F3;
    self.fd_prefersNavigationBarHidden = YES;
    XFQNavigationView  *nav =  [[XFQNavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, WQ_StatusBarAndNavigationBarHeight) leftImageName:@"JbAPP_Back" leftTitle:nil title:@"选择上课时间" target:self action:@selector(gotoBack) showBottomLine:YES];
    if (self.timeType == JBWLBuyChooseTimeTypeAdd) {
        nav = [[XFQNavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, WQ_StatusBarAndNavigationBarHeight) leftImageName:@"JbAPP_Back" leftTitle:nil title:@"设置上课时间" target:self action:@selector(gotoBack) showBottomLine:NO];
    }
    
    [self.view addSubview:nav];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JBWLBuyChooseTimeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JBWLBuyChooseTimeTableCell class]) forIndexPath:indexPath];
    
    cell.selectedButton.indexPath = indexPath;
    [cell.selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.timeType = self.timeType;
    
    if (self.timeType == JBWLBuyChooseTimeTypeAdd) {
        NSString *keyString = self.timeWeekKeyArray[indexPath.section];
        
        NSMutableArray *modelArray = self.timeWeekValueDict[keyString];
        
        JBWLCourseTimeModel *timeModel = modelArray[indexPath.row];
        cell.timeModel = timeModel;
    }
    else{
        JBWLCourseTimeModel *sectionModel = self.timeSourceArray[indexPath.section];
        JBWLCourseTimeModel *rowModel = sectionModel.scheduleList[indexPath.row];
        cell.timeModel = rowModel;
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 52;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.timeType == JBWLBuyChooseTimeTypeAdd) {
        return 7;
    }
    else{
        return self.timeSourceArray.count;
    }
    
    return 7;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return  45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.timeType == JBWLBuyChooseTimeTypeAdd) {
        NSString *keyString = self.timeWeekKeyArray[section];
        NSMutableArray *modelArray = self.timeWeekValueDict[keyString];
        return modelArray.count;
    }
    
    else{
        JBWLCourseTimeModel *model = self.timeSourceArray[section];
        NSArray *modelArray = model.scheduleList;
        return modelArray.count;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JBWLBuyChooseTimeSectionView *sectionView = [[JBWLBuyChooseTimeSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45) andTimeType:self.timeType];
   
    if (self.timeType == JBWLBuyChooseTimeTypeAdd) {
        sectionView.contentLabel.text = self.timeWeekKeyArray[section];
        sectionView.selectedButton.tag = section;
        [sectionView.selectedButton addTarget:self action:@selector(addTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        JBWLCourseTimeModel *model = self.timeSourceArray[section];
        sectionView.contentLabel.text = SafeValue(model.chooseWeekdayString);
    }
    
    
    return sectionView;
}






- (void)_createTableView{
    _timeAxisTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WQ_StatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - WQ_StatusBarAndNavigationBarHeight - WQ_TabbarSafeBottomMargin) style:UITableViewStyleGrouped];
    
    if (_timeType == JBWLBuyChooseTimeTypeAdd) {
        _timeAxisTableView.frame = CGRectMake(5, WQ_StatusBarAndNavigationBarHeight + 8, kScreenWidth - 10, kScreenHeight - WQ_StatusBarAndNavigationBarHeight - WQ_TabbarSafeBottomMargin - 8);
    }
    
    [self.view addSubview:_timeAxisTableView];
    _timeAxisTableView.delegate = self;
    _timeAxisTableView.dataSource = self;
    _timeAxisTableView.separatorColor = colorFFFFFF;
    _timeAxisTableView.estimatedSectionHeaderHeight = 0;
    _timeAxisTableView.estimatedSectionFooterHeight = 0;
    _timeAxisTableView.estimatedRowHeight = kSpaceW(43);
    _timeAxisTableView.bounces = NO;
    [_timeAxisTableView registerClass:[JBWLBuyChooseTimeTableCell class] forCellReuseIdentifier:NSStringFromClass([JBWLBuyChooseTimeTableCell class])];
}

- (NSMutableArray *)timeSourceArray{
    if (!_timeSourceArray) {
        _timeSourceArray = [[NSMutableArray alloc] init];
    }
    return _timeSourceArray;
}


- (NSMutableArray *)timeWeekKeyArray{
    if (!_timeWeekKeyArray) {
        _timeWeekKeyArray = [@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"] mutableCopy];
    }
    return _timeWeekKeyArray;
}

- (NSMutableDictionary *)timeWeekValueDict{
    if (!_timeWeekValueDict) {
        _timeWeekValueDict = [@{
                                @"周一":[@[] mutableCopy],
                                @"周二":[@[] mutableCopy],
                                @"周三":[@[] mutableCopy],
                                @"周四":[@[] mutableCopy],
                                @"周五":[@[] mutableCopy],
                                @"周六":[@[] mutableCopy],
                                @"周日":[@[] mutableCopy]
                                } mutableCopy];
    }
    return _timeWeekValueDict;
}
- (JBWLAddTimeView *)addTimeView{
    if (!_addTimeView) {
        _addTimeView = [[JBWLAddTimeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_addTimeView.minTextField addTarget:self action:@selector(chooseTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addTimeView.maxTextField addTarget:self action:@selector(chooseTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addTimeView.nextbutton addTarget:self action:@selector(chooseTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addTimeView;
}

- (HYTimePickerView *)dateView{
    if (!_dateView) {
        _dateView =  [[HYTimePickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 216) andMinDuiration:5];
        _dateView.delegate = self;
    }
    return _dateView;
}
@end
