//
//  ViewController.m
//  XFQItemButton
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "ViewController.h"
#import "WQPathItemMenu.h"
#import "WQPathItemView.h"
#import "YCMenuView.h"
#import "JXCategoryTitleView.h"
#import "JXCategoryIndicatorLineView.h"
#import "WQSlipMenuView.h"

@interface ViewController ()<WQPathItemMenuDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic, strong) NSArray <NSString *> *headerTitles;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic, strong) JXCategoryTitleView *pinCategoryView;
@property (nonatomic,strong)WQPathItemMenu *boomButton ;
@property (nonatomic,strong)NSMutableArray *arr;
@property (nonatomic,strong)UITableView *myTableview;
@property (nonatomic,strong)NSMutableArray *titleLabelArray;
@property (nonatomic,strong)NSMutableArray *headerFrameArray;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self test1];
//    self.headerTitles = @[@"我的频道", @"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事"];
//
//    self.dataSource = @[@[@"1",@"2",@"2",@"2",@"2",@"2",@"2",@"2"],@[@"1",@"2",@"2",@"2",@"2",@"2",@"2",@"2"],@[@"1",@"2",@"2",@"2",@"2",@"2",@"2",@"2"],@[@"1",@"2",@"2",@"2",@"2",@"2",@"2",@"2"],@[@"1",@"2",@"2",@"2",@"2",@"2",@"2",@"2"],@[@"1",@"2",@"2",@"2",@"2",@"2",@"2",@"2"],@[@"1",@"2",@"2",@"2",@"2",@"2",@"2",@"2"]];
    _pinCategoryView = [[JXCategoryTitleView alloc] init];
//    self.pinCategoryView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
//    self.pinCategoryView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
//    self.pinCategoryView.titles = @[@"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事"];
//    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//    lineView.verticalMargin = 15;
//    self.pinCategoryView.indicators = @[lineView];
//    self.pinCategoryView.delegate = self;
//    [self.view addGestureRecognizer:_pinCategoryView];
    
    self.titleLabelArray = [NSMutableArray array];
    self.headerFrameArray = [[NSMutableArray alloc] initWithObjects:@(0),@(0),@(0),@(0),@(0),@(0),@(0), nil];
    
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 60)];
//    titleView.backgroundColor = [UIColor cyanColor];
    
//    for (int i = 0; i<7; i++) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 414/7.0, 0, 414/7.0, 60)];
//        label.text = [NSString stringWithFormat:@"%d",i];
//        [titleView addSubview:label];
//        label.layer.borderColor = [UIColor redColor].CGColor;
//        label.layer.borderWidth = 1;
//        label.textAlignment = NSTextAlignmentCenter;
//        [self.titleLabelArray addObject:label];
//
//    }
    
    WQSlipMenuView *menuView = [[WQSlipMenuView alloc] initWithFrame:CGRectMake(0, 0, 414, 60)];
    [self.view addSubview:menuView];
    menuView.titleArray = @[@"名师讲堂",@"IT/AI技术",@"经验技能",@"说文解字",@"天文历法",@"数据分析",@"医学/健康"];
    
    
//
//    [self.view addSubview:titleView];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, 414, 736) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:tableview];
    self.myTableview = tableview;
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 414, 0, 414/7.0, 40)];
    label.text = [NSString stringWithFormat:@"%ld",(long)section];
    label.backgroundColor = [UIColor redColor];
    NSLog(@"section === %ld ===%@",(long)section,NSStringFromCGRect([tableView rectForSection:section]));
    
    CGRect rrr =  [tableView rectForSection:section];
    
    [self.headerFrameArray replaceObjectAtIndex:section withObject:@(rrr.origin.y)];
    
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"contentOffset === %f",scrollView.contentOffset.y);
    
    NSIndexPath * indexPath = [(UITableView *)scrollView  indexPathForRowAtPoint:CGPointMake(0, scrollView.contentOffset.y)];
    NSLog(@"滑到了第 %ld 组 %ld个",indexPath.section, indexPath.row);
//   NSIndexPath * _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
//    [_leftTableView reloadData];
//    [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
//    
   
    

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{    
    
    
   
    
   
    [self.boomButton expandAnimation];

    
    
}


- (WQPathItemMenu *)boomButton{
    if (!_boomButton) {
        _boomButton =  [[WQPathItemMenu alloc] initWithFrame:CGRectMake(414 - 60, 300, 60, 60)];
        _boomButton.delegate = self;
        WQPathItemView *itemOne = [[WQPathItemView alloc] init];
        
        WQPathItemView *itemTwo = [[WQPathItemView alloc] init];
        WQPathItemView *itemThree = [[WQPathItemView alloc] init];
        WQPathItemView *itemFourth = [[WQPathItemView alloc] init];
        [_boomButton showItemsButtonWithArray:[@[itemOne,itemTwo,itemThree,itemFourth] mutableCopy]];
    }
    return _boomButton;
    
}


- (void)actionAAAA:(UIButton *)sender{
    
    YCMenuView *view = [YCMenuView menuWithActions:self.arr width:112 relyonView:sender];
    [view show];
}


- (void)actionBBBB{
    
    [self.view addSubview:self.boomButton];
    [self.boomButton expandAnimation];
}

- (void)wq_pathItemMenuSelectedIndex:(NSInteger)index{
    NSLog(@"index===%ld",(long)index);
}





- (void)test1{
    
    UIButton * sendItem = [[UIButton alloc] initWithFrame:CGRectMake(414 - 80, 20, 60, 44)];
    
    [self.view addSubview:sendItem];
    sendItem.backgroundColor = [UIColor redColor];
    
    [sendItem addTarget:self action:@selector(actionAAAA:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [UIImage imageNamed:@"ic_filter_category_0"];
    
    YCMenuAction *action = [YCMenuAction actionWithTitle:@"首页" image:image handler:^(YCMenuAction *action) {
        NSLog(@"点击了%@",action.title);
    }];
    YCMenuAction *action1 = [YCMenuAction actionWithTitle:@"个人" image:image handler:^(YCMenuAction *action) {
        NSLog(@"点击了%@",action.title);
    }];
    YCMenuAction *action2 = [YCMenuAction actionWithTitle:@"最新" image:image handler:^(YCMenuAction *action) {
        NSLog(@"点击了%@",action.title);
    }];
    YCMenuAction *action3 = [YCMenuAction actionWithTitle:@"搜索页" image:image handler:^(YCMenuAction *action) {
        NSLog(@"点击了%@",action.title);
    }];
    YCMenuAction *action4 = [YCMenuAction actionWithTitle:@"新闻页" image:image handler:^(YCMenuAction *action) {
        NSLog(@"点击了%@",action.title);
    }];
    
    self.arr = [@[action,action1,action2,action3,action4] copy];
    
    
    
    
    UIButton * sendAttribute = [[UIButton alloc] initWithFrame:CGRectMake(414 - 60, 300, 60, 60)];
    
    [self.view addSubview:sendAttribute];
    sendAttribute.backgroundColor = [UIColor redColor];
    
    [sendAttribute addTarget:self action:@selector(actionBBBB) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
